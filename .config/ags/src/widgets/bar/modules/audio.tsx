import WirePlumber from "gi://AstalWp";
import { bind } from "astal";
import { EventBox } from "astal/gtk3/widget";
import { Gtk } from "astal/gtk3";
import { Widget } from "astal/gtk3/widget";
function AudioSlider() {}

export default function Audio() {
  const speaker = WirePlumber.get_default()?.audio.default_speaker!;

  return (
    <EventBox
      onClick={() => {
        speaker.set_mute(!speaker.mute);
      }}
      onScroll={(_, event) => {
        const volumeStep = 0.05;
        const direction = event.delta_y > 0 ? 1 : -1;

        let newVolume = speaker.volume - direction * volumeStep;

        if (newVolume === 0.95) {
          newVolume = newVolume + 0.0005;
        }

        newVolume = Math.max(0, Math.min(1, newVolume));

        speaker.volume = newVolume;
      }}
      className="audio"
    >
      <box className="volume-indicator">
        <icon
          className="icon"
          css="padding-right: 6px;"
          icon={bind(speaker, "volumeIcon").as((v) => v)}
        />
        <label className="value">
          {bind(speaker, "volume").as((v) => Math.floor(v * 100))}
        </label>
      </box>
    </EventBox>
  );
}
