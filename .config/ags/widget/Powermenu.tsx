import app from "ags/gtk4/app"
import { Gtk, Gdk } from "ags/gtk4"
import Button from "./Button"
export default function Powermenu(gdkmonitor: Gdk.Monitor) {
  return (
    <window
      visible
      name="Powermenu"
      class="ags-powermenu"
      gdkmonitor={gdkmonitor}
      application={app}
    >
      <box spacing={8}>
        <Button label="Log out" command="hyprctl dispatch exit" />
        <Button label="Suspend" command="systemctl suspend" />
        <Button label="Shut down" command="poweroff" />
        <Button label="Reboot" command="reboot" />
      </box>
    </window>
  )
}
