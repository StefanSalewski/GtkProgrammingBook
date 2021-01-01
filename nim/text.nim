import gintro/[gtk4, gobject, gio]

proc activate(t: Text) =
  echo "You entered: ", t.buffer.text

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let box = newBox(Orientation.horizontal, 20)
  window.setChild( box)
  let t1 = newText()
  let t2 = newText()
  let t3 = newText()
  let f1 = newFrame()
  let f2 = newFrame()
  let f3 = newFrame()
  f1.setChild(t1)
  f2.setChild(t2)
  f3.setChild(t3)
  box.append(f1)
  box.append(f2)
  box.append(f3)
  t1.placeHolderText = "Search ..."
  t2.visibility = false
  t3.setMaxWidthChars(4)
  for t in [t1, t2, t3]:
    t.connect("activate", activate)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
