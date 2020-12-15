import gintro/[gtk4, gobject, gio]

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let hbox1 = newBox(Orientation.horizontal, 25)
  let hbox2 = newBox(Orientation.horizontal, 25)
  let vbox = newBox(Orientation.vertical)
  var l: Label
  for el in ["A", "B", "C"]:
    l = newLabel(el)
    l.hexpand = true
    hbox1.append(l)
  for el in ["D", "E"]:
    l = newLabel(el)
    l.hexpand = true
    hbox2.append(l)
  vbox.append(hbox1)
  vbox.append(hbox2)
  window.setChild(vbox)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
