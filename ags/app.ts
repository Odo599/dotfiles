import app from "ags/gtk4/app"
import scss from "./style.scss"
import Powermenu from "./widget/Powermenu"

app.start({
  css: scss,
  main() {
    app.get_monitors().map(Powermenu)
  },
})
