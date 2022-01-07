# nim c count_button.nim
import gintro/[gtk, gobject, gio]

type
  CountButton = ref object of Button
    counter: int

when defined(gcDestructors):
  proc `=destroy`(x: var typeof(CountButton()[])) =
    gtk.`=destroy`(typeof(Button()[])(x))

proc buttonClicked (button: CountButton; decrement: int) =
  dec(button.counter, decrement)
  button.label = "Counter: " & $button.counter
  echo "Counter is now: ", button.counter

proc appActivate (app: Application) =
  #var button: CountButton
  let window = newApplicationWindow(app)
  window.title = "Count Button"
  #initButton(button, "Counting down from 100 by 5") # deprecated
  let button = newButton(CountButton, "Counting down from 100 by 5")
  button.counter = 100
  window.add(button)
  button.connect("clicked", buttonClicked, 5)
  window.showAll

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()

