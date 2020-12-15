# nim c --gc:arc sourceview.nim
# ./sourceview sourceview.nim
# minimal GtkApplication example
import gintro/[gtk4, gobject, glib, gio, gtksource5]

from OS import paramCount, paramStr

proc shutdown(app: Application) =
  echo "shutdown"

proc startup(app: Application) =
  echo "startup"

proc handleLocalOptions(app: Application; vd: VariantDict): int =
  echo "handle-local-options"

proc nameLost(app: Application): bool =
  echo "name-lost"

proc open(app: Application; files: seq[GFile]; hint: string) =
  var
    contents: string
    etagOut: string
    length: uint64
    buffer: Buffer
    window: gtk4.Window
    view: gtksource5.View
  echo "open"
  for f in files:
    echo f.uri
  window = app.getActiveWindow
  if window != nil: # instead of opening a new window reuse existing one
    let h = ScrolledWindow(window.getChild)
    view = View(h.getChild)
  else:
    window = newApplicationWindow(app)
    window.title = "Text View"
    window.defaultSize = (800, 600)
    let scrolledWindow = newScrolledWindow()
    buffer = newBuffer()
    view = newViewWithBuffer(buffer) # gtksource.newView()
    window.setChild(scrolledWindow) # add() for GTK3
    scrolledWindow.setChild(view) # add() for GTK3
  if files.len > 0:
    if loadContents(files[0], cancellable = nil, contents, length, etagOut):
      assert length.int == contents.len
      echo "hint: ", hint
      echo "etag: ", etagOut
      #buffer = view.getBuffer
      var manager = getDefaultLanguageManager()
      var styleManager = getDefaultStyleSchemeManager()
      stylemanager.appendSearchPath("/home/salewski/gtksourceview/data/styles")
      var scheme = stylemanager.getScheme("cobalt")
      echo scheme != nil, "uuuuuuuuuuu"
      echo styleManager.getSearchPath()
      var langPath = manager.searchPath
      langPath.add("/home/salewski/gtksourceview/data/language-specs/")
      manager.setSearchPath(langPath)
      echo manager.searchPath
      echo manager == nil
      var lang = guessLanguage(manager, files[0].path, nil)
      echo lang == nil
      echo files[0].uri
      echo files[0].path
      setLanguage(buffer, lang)
      buffer.setHighlightSyntax
      buffer.setStyleScheme(scheme)

      buffer.setText(contents, contents.len)

  show(window) # showAll() for GTK3

proc commandLine(app: Application; cl: ApplicationCommandLine): int =
  echo "command-line"

proc activate(app: Application) =
  echo "activate"
  let window = newApplicationWindow(app)
  window.title = "Empty Text View"
  window.defaultSize = (800, 600)
  let scrolledWindow = newScrolledWindow()
  let view = newView() # gtksource.newView()
  window.setChild(scrolledWindow) # add() for GTK3
  scrolledWindow.setChild(view)
  show(window) # showAll() for GTK3

proc main =
  let app = newApplication("org.gtk.example", {ApplicationFlag.handlesOpen})#, handlesCommandLine})
  app.connect("startup", startup)
  app.connect("activate", activate)
  app.connect("command-line", commandLine)
  # app.connect("handle_local_options", handleLocalOptions)
  app.connect("open", open)
  app.connect("name-lost", nameLost)
  app.connect("shutdown", shutdown)
  let argLen = paramCount() + 1
  var argStr = newSeq[string](argLen)
  for i in 0 ..< argLen:
    argStr[i] = paramStr(i)
  discard run(app, argLen, argStr) # we have to pass an argString to support open signal handling files

main()
