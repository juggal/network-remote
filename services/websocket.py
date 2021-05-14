from flask import Flask, jsonify
from flask_socketio import SocketIO

app = Flask(__name__)
socketio = SocketIO(app)


@app.route("/", methods=["GET"])
def hello():
    return jsonify({
        "hello": "world"
    })


@socketio.on('connect')
def c():
    print("connected")


@socketio.on('disconnect')
def d():
    print("disconnected")


if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0", port=8001, debug=False)
