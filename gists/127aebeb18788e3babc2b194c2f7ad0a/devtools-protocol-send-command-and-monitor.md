# Playing with the protocol

You can send arbitrary commands over the protocol fairly easily. 


```js
Main.sendOverProtocol('Emulation.setDeviceMetricsOverride', nexus5XMetrics());
Main.sendOverProtocol("Emulation.clearDeviceMetricsOverride");

// It returns a promise
Main.sendOverProtocol("Page.captureScreenshot").then(data => {
  // ...
});


function nexus5XMetrics() {
  return {
    mobile: true,
    screenWidth: 412,
    screenHeight: 732,
    width: 412,
    height: 732,
    positionX: 0,
    positionY: 0,
    scale: 1,
    deviceScaleFactor: 2.625,
    fitWindow: false,
    screenOrientation: {
      angle: 0,
      type: 'portraitPrimary'
    }
  };
};
```
![image](https://cloud.githubusercontent.com/assets/39191/16751037/2523c35c-478b-11e6-95b2-4ba9518fa71d.png)


# Logging protocol activity

Try out the Protocol monitor panel. It's a [hidden devtools experiment](https://coderwall.com/p/3qdoiw/how-to-turn-on-chrome-devtools-experiments).

https://umaar.com/dev-tips/166-protocol-monitor/

![](https://umaar.com/assets/images/dev-tips/protocol-monitor.gif)


#### Monkeypatch Alternative
This snippet will log all the protocol traffic to the console.

```js
// This will log all protocol traffic to the console
const mainConnection = SDK.targetManager.mainTarget()._connection;

const _onMsg = mainConnection._onMessage;
const _sendMessage = mainConnection.__proto__.sendMessage;

mainConnection._onMessage = function(message) {
    console.log('received: ', typeof message === "string" ? JSON.parse(message) : message);
    _onMsg.apply(this, arguments);
}

mainConnection.__proto__.sendMessage = function(message) {
    console.log('sending : ', typeof message === "string" ? JSON.parse(message) : message);
    _sendMessage.apply(this, arguments);
}
```

![image](https://cloud.githubusercontent.com/assets/39191/16750933/31a12396-478a-11e6-8b14-66ff6b939c52.png)


#### `dumpInspectorProtocolMessages` Alternative

Instead of using the logging snippet, you can set `Protocol.InspectorBackend.Options.dumpInspectorProtocolMessages = true`.
It does basically the same thing, but the objects are stringified, making it slightly messier to read. 
![image](https://cloud.githubusercontent.com/assets/39191/16750888/e1340900-4789-11e6-8927-6d0ad9a58679.png)
