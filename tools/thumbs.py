"""Hero thumbnails for the index: desktop 1440x900 -> 720x450 jpg, phone 390x844 -> 195x422 jpg.
usage (from repo root): uv run --with websocket-client --with pillow python tools/thumbs.py 9395 thumbs 15-storytelling-freundlich.html=15 "13-storytelling-hell.html?hero=b=13b"
  -> thumbs/15-d.jpg (desktop) and thumbs/15-m.jpg (phone). Pass args as separate words (zsh does not split a $var)."""
import json, sys, time, base64, urllib.request, os, io, subprocess
import websocket
from PIL import Image

port, out = int(sys.argv[1]), sys.argv[2]
os.makedirs(out, exist_ok=True)
CH = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
def up():
    try: urllib.request.urlopen(f"http://localhost:{port}/json/version", timeout=1); return True
    except Exception: return False
if not up():
    subprocess.Popen([CH, "--headless=new", "--disable-gpu", "--hide-scrollbars", "--no-first-run",
                      f"--remote-debugging-port={port}", f"--user-data-dir=/tmp/thumbs-chrome-{port}", "about:blank"],
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
send("Page.enable"); send("Page.bringToFront"); send("Emulation.setFocusEmulationEnabled", enabled=True)
for spec in sys.argv[3:]:
    target, name = spec.rsplit("=", 1)
    path, _, q = target.partition("?")
    url = "file://" + os.path.abspath(path) + ("?" + q if q else "")
    for W, H, tw, suffix in [(1440, 900, 720, "d"), (390, 844, 234, "m")]:
        send("Emulation.setDeviceMetricsOverride", width=W, height=H, deviceScaleFactor=1, mobile=W < 500)
        send("Page.navigate", url=url); time.sleep(4.2)
        # hide preview switchers so thumbnails show the page itself
        send("Runtime.evaluate", expression="document.querySelectorAll('.heroswitch').forEach(e=>e.style.display='none')")
        time.sleep(.2)
        im = Image.open(io.BytesIO(base64.b64decode(send("Page.captureScreenshot", format="png")["data"]))).convert("RGB")
        im = im.resize((tw, round(tw * H / W)), Image.LANCZOS)
        im.save(f"{out}/{name}-{suffix}.jpg", quality=82, optimize=True, progressive=True)
    print("ok", name)
ws.close()
