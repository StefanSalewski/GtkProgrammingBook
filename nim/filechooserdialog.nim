import gintro/[gtk4, gobject, gio]

proc fileChooserResponseCb(d: FileChooserDialog; id: int) =
  if ResponseType(id) == ResponseType.accept:
    let file = d.file
    echo file.getPath
  d.destroy

proc dialogCb(b: Button; w: ApplicationWindow) =
  let dialog = newFileChooserDialog("Open File", w, FileChooserAction.open)
  discard dialog.addButton("Open", ResponseType.accept.ord)
  discard dialog.addButton("Cancel", ResponseType.cancel.ord)
  dialog.connect("response", fileChooserResponseCb)
  dialog.show

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  window.title = "Application Main Window"
  let b = newButton("Open File Chooser Dialog")
  b.connect("clicked", dialogCb, window)
  window.setChild(b)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
