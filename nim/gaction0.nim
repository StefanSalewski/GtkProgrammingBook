# nim c --gc:arc gaction0.nim
import gintro/[gtk4, glib, gobject, gio]

proc saveCb(action: SimpleAction; v: Variant) =
  echo "saveCb"

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  let action = newSimpleAction("save")
  discard action.connect("activate", saveCB)
  # window.actionMap.addAction(action)
  window.addAction(action) # since gintro v0.8.4, manual fix
  let button = newButton()
  button.label = "Save"
  window.setChild(button)
  button.setActionName("win.save")
  setAccelsForAction(app, "win.save", "<Control><Shift>S")
  show(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

