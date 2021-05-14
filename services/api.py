from flask import Flask, jsonify, request
import pyautogui as pag
import json
pag.FAILSAFE = False

app = Flask(__name__)


@app.route("/isalive", methods=["GET"])
def is_alive():
    return jsonify({
        "isAlive": True
    })


@app.route("/mouse/move", methods=['POST'])
def mouse_move():
    data = json.loads(request.data)
    dx = data["dx"]
    dy = data["dy"]
    # print(dx, dy)
    pag.moveRel(dx, dy, duration=0.5)
    return jsonify({
        "success": "done"
    })


@app.route("/mouse/click", methods=['POST'])
def mouse_click():
    data = json.loads(request.data)
    button = data["button"]
    print(button)
    pag.click(button=button)
    return jsonify({
        "success": "done"
    })


@app.route("/keyboard/press", methods=['POST'])
def keyboard_press():
    data = json.loads(request.data)
    key = data["key"]
    print(key)
    pag.press(key)
    return jsonify({
        "success": "done"
    })


@app.route("/keyboard/type", methods=['POST'])
def keyboard_type():
    data = json.loads(request.data)
    text = data["text"]
    print(text)
    pag.write(text)
    return jsonify({
        "success": "done"
    })


# uncomment for debugging server
app.run(host="localhost", port=8000, debug=True)
