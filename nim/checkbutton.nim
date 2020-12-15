import gintro/[gtk4, gobject, gio]

proc checkCb(ch: CheckButton) =
  echo ch.getLabel, " toggled: ", ch.getActive

proc activate(app: Application) =
  let window = newApplicationWindow(app)
  let bh = newBox(Orientation.horizontal, 10)
  let bv1 = newBox(Orientation.vertical)
  let bv2 = newBox(Orientation.vertical)
  window.setChild( bh)
  bh.append(bv1)
  bh.append(bv2)
  let ch1 = newCheckButton("Red")
  let ch2 = newCheckButton("Yellow")
  let ch3 = newCheckButton("Green")
  for ch in [ch1, ch2, ch3]:
    bv1.append(ch)
    ch.connect("toggled", checkCb)
  let r1 = newCheckButton("Sun")
  let r2 = newCheckButton("Rain")
  let r3 = newCheckButton("Snow")
  for ch in [r1, r2, r3]:
    bv2.append(ch)
    ch.connect("toggled", checkCb)
  r2.setGroup(r1)
  r3.setGroup(r1)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
