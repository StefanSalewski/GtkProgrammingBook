import gintro/[gtk4, gobject, gio]

proc buttonCb(b: Button) =
  echo "click"

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let box = newBox(Orientation.horizontal, 10)
  window.setChild( box)
  let b1 = newButton("Click Me")
  let b2 = newButtonWithMnemonic("_Mnemonic")
  let b3 = newButtonFromIconName("document-print")
  let b4 = newButton("\u2654")
  let b5 = newToggleButton("Toggle Button")
  let b0 = newButton("CSS Styled")
  let cssProvider = newCssProvider()
  let data = "button {color: yellow; background: green;}"
  cssProvider.loadFromData(data)
  let styleContext = b0.getStyleContext
  assert styleContext != nil
  addProvider(styleContext, cssProvider, STYLE_PROVIDER_PRIORITY_USER)
  for b in [b0, b1, b2, b3, b4, b5]:
    box.append(b)
    b.connect("clicked", buttonCb)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
