import gintro/[gtk4, gdk4, gobject, glib, gio]

proc buttonCb(b: LinkButton): bool =
  echo "clicked: ", " ", b.getURI 
  return gdk4.EVENT_PROPAGATE

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let box = newBox(Orientation.horizontal, 50)
  window.setChild( box)
  let p = newSimplePermission(false)
  let lock = newLockButton(p)
  let link = newLinkButton("https://developer.gnome.org", "GTK/Gnome")
  box.append(lock)
  box.append(link)
  link.connect("activate-link", buttonCb)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
