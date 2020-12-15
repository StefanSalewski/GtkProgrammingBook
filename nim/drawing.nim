##  nim c --gc:arc drawing.nim
import gintro/[gtk4, gdk4, gobject, gio, cairo]
#import strutils

##  Surface to store current scribbles
var surface: cairo.Surface = nil

proc clearSurface =
  var cr: cairo.Context
  cr = newContext(surface)
  cr.setSource(1, 1, 1)
  cr.paint
  #cairo_destroy(cr)

##  Create a new surface of the appropriate size to store our scribbles
proc resizeCb(widget: DrawingArea; width, height: int) =
  if surface != nil:
    surface.destroy
    surface = nil
  let s = widget.getNative.getSurface
  #let s = gtk_native_get_surface(gtk_widget_get_native(widget))
  if true:#gtk_native_get_surface(gtk_widget_get_native(widget)):
    surface = createSimilarSurface(s, cairo.Content.color, widget.getWidth, widget.getHeight)
    ##  Initialize the surface to white
    clearSurface()

##  Redraw the screen from the surface. Note that the draw
##  callback receives a ready-to-be-used cairo_t that is already
##  clipped to only draw the exposed areas of the widget
##

# proc drawCb(drawingArea: DrawingArea; cr: cairo.Context; width, height: int; arg: int) =
proc drawCb(drawingArea: DrawingArea; cr: cairo.Context; width, height: int) =
  #echo arg
  cr.setSourceSurface(surface, 0, 0)
  cr.paint

##  Draw a rectangle on the surface at the given position
proc drawBrush(widget: Widget; x, y: float) =
  var cr: cairo.Context
  ##  Paint to the surface, where we store our state
  cr = cairo.newContext(surface)
  cr.rectangle(x - 3, y - 3, 6, 6)
  cr.fill
  #cairo_destroy(cr)
  ##  Now invalidate the drawing area.
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
  clearSurface()
  area.queueDraw

proc closeWindow(w: Window) =
  if surface != nil:
    destroy(surface)

proc activate(app: gtk4.Application) =
  var window: Window
  var frame: Frame
  var drawingArea: DrawingArea
  #var drag: Gesture
  #var press: Gesture
  window = app.newApplicationWindow
  window.setTitle("Drawing Area")
  window.connect("destroy", closeWindow)
  frame = newFrame(nil)
  window.setChild(frame)
  drawingArea = newDrawingArea()
  ##  set a minimum size
  drawingArea.setSizeRequest(100, 100)
  frame.setChild(drawingArea)
  #drawingArea.setDrawFunc(drawCb, 1)
  drawingArea.setDrawFunc(drawCb)
  drawingArea.connectAfter("resize", resizeCb)
  var drag = newGestureDrag()
  #GC_ref(drag)
  drag.setButton(BUTTON_PRIMARY)
  drawingArea.addController(drag)
  drag.connect("drag-begin", dragBegin, drawingArea)
  drag.connect("drag-update", dragUpdate, drawingArea)
  drag.connect("drag-end", dragEnd, drawingArea)
  var press = newGestureClick()
  #GC_ref(press)
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

