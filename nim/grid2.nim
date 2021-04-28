import gintro/[gtk4, gobject, gio]

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  window.title = "Employees"
  let grid = newGrid()
  for i, t in ["First Name", "Surname", "Job", "Retire Date"]:
    let l = newLabel(t & ": ")
    l.xAlign = 1
    let e = newEntry()
    grid.attach(l, 0, i)
    grid.attach(e, 1, i)
  window.setChild(grid)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
