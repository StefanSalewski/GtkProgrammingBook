import gintro/[gtk4, gobject, gio]

proc activate(e: Entry) =
  echo "You entered: ", e.buffer.text
  e.progressPulse
  #entry.setProgressFraction(0.7) # use this if we know the exact progress state in %

proc iconPress(e: Entry; p: EntryIconPosition) =
  echo "You clicked: ", p
  discard e.buffer.deleteText(0, -1) # delete all

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let entry = newEntry()
  entry.marginStart = 10
  entry.marginEnd = 10
  entry.marginTop = 10
  entry.marginBottom = 10
  entry.setProgressPulseStep(0.2)
  entry.setPlaceholderText("Enter some text")
  entry.setIconFromIconName(EntryIconPosition.secondary, "edit-clear")
  entry.setIconActivatable(EntryIconPosition.secondary, true)
  entry.connect("activate", activate)
  entry.connect("icon-press", iconPress)
  window.setChild(entry)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
