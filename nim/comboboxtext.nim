import gintro/[gtk4, gobject, gio]

proc changed(cbt: ComboBoxText) =
  echo "changed to: ", cbt.getActive, " ", cbt.getActiveText

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let cb = newComboBoxText()
  for t in ["zero", "one", "two", "three"]:
    cb.appendText(t)
  cb.setActive(0)
  cb.connect("changed", changed)
  window.setChild(cb)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
