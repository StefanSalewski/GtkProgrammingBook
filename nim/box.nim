import gintro/[gtk4, gobject, gio, pango]

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let box = newBox(Orientation.horizontal, 20)
  #box.baseLinePosition = BaselinePosition.bottom
  #box.setHomogeneous
  window.setChild( box)
  let label1 = newLabel("<small>Available\nchess pieces</small>")
  label1.setYalign(1) # bottom
  label1.setUseMarkup
  let label2 = newLabel()
  label2.setMarkup("<big>\u2654\u2655\u2656\u2657\u2658\u2659\u265A\u265B\u265C\u265D\u265E\u265F</big>")
  label2.setYalign(1)
  #label2.setUseMarkup # set from setMarkup() call
  box.append(label1)
  box.append(label2)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
