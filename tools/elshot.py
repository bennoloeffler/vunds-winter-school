"""Screenshot of ONE element of a draft (e.g. to check icons or a section), via CDP.
usage: uv run --with websocket-client python tools/elshot.py <port> <file:///abs/path.html> "<css selector>" <out.png>
Needs a headless Chrome with --remote-debugging-port=<port> already running (tools/shoot.py starts one).
"""
import json,sys,time,base64,urllib.request,websocket
port,url,sel,out=int(sys.argv[1]),sys.argv[2],sys.argv[3],sys.argv[4]
page=next(t for t in json.loads(urllib.request.urlopen(f"http://localhost:{port}/json/list").read()) if t["type"]=="page")
ws=websocket.create_connection(page["webSocketDebuggerUrl"],suppress_origin=True); mid=0
def send(m,**p):
    global mid; mid+=1; ws.send(json.dumps({"id":mid,"method":m,"params":p}))
    while True:
        r=json.loads(ws.recv())
        if r.get("id")==mid: return r.get("result",{})
send("Page.bringToFront"); send("Emulation.setFocusEmulationEnabled",enabled=True)
send("Emulation.setDeviceMetricsOverride",width=1440,height=900,deviceScaleFactor=2,mobile=False)
send("Page.navigate",url=url); time.sleep(3)
r=send("Runtime.evaluate",expression=f"(()=>{{const e=document.querySelector({json.dumps(sel)});e.scrollIntoView({{block:'center'}});const b=e.getBoundingClientRect();return JSON.stringify([b.x,b.y,b.width,b.height])}})()",returnByValue=True)
time.sleep(1.2)
x,y,w,h=json.loads(r["result"]["value"])
r=send("Runtime.evaluate",expression=f"(()=>{{const b=document.querySelector({json.dumps(sel)}).getBoundingClientRect();return JSON.stringify([b.x+scrollX,b.y+scrollY,b.width,b.height])}})()",returnByValue=True)
x,y,w,h=json.loads(r["result"]["value"])
d=send("Page.captureScreenshot",format="png",clip={"x":x,"y":y,"width":min(w,900),"height":min(h,700),"scale":1})["data"]
open(out,"wb").write(base64.b64decode(d)); print("ok",out)
