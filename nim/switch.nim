import gintro/[gtk4, gdk4, gobject, glib, gio]

proc switchCb(s: Switch; newState: bool; num: int): bool =
  echo "switched ", num, " to ", newState
  return gdk4.EVENT_PROPAGATE

proc activate(app: Application) =
  let window = newApplicationWindow(app)
  let bh = newBox(Orientation.horizontal, 10)
  let l1 = newLabel("Switch 1")
  let l2 = newLabel("Switch 2")
  let s1 = newSwitch()
  let s2 = newSwitch()
  s1.connect("state-set", switchCb, 1)
  s2.connect("state-set", switchCb, 2)
  for w in [l1, s1, l2, s2]:
    bh.append(w)
  
  window.setChild(bh)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
