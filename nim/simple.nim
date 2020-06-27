##  https://gitlab.gnome.org/GNOME/gtk/-/blob/master/tests/simple.c
##  nim c simple.nim

import gintro/[gtk4, glib, gobject]

proc hello(b: Button) =
  echo "hello world"

proc quit_cb(window: Window; done: ref bool) =
  done[] = true
  wakeup(defaultMainContext())

proc main =
  var done = new bool
  gtk4.init()
  let window = newWindow()
  window.title = "hello world"
  window.resizable = false
  window.connect("destroy", quit_cb, done)
  let button = newButton()
  button.label = "hello world"
  button.marginTop = 10
  button.marginBottom = 10
  button.marginStart = 10
  button.marginEnd = 10
  button.connect("clicked", hello)
  window.setChild(button)
  window.show
  while not done[]:
    discard iteration(defaultMainContext(), mayBlock = true)

main()

