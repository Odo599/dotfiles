import { execAsync } from "ags/process"
import { Gtk } from "ags/gtk4"

type ButtonProps = {
  label: string
  command: string
}

export default function Button({ label, command = "" }: ButtonProps) {
  return (
    <button
      $type="start"
      onClicked={() => execAsync(command).then(console.log)}
      hexpand
      halign={Gtk.Align.CENTER}
      class={"button"}
    >
      <label class={"label"} label={label} />
    </button>
  )
}
