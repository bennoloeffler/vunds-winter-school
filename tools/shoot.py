"""Screenshot + sanity check for one draft, via its OWN headless Chrome (one port per agent).

usage:
  uv run --with websocket-client --with pillow python tools/shoot.py <port> <file.html> <outdir> [query]
  e.g. python tools/shoot.py 9401 15-storytelling-freundlich.html /tmp/s15      (use one port per parallel run)

- starts headless Chrome on <port> if nothing listens there (profile in <outdir>/chrome-<port>)
- enables focus emulation (else IntersectionObserver reveals never fire headless)
- for widths 1440 and 390: first-viewport shot + stitched full page (scrolls through, so reveals fire)
- prints scrollWidth vs innerWidth, JS exceptions, broken images, elements still at opacity 0
Outputs: <outdir>/<name>-<w>-hero.jpg, <outdir>/<name>-<w>-full-<k>.jpg (full page split into tiles <= 2000px tall at 640px width)
"""
import json, sys, time, base64, urllib.request, os, io, subprocess
import websocket
from PIL import Image

port, f, out = int(sys.argv[1]), os.path.abspath(sys.argv[2]), sys.argv[3]
query = sys.argv[4] if len(sys.argv) > 4 else ""
os.makedirs(out, exist_ok=True)
CH = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

def up():
    try: urllib.request.urlopen(f"http://localhost:{port}/json/version", timeout=1); return True
    except Exception: return False
if not up():
    subprocess.Popen([CH, "--headless=new", "--disable-gpu", "--hide-scrollbars", "--no-first-run",
                      f"--remote-debugging-port={port}", f"--user-data-dir={out}/chrome-{port}", "about:blank"],
                     stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    for _ in range(40):
        if up(): break
        time.sleep(.25)

page = next(t for t in json.loads(urllib.request.urlopen(f"http://localhost:{port}/json/list").read()) if t["type"] == "page")
ws = websocket.create_connection(page["webSocketDebuggerUrl"], suppress_origin=True)
mid = 0; events = []
def send(m, **p):
    global mid; mid += 1; ws.send(json.dumps({"id": mid, "method": m, "params": p}))
    while True:
        r = json.loads(ws.recv())
        if r.get("id") == mid: return r.get("result", {})
        events.append(r)
def ev(js): return send("Runtime.evaluate", expression=js, returnByValue=True)["result"].get("value")

send("Page.enable"); send("Runtime.enable")
send("Page.bringToFront"); send("Emulation.setFocusEmulationEnabled", enabled=True)
name = os.path.splitext(os.path.basename(f))[0]
for W, H in [(1440, 900), (390, 844)]:
    events.clear()
    send("Emulation.setDeviceMetricsOverride", width=W, height=H, deviceScaleFactor=1, mobile=W < 500)
    send("Page.navigate", url="file://" + f + (("?" + query) if query else "")); time.sleep(3.5)
    d = send("Page.captureScreenshot", format="jpeg", quality=78)["data"]
    open(f"{out}/{name}-{W}-hero.jpg", "wb").write(base64.b64decode(d))
    ev("document.documentElement.style.scrollBehavior='auto'")
    h = ev("document.documentElement.scrollHeight"); tiles = []; y = 0
    while y < h:
        ev(f"scrollTo(0,{y})"); time.sleep(.8)
        im = Image.open(io.BytesIO(base64.b64decode(send("Page.captureScreenshot", format="jpeg", quality=72)["data"])))
        if y + H > h: im = im.crop((0, H - (h - y), W, H))
        tiles.append(im); y += H; h = ev("document.documentElement.scrollHeight")
    full = Image.new("RGB", (W, sum(t.height for t in tiles))); yy = 0
    for t in tiles: full.paste(t, (0, yy)); yy += t.height
    scale = 640 / W if W > 640 else 1
    full = full.resize((int(W * scale), int(full.height * scale)))
    k = 0
    for top in range(0, full.height, 2000):
        full.crop((0, top, full.width, min(full.height, top + 2000))).save(f"{out}/{name}-{W}-full-{k}.jpg", quality=72); k += 1
    info = json.loads(ev("""JSON.stringify({sw:document.documentElement.scrollWidth, iw:innerWidth,
      broken:[...document.images].filter(i=>i.complete&&i.naturalWidth===0).map(i=>i.src.slice(-60)),
      hidden:[...document.querySelectorAll('.ws27 section, .ws27 h2, .ws27 blockquote')].filter(e=>+getComputedStyle(e).opacity<.05).length})"""))
    exc = [e["params"]["exceptionDetails"].get("exception", {}).get("description", "")[:160] for e in events if e.get("method") == "Runtime.exceptionThrown"]
    print(f"{name} @{W}: height={h} scrollWidth={info['sw']} innerWidth={info['iw']} {'OVERFLOW!' if info['sw']>info['iw'] else 'ok'} "
          f"broken={info['broken']} stillHidden={info['hidden']} exceptions={exc} tiles={k}")
ws.close()
