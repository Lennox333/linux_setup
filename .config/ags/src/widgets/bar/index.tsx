import { App, Astal, type Gdk, Gtk } from "astal/gtk3";
import Audio from "./modules/audio";
import Clock from "./modules/clock";
import {
  // FlatpakUpdatesCount,
  NotificationButton,
  QSButton,
} from "./modules/misc";
import Mpris from "./modules/mpris";
import Network from "./modules/network";
import QuickAccessButton from "./modules/quick-access-buttons";
import { CPU, Mem } from "./modules/sys-monitor";
import SysTray from "./modules/systray";
import Workspaces from "./modules/workspaces";

const LeftModules = (
  <box className="left" spacing={8} hexpand halign={Gtk.Align.START}>
    <QSButton />
    <Workspaces />
    <CPU />
    <Mem />
    {/* <FlatpakUpdatesCount /> */}
  </box>
);

const CenterModules = (
  <box className="mid" spacing={8}>
    <Clock />
  </box>
);

const RightModules = (
  <box className="right" spacing={8} hexpand halign={Gtk.Align.END}>
    <box className="media-container">
      <Mpris />
    </box>

    {/* <Network /> */}
    {/* <QuickAccessButton /> */}
    <box className="others" spacing={8}>
      {/* <Network /> */}
      <Audio />
      <SysTray />
      <NotificationButton />
    </box>
  </box>
);

export default function Bar(monitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      name="Bar"
      setup={(self) => App.add_window(self)}
      className="Bar"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
    >
      <centerbox
        className="bar"
        start_widget={LeftModules}
        center_widget={CenterModules}
        end_widget={RightModules}
      />
    </window>
  );
}
