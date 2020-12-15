import gintro/[gtk4, gobject, gio]

proc flipBox(b: Button; box: Box) =
  echo "flip"
  box.setOrientation(Orientation(1 - box.getOrientation.ord))

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let box = newBox(Orientation.vertical, 20)
  window.setChild( box)
  let label = newLabel("You can flip this box")
  let button = newButton("Flip")
  button.connect("clicked", flipBox, box)
  box.append(label)
  box.append(button)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
