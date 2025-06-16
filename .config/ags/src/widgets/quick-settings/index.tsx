import Astal from "gi://Astal";
import { App, Gtk } from "astal/gtk3";
import Calendar from "./calendar";
import Mpris from "./mpris";
import Profile from "./profile";
import QSButtons from "./qs-buttons";
import Gdk from "gi://Gdk";

export default function QuickSettings() {
  const { LEFT, TOP, BOTTOM } = Astal.WindowAnchor;
  return (
    <window
      visible={false}
      name="quicksettings"
      css="background: transparent;"
      anchor={LEFT | TOP | BOTTOM}
      margin={6}
      application={App}
      // keymode={Astal.Keymode.ON_DEMAND}
      // onKeyPressEvent={(self, event: Gdk.Event) => {
      //   console.log("Key Pressed in QuickSettings", event);
      // }}
    >
      <box
        className="control-pannel"
        css="padding: 8px; "
        valign={Gtk.Align.START}
        spacing={10}
        vertical
      >
        <Profile />
        <QSButtons />
        <Mpris />
        <Calendar />
      </box>
    </window>
  );
}
