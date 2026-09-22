"""Find content that is cut off at the screen edge (hidden by overflow:clip, so scrollWidth stays ok).

usage:
  uv run --with websocket-client python tools/clipcheck.py <port> <file.html> [<file.html> ...] [--widths 390,360]

For each file and width: loads the page in its own headless Chrome, scrolls through (so reveals fire),
then lists
  TEXT  elements with visible text whose box sticks out left/right of the viewport (px outside)
  ICON  svg/img graphics that are partly outside the viewport (share of width visible)
Decorative shapes that are meant to bleed off the edge (aria-hidden svgs with class par/arch) are marked "(deko)".
"""
import json, sys, time, urllib.request, os, subprocess
import websocket

args = sys.argv[1:]
widths = [390, 360]
if "--widths" in args:
    i = args.index("--widths"); widths = [int(x) for x in args[i + 1].split(",")]; del args[i:i + 2]
port, files = int(args[0]), [os.path.abspath(a) for a in args[1:]]
CH = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
prof = f"/tmp/clipcheck-chrome-{port}"

def up():
    try: urllib.request.urlopen(f"http://localhost:{port}/json/version", timeout=1); return True
    except Exception: return False
if not up():
    subprocess.Popen([CH, "--headless=new", "--disable-gpu", "--hide-scrollbars", "--no-first-run",
                      f"--remote-debugging-port={port}", f"--user-data-dir={prof}", "about:blank"],
                     stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    for _ in range(40):
        if up(): break
        time.sleep(.25)
page = next(t for t in json.loads(urllib.request.urlopen(f"http://localhost:{port}/json/list").read()) if t["type"] == "page")
ws = websocket.create_connection(page["webSocketDebuggerUrl"], suppress_origin=True)
mid = 0
def send(m, **p):
    global mid; mid += 1; ws.send(json.dumps({"id": mid, "method": m, "params": p}))
    while True:
        r = json.loads(ws.recv())
        if r.get("id") == mid: return r.get("result", {})
def ev(js): return send("Runtime.evaluate", expression=js, returnByValue=True)["result"].get("value")
send("Page.enable"); send("Runtime.enable"); send("Page.bringToFront"); send("Emulation.setFocusEmulationEnabled", enabled=True)

PROBE = r"""(() => {
  const iw = innerWidth, out = [];
  const name = e => e.tagName.toLowerCase() + (e.className && typeof e.className === 'string' ? '.' + e.className.trim().split(/\s+/).slice(0,2).join('.') : '');
  const path = e => { const p=[]; let x=e; for(let i=0;i<3&&x&&x!==document.body;i++){p.unshift(name(x)); x=x.parentElement;} return p.join(' > '); };
  const deco = e => !!e.closest('[aria-hidden="true"]');
  for (const e of document.querySelectorAll('.ws27 *')) {
    const cs = getComputedStyle(e);
    if (cs.display === 'none' || cs.visibility === 'hidden') continue;
    const hasText = [...e.childNodes].some(n => n.nodeType === 3 && n.textContent.trim().length > 1);
    const isGfx = e.tagName === 'svg' || e.tagName === 'IMG';
    if (!hasText && !isGfx) continue;
    const r = e.getBoundingClientRect();
    if (r.width < 2 || r.height < 2) continue;
    const over = Math.max(0, r.right - iw), under = Math.max(0, -r.left);
    if (over < 2 && under < 2) continue;
    if (hasText && !deco(e)) out.push({k:'TEXT', px:Math.round(over+under), side: over>=under?'rechts':'links', where:path(e), txt:e.textContent.trim().slice(0,50)});
    else if (isGfx) out.push({k:'ICON', vis:Math.round(100*Math.max(0,Math.min(r.right,iw)-Math.max(r.left,0))/r.width), deco:deco(e), where:path(e)});
  }
  return JSON.stringify(out);
})()"""

for f in files:
    name = os.path.basename(f)
    for W in widths:
        send("Emulation.setDeviceMetricsOverride", width=W, height=844, deviceScaleFactor=1, mobile=True)
        send("Page.navigate", url="file://" + f); time.sleep(2.5)
        h = ev("document.documentElement.scrollHeight"); y = 0
        while y < h:
            ev(f"scrollTo(0,{y})"); time.sleep(.25); y += 700; h = ev("document.documentElement.scrollHeight")
        time.sleep(1.2); ev("scrollTo(0,0)"); time.sleep(.3)
        res = json.loads(ev(PROBE))
        text = [r for r in res if r['k'] == 'TEXT']
        gfx = [r for r in res if r['k'] == 'ICON' and r['vis'] < 95]
        print(f"== {name} @{W}: {len(text)} Text-Stellen angeschnitten, {len(gfx)} Grafiken teilweise außerhalb")
        seen = set()
        for r in text:
            key = (r['where'], r['side'])
            if key in seen: continue
            seen.add(key); print(f"   TEXT {r['px']:>4}px {r['side']:<6} {r['where']}  «{r['txt']}»")
        for r in gfx:
            print(f"   ICON {r['vis']:>3}% sichtbar {'(deko) ' if r['deco'] else ''}{r['where']}")
ws.close()
