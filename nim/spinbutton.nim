import gintro/[gtk4, gobject, gio]

proc valueChanged(s: SpinButton) =
  echo "value changed: ", s.getValue, " (", s.getValueAsInt, ")"

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let adj1 = newAdjustment(50.0, 0.0, 100.0, 1.0, 10.0, 0.0) # value, lower, upper, stepIncrement, pageIncrement, pageSize
  let adj2 = newAdjustment(value = 0, lower = 0, upper = 10.0, stepIncrement = 0.01, pageIncrement = 1.0, pageSize = 0.0)

  let b1 = newSpinButton(adj1, 5.0, 0)
  let b2 = newSpinButton(adj2, 0.0, 2)
  b1.connect("value-changed", valueChanged)
  b2.connect("value-changed", valueChanged)
  let box = newBox(Orientation.horizontal, 25)
  box.append(b1)
  box.append(b2)
  window.setChild(box)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()

