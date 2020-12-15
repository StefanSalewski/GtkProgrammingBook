import gintro/[gtk4, gobject, gio, pango]

proc activate(app: gtk4.Application) =
  let window = newApplicationWindow(app)
  let label = newLabel("Some text with red background and overlapping strikethrough")
  let attrColor = newAttrBackground(uint16.high, 0, 0)
  let attrStr = newAttrStrikethrough(true)
  attrColor.startIndex = ATTR_INDEX_FROM_TEXT_BEGINNING + 15
  attrColor.setEndIndex(29.uint32)
  attrStr.indices = (24.uint32, 32.uint32)
  let attrList = newAttrList()
  attrList.insert(attrColor)
  attrList.insert(attrStr)
  label.setAttributes(attrList)
  window.setChild(label)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
