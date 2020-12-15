# https://developer.gnome.org/gtk4/unstable/ch01s05.html
# builder.nim -- application style example using builder/glade xml file for user interface
# nim c --gc:arc builder.nim
import gintro/[gtk4, gobject, gio]

proc hello(b: Button; msg: string) =
  echo "Hello", msg

proc activate(app: Application) =
  let builder = newBuilder()
  discard builder.addFromFile("builder.ui")
  #let window = builder.getApplicationWindow("window")
  let window = builder.getWindow("window")
  window.setApplication(app)
  let label = builder.getLabel("label") # not really necessary, out label is fully passive
  var button = builder.getButton("button1")
  button.connect("clicked", hello, "")
  button = builder.getButton("button2")
  button.connect("clicked", hello, " again...")
  show(window)

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
