
import gintro/[gtk4, gobject, gio]

proc destroyWindow(b: Button; w: gtk4.ApplicationWindow) =
  gtk4.destroy(w)

proc printHello(widget: Button) =
  echo("Hello World")

proc fileSet(chooser: FileChooserButton) = 
  echo "Selected: ", chooser.getFile.getPath

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  window.title = "Window with FileChooserButton"
  window.marginTop = 10
  let chooser = newFileChooserButton("Select a file", FileChooserAction.open)
  #chooser.setCurrentName("File...")
  chooser.connect("file-set", fileSet)
  window.setChild(chooser)
  window.show

proc main =
  let app = newApplication("org.gtk.example", {})
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
