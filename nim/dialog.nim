import gintro/[gtk4, gobject, gio]

proc responseCb(d: Dialog; id: int) =
  echo "response: ", ResponseType(id)
  d.destroy

proc dialogCb(b: Button; w: ApplicationWindow) =
  let dialog = newDialog()
  dialog.setMargin(10)
  dialog.title = "Dialog"
  dialog.setTransientFor(w)
  dialog.setModal(true)
  let contentArea = dialog.getContentArea
  let msg = newLabel("Do you like Nim and GTK?")
  contentArea.append(msg)
  discard dialog.addButton("Yes", ResponseType.yes.ord)
  discard dialog.addButton("No", ResponseType.no.ord)
  dialog.connect("response", responseCb)
  dialog.show

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  window.setMargin(50)
  window.title = "Application Main Window"
  let b = newButton("Open Dialog")
  b.connect("clicked", dialogCb, window)
  window.setChild(b)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
