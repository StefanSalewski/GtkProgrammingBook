import gintro/[gtk4, gobject, gio, pango]

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let box = newBox(Orientation.vertical, 20)
  window.setChild( box)
  let label1 = newLabel()
  label1.setUseMarkup
  label1.setSelectable
  label1.setMarkup("<big>\u2654\u2655\u2656\u2657\u2658\u2659\u265A\u265B\u265C\u265D\u265E\u265F</big>")
  let label2 = newLabel("<small>Some less important message that nobody really reads</small>")
  label2.setUseMarkup
  label2.setEllipsize(pango.EllipsizeMode.end)
  box.append(label1)
  box.append(label2)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
