# https://discourse.gnome.org/t/get-screen-width-and-height/7245/8
import gintro/[gtk4, gdk4, gobject, gio]

proc printData(widget: Button; window: ApplicationWindow) =
  let surface: gdk4.Surface = window.getSurface
  let display: gdk4.Display = surface.getDisplay
  let monitor: gdk4.Monitor = display.getMonitorAtSurface(surface)
  echo monitor.getWidthmm
  echo monitor.getHeightmm
  let geometry: gdk4.Rectangle = monitor.getGeometry
  echo geometry
  echo monitor.getScaleFactor
  echo surface.getScaleFactor

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let button = newButton("Print Data")
  button.connect("clicked", printData, window)
  window.setChild(button)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
