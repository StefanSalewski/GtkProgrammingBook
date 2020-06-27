##  https://gitlab.gnome.org/GNOME/gtk/-/blob/master/examples/hello-world.c
##  nim c helloWorld.nim

import gintro/[gtk4, gobject, gio]

proc destroyWindow(b: Button; w: gtk4.ApplicationWindow) =
  gtk4.destroy(w)

proc printHello(widget: Button) =
  echo("Hello World")

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  window.title = "Window"
  window.defaultSize = (20, 20)
  let box = newBox(Orientation.horizontal, 0)
  window.setChild( box)
  let button = newButton("Hello World")
  button.connect("clicked", printHello)
  button.connect("clicked", destroyWindow, window)
  box.append(button)
  window.show

proc main =
  let app = newApplication("org.gtk.example", {})
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
