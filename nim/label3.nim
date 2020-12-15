import gintro/[gtk4, gobject, gio]

proc entryCb(e: Entry) =
  echo "Searching for: ", e.text

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let box = newBox(Orientation.horizontal, 10)
  window.setChild(box)
  let label = newLabelWithMnemonic("_Find")
  label.setUseUnderline(true)
  let entry = newEntry()
  let dummy = newEntry()
  label.setMnemonicWidget(entry)
  entry.connect("activate", entryCb)
  box.append(label)
  box.append(entry)
  box.append(dummy)
  discard dummy.grabFocus
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
