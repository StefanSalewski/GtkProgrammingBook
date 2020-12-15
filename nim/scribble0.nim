##  nim c --gc:arc scribble0.nim
import gintro/[gtk4, gdk4, gobject, gio, cairo]

type
  Pos = object
    x, y: float

var
  pos: seq[Pos]

proc drawCb(drawingArea: DrawingArea; cr: cairo.Context; width, height: int) =
  for p in pos:
    cr.rectangle(p.x - 3, p.y - 3, 6, 6)
  cr.fill

proc drawBrush(widget: Widget; x, y: float) =
  pos.add(Pos(x: x, y: y))
  widget.queueDraw

var startX: float
var startY: float

proc dragBegin(gesture: GestureDrag; x, y: cdouble; area: DrawingArea) =
  startX = x
  startY = y
  area.drawBrush(x, y)

proc dragUpdate(gesture: GestureDrag; x, y: float; area: DrawingArea) =
  area.drawBrush(startX + x, startY + y)

proc dragEnd(gesture: GestureDrag; x, y: float; area: DrawingArea) =
  area.drawBrush(startX + x, startY + y)

proc pressed(gesture: GestureClick; nPress: int; x, y: float; area: DrawingArea) =
  area.queueDraw

proc activate(app: gtk4.Application) =
  let
    window = app.newApplicationWindow
    drawingArea = newDrawingArea()
    drag = newGestureDrag()
    press = newGestureClick()
  window.setTitle("Scribble Window")
  window.setChild(drawingArea)
  drawingArea.setSizeRequest(100, 100)
  drawingArea.setDrawFunc(drawCb)
  drag.setButton(BUTTON_PRIMARY)
  drawingArea.addController(drag)
  drag.connect("drag-begin", dragBegin, drawingArea)
  drag.connect("drag-update", dragUpdate, drawingArea)
  drag.connect("drag-end", dragEnd, drawingArea)
  press.setButton(BUTTON_SECONDARY)
  drawingArea.addController(press)
  press.connect("pressed", pressed, drawingArea)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
