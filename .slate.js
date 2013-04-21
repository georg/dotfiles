S.cfga({
  defaultToCurrentScreen: true,
  checkDefaultsOnLoad: true,
  nudgePercentOf: "screenSize",
  resizePercentOf: "screenSize"
});

// Monitors
var monLaptop      = "1680x1050";
var monThunderbolt = "2560x1440";

// Position Aliases
var maximize = S.op("move", {
  x: "screenOriginX",
  y: "screenOriginY",
  width: "screenSizeX",
  height: "screenSizeY"
});
var center = S.op("move", {
  x: "screenOriginX+screenSizeX*0.125",
  y: "screenOriginY+screenSizeY*0.125",
  width: "screenSizeX*0.75",
  height: "screenSizeY*0.75"
});

// Split Screen Actions
S.bind("right:alt;ctrl;cmd", S.op("push", {direction: "right", style: "bar-resize:screenSizeX/2"}));
S.bind("left:alt;ctrl;cmd",  S.op("push", {direction: "left",  style: "bar-resize:screenSizeX/2"}));
S.bind("up:alt;ctrl;cmd",    S.op("push", {direction: "up",    style: "bar-resize:screenSizeY/2"}));
S.bind("down:alt;ctrl;cmd",  S.op("push", {direction: "down",  style: "bar-resize:screenSizeY/2"}));

// Quarter Screen (Quadrant) Actions
S.bind("right:alt;ctrl;shift", S.op("corner", {direction: "bottom-right", width:"screenSizeX/2", height:"screenSizeY/2"}));
S.bind("left:alt;ctrl;shift",  S.op("corner", {direction: "top-left",     width:"screenSizeX/2", height:"screenSizeY/2"}));
S.bind("up:alt;ctrl;shift",    S.op("corner", {direction: "top-right",    width:"screenSizeX/2", height:"screenSizeY/2"}));
S.bind("down:alt;ctrl;shift",  S.op("corner", {direction: "bottom-left",  width:"screenSizeX/2", height:"screenSizeY/2"}));

// Other Actions
S.bind("m:ctrl;alt;cmd", maximize);
S.bind("c:ctrl;alt;cmd", center);
S.bind("s:ctrl;alt;cmd", function(win) {
  var snapshotName = S.screenCount() == 1 ? "oneMonitor" : "twoMonitor";
  win.doOperation("snapshot", {
    name: snapshotName,
    save: true,
    stack: false
  });
});

// // Default screens
S.default([monThunderbolt, monLaptop], "twoMonitor");
S.default([monLaptop], "oneMonitor");
