import gintro/[gtk4, gobject, gio]

proc toBoolVal(b: bool): Value =
  let gtype = typeFromName("gboolean")
  discard init(result, gtype)
  setBoolean(result, b)

proc activate(app: gtk4.Application) =
  let d = gtk4.getDefaultSettings()
  setProperty(d, "gtk-application-prefer-dark-theme", toBoolVal(true))
  let window = newApplicationWindow(app)
  window.title = "Window"
  window.defaultSize = (100, 20)
  let box = newBox(Orientation.vertical, 20)
  window.setChild( box)
  let label1 = newLabel("This text does not wrap")
  let label2 = newLabel("But this very long text can wrap automatically")
  #label2.setWrap(true)
  #label2.setProperty("wrap", toBoolVal(true))
  box.append(label1)
  box.append(label2)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
