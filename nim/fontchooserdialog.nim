import gintro/[gtk4, gobject, gio, pango]

type
  FancyLabel = ref object of Label
    cssPro: CssProvider
    toplevel: ApplicationWindow

proc fontChooserResponseCb(d: FontChooserDialog; id: int; l: FancyLabel) =
  if ResponseType(id) == ResponseType.ok:
    echo "Font: ", d.getFont
    echo "Features: ", d.getFontFeatures
    echo "Size: ", d.getFontSize
    let p: FontDescription = d.getFontDesc
    var data = "label {font-family: " & p.getFamily
    data.add("; font-size: " & $(p.getSize div pango.SCALE) & "pt")
    data.add("; font-style: " & $(p.getStyle))
    data.add("; font-weight: " & $(p.getWeight.ord))
    data.add(";}")
    echo data
    l.cssPro.loadFromData(data)
  d.destroy

proc dialogCb(b: Button; l: FancyLabel) =
  let dialog = newFontChooserDialog("Select a Font", l.topLevel)
  dialog.connect("response", fontChooserResponseCb, l)
  dialog.show

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  window.title = "Application Main Window"
  let box = newBox(Orientation.vertical)
  box.setMargin(10)
  let l = newLabel(FancyLabel, "Some fancy text")
  l.cssPro = newCssProvider()
  l.topLevel = window
  let styleContext = l.getStyleContext
  assert styleContext != nil
  addProvider(styleContext, l.cssPro, STYLE_PROVIDER_PRIORITY_USER)
  let b = newButton("Open Font Chooser Dialog")
  b.connect("clicked", dialogCb, l)
  box.append(l)
  box.append(b)
  window.setChild(box)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
