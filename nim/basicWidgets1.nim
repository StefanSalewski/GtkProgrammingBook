##  nim c --gc:arc basicWidgets1.nim

import gintro/[gtk4, gobject, gio]
import std/with

proc buttonCB(button: Button; entry: Entry) =
  let input = entry.text
  if input.len == 0:
    echo "Ordered a big bag of nothing!"
  else:
    echo "Ordered some ", input
    entry.setText("") # clear entry for new input
    discard entry.grabFocus # let keyboard input go again to this entry widget

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let vbox = newBox(Orientation.vertical, 25) # outer box
  let hbox = newBox(Orientation.horizontal, 25) # inner box above button
  let label = newLabel("Food:")
  let entry = newEntry()
  entry.widthChars = 32 # widthChars function is from GtkEditable interface
  let button = newButton("Buy it now!")
  hbox.append(label)
  hbox.append(entry)
  vbox.append(hbox)
  vbox.append(button)
  button.connect("clicked", buttonCB, entry)
  with vbox:
    setMarginStart(25)
    setMarginEnd(25)
    marginTop = 10 # with a recent Nim compiler assignment inside with block works also
    marginBottom = 10
  with window:
    setChild(vbox)
    title = "Mississippi App"
    defaultSize = (400, 100)
    # show # works
  window.show # but this is more clear

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
