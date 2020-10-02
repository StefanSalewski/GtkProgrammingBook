##  nim c --gc:arc grid.nim
import gintro/[gtk4, gobject, gio]
import strutils

proc toggledVacCB(b: CheckButton) =
  echo "Vacation state: ", b.name, if b.active: " Yes" else: " No"

proc toggledRetCB(b: CheckButton) =
  echo "Retirement state: ", b.name, if b.active: " Yes" else: " No"

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let grid = newGrid()
  let head = newLabel("Available Devs")
  let name = newLabel("Name")
  let vacation = newlabel("Vacation")
  let retired = newLabel("Retired")
  window.defaultSize = (40, 60)
  grid.columnSpacing = 25
  grid.attach(head, column = 0, row = -2, width = 3, height = 1)
  grid.attach(name, 0, -1)
  grid.attach(vacation, 1, -1)
  grid.attach(retired, 2, -1)
  for i, p in pairs("araq mratsim bassi clasen".split):
    let lab = newLabel(p)
    let vac = gtk4.newCheckButton("Vac.")
    vac.setName(p)
    vac.connect("toggled", toggledVacCB)
    let ret = gtk4.newCheckButton("Ret.")
    ret.setName(p)
    ret.connect("toggled", toggledRetCB)
    grid.attach(lab, column = 0, row = i)
    grid.attach(vac, column = 1, row = i)
    grid.attach(ret, column = 2, row = i)
  window.setChild(grid)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
