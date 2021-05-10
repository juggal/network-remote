const express = require("express");
const app = express();
const server = require("http").createServer(app);
const { networkInterfaces } = require("os");
const WebSocket = require("ws");
const PORT = 8000;
const wss = new WebSocket.Server({ server });
const robot = require("robotjs");

wss.on("connection", (ws) => {
  // when client connects
  console.log("a user connected");

  ws.on("message", (event) => {
    const eventParsed = JSON.parse(event);

    switch (eventParsed.type) {
      case "moveMouse":
        // console.log(`dx:${eventParsed.dx}, dy:${eventParsed.dy}`);
        const curPos = robot.getMousePos();
        robot.moveMouse(curPos.x + eventParsed.dx, curPos.y + eventParsed.dy);
        break;
      case "mouseClick":
        // console.log("mouse clicked " + eventParsed.button);
        robot.mouseClick(eventParsed.button, false);
        break;
      case "keyTap":
        // console.log(`${eventParsed.key} pressed`);
        robot.keyTap(eventParsed.key);
        break;
      case "sendText":
        // console.log(eventParsed.text);
        robot.typeString(eventParsed.text);
        break;
    }
  });

  // const curPos = robot.getMousePos();

  // when client disconnects
  ws.on("close", () => {
    console.log("disconnected");
  });
});

server.listen(PORT, () => {
  const net = networkInterfaces();
  // const ip = net["wlp3s0"][0].address || "Cannot find ip";
  const ip = net["Wi-Fi"][0].address || "Cannot find ip";
  console.log(`IP: ${ip}\nPORT:${PORT}`);
});
