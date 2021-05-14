import asyncio
import websockets
import json
import pyautogui as pag
import logging

pag.FAILSAFE = False
pag.PAUSE = 0


def mouse_move(message):
    data = json.loads(message)
    dx = data["dx"]
    dy = data["dy"]
    pag.moveRel(dx, dy)


async def server(websocket, path):
    async for message in websocket:
        mouse_move(message)

start_server = websockets.serve(server, "0.0.0.0", 8001)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
