import { Variable, bind, exec, execAsync } from "astal";
import icons from "~/lib/icons";
import { bash } from "~/lib/utils";
import { home, options } from "~/options";
import { sysTime } from "~/src/globals/sys-time";
import Button from "./button";

const { random_wall, recording_path } = options.quicksettings;

const ToggleDarkMode = () => {
  const nightLight = Variable<"blue-light-filter" | null>(
    exec(
      'sh -c "cat $HOME/.cache/nightlight 2>/dev/null || echo off"'
    ).trim() === "on"
      ? "blue-light-filter"
      : null
  );
  const kelvinFromPercent = (p: number) => Math.round(1000 + 5500 * (p / 100));

  const disableNightLight = () => {
    bash("hyprctl hyprsunset identity").then(() => nightLight.set(null));
  };

  const applyKelvin = (percent: number) => {
    const kelvin = kelvinFromPercent(percent);
    bash(`hyprctl hyprsunset temperature ${kelvin}`).then(() =>
      nightLight.set("blue-light-filter")
    );
  };
  const temperaturePercent = Variable(100); // start at 50%
  return (
    <Button
      className={bind(nightLight).as((value) =>
        value === "blue-light-filter" ? "active" : ""
      )}
      onScroll={(_, event) => {
        if (nightLight.get() === "blue-light-filter") {
          const direction = event.delta_y > 0 ? 5 : -5;
          const newVal = Math.min(
            100,
            Math.max(0, temperaturePercent.get() + direction)
          );
          temperaturePercent.set(newVal);
          if (newVal == 100) {
            disableNightLight();
          } else {
            applyKelvin(newVal);
          }
        }
      }}
      onClick={() => {
        if (nightLight.get() === "blue-light-filter") {
          disableNightLight();
        } else {
          // print(temperaturePercent)
          applyKelvin(temperaturePercent.get());
        }
      }}
      icon={icons.color.dark}
      label="NightLight"
    />
  );
};

const ScreenRecord = () => {
  const format = bind(sysTime).as(
    (d) => `recording_${d.format("%Y-%m-%d_%H-%M-%S")}.mp4`
  );
  const isRecording = Variable(false);
  const className = bind(isRecording).as((r) => (r ? "recording" : ""));
  const icon = bind(isRecording).as((r) => (r ? "" : ""));
  const label = bind(isRecording).as((r) => (r ? "Stop" : "Screen Rec "));

  // Why not simply use `pgrep wf-recorder` & be done with comparing string?
  // Well this `Gio.IOErrorEnum: pgrep: no matching criteria specified`
  // fucker showing up in console, which looks ugly
  bash("pgrep wf-recorder > /dev/null && echo true || echo false").then(
    (out) => out === "true" && isRecording.set(true)
  );

  const recordHandler = () => {
    const cmd = `wf-recorder --audio --file="${recording_path}/${format.get()}"`;

    if (!isRecording.get()) {
      isRecording.set(true);
      bash(cmd);
    } else {
      bash("pkill wf-recorder").then(() => {
        isRecording.set(false);
        bash(`notify-send "Recording Saved at ${recording_path}"`);
      });
    }
  };

  return (
    <Button
      className={className}
      icon={icon}
      iconType="label"
      label={label}
      onClick={recordHandler}
    />
  );
};

export default function QSButtons() {
  return (
    <box vertical hexpand spacing={8} className="qs-buttons">
      <box spacing={8} className="container">
        <ToggleDarkMode />
        <ScreenRecord />
      </box>
      <box spacing={8} className="container">
        <Button
          icon={icons.ui.colorpicker}
          label="Pick Color"
          onClick={() => bash("hyprpicker | tr -d '\n' | wl-copy")}
        />
        <Button
          icon=""
          iconType="label"
          label="Random Wall"
          onClicked={`bash -c '$HOME/.config/ags/scripts/randwall.sh ${random_wall.path}'`}
        />
      </box>
    </box>
  );
}
