# gsettings.nim -- basic use of gsettings
# nim c --gc:arc gsettings.nim
# https://blog.gtk.org/2017/05/01/first-steps-with-gsettings/
import gintro/[gtk4, gobject, gio]

# unused
#proc toggle(b: CheckButton) = 
#  echo b.active
#  let s = newSettings("org.gnome.Recipes")
#  discard s.setBoolean("like-nim", b.active)

proc activate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GSettings"
  window.defaultSize = (200, 200)
  let b = newCheckButton("I like Nim")
  b.halign = Align.center
  #b.connect("toggled", toggle) # we don't need this for plain binding!
  let s = newSettings("org.gnome.Recipes")
  if s.getBoolean("like-nim"):
    echo "I like Nim language"
  `bind`(s, "like-nim", b, "active", {SettingsBindFlag.set, get})
  window.setChild(b)
  show(window)

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
