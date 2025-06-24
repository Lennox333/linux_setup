import { GLib, Variable, bind, exec } from "astal";
import icons from "~/lib/icons";
import { bash } from "~/lib/utils";
import { options } from "~/options";
import { alertDialog } from "~/src/components/alert";
// import Avatar from "~/src/components/avatar";
import AsciiAvatar from "~/src/components/ascii-avatar";
import { sysTime } from "~/src/globals/sys-time";

const { profile_picture } = options.quicksettings;

const ExtraButtons = () => {
  const uptime = Variable("").poll(
    60 * 1000,
    `bash -c "uptime | awk '{print $3}' | tr ',' ' '"`
  );

  return (
    <box className="buttons-container" spacing={4}>
      <button hexpand>{bind(uptime).as((v) => `󰔟 ${v}`)}</button>
      <button
        className="lock"
        onClick={() => exec("hyprlock")}
        child={<icon icon={icons.ui.lock} />}
      />
      <button
        className="logOut"
        onClick={() =>
          alertDialog.set({
            title: "Logout",
            func: () => bash("./scripts/logout.sh"),
          })
        }
        child={<icon icon={icons.powermenu.logout} />}
      />
    </box>
  );
};

const DayProgress = () => {
  function timePassedInADay(date: GLib.DateTime) {
    const current = date.get_minute() + date.get_hour() * 60;
    return Math.floor((current * 100) / (24 * 60));
  }

  return (
    <box className="day-progress" vertical spacing={4}>
      {bind(sysTime).as((date) => {
        const timePassed = timePassedInADay(date);

        return (
          <>
            <box
              className="day-progress label-container"
              css="border-radius: 6px; padding: 1px 0;"
            >
              <label hexpand>{`${date.format("%A")} | ${timePassed}%`}</label>
            </box>
            {/* <box vexpand /> */}
            <levelbar hexpand max_value={100} value={timePassed} />
          </>
        );
      })}
    </box>
  );
};

const PowerProfile = () => {
  // Define mode names
  const MODES = ["power-saver", "balanced", "performance"];

  // Map modes to icons
  const icons = {
    "power-saver": "󰌪",
    balanced: "",
    performance: "󰺵",
  };

  const currMode = Variable("power-saver");
  const displayMode = Variable("power-saver");
  const positionState = Variable("mid");

  bash(
    'powerprofilesctl | grep "*" | awk \'{gsub(":", "", $2); print $2}\''
  ).then((mode) => {
    displayMode.set(mode);
    currMode.set(mode);
  });

  let movingTimeoutId = 0;
  let modeTimeoutId = 0;

  const handleClick = () => {
    if (positionState.get() !== "mid") return; //only switch when previous is mid, avoiding glitch

    const display = displayMode.get();
    const next = MODES[(MODES.indexOf(display) + 1) % MODES.length];

    positionState.set("left");
    if (movingTimeoutId !== 0) {
      GLib.source_remove(movingTimeoutId);
    }
    movingTimeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, 380, () => {
      displayMode.set(next);
      positionState.set("right");

      GLib.timeout_add(GLib.PRIORITY_DEFAULT, 380, () => {
        positionState.set("mid");
        return GLib.SOURCE_REMOVE;
      });

      movingTimeoutId = 0;
      return GLib.SOURCE_REMOVE;
    });

    // cancel the previous timeout if still running
    if (modeTimeoutId !== 0) {
      GLib.source_remove(modeTimeoutId);
      modeTimeoutId = 0;
    }
    // delay actual system mode update
    modeTimeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, 3000, () => {
      currMode.set(displayMode.get()); // set the *latest* mode
      bash(`powerprofilesctl set ${next}`)
        .then(() => {
          bash(`notify-send "${next}"`);
          if (next === "balanced" ) {
            bash("hyprctl reload config-only -q");
          } else bash("gamemode.sh");
        })
        .catch((err) => {
          print(`Error setting profile: ${err}`);
          bash(`notify-send "Power Profile Error" "${err}"`);
        });
  
      modeTimeoutId = 0;
      return GLib.SOURCE_REMOVE;
    });
  };

  return (
    <box className="power-profile">
      {[
        <button
          className="container"
          onClick={handleClick}
          hexpand
          child={
            <label
              className={bind(positionState).as((state) => {
                return `power-icon-current ${
                  state === "left"
                    ? "moveleft"
                    : state === "right"
                    ? "spawnright"
                    : ""
                }`;
              })}
              label={bind(displayMode).as((mode) => icons[mode])}
            />
          }
        ></button>,
      ]}
    </box>
  );
};

export default function Profile() {
  return (
    <box className="profile" spacing={10}>
      <AsciiAvatar image={profile_picture} />
      <box
        className="options"
        vertical
        spacing={6}
        hexpand
        css="border-radius: 8px; padding: 8px;"
      >
        <ExtraButtons />
        <DayProgress />
        <PowerProfile />
      </box>
    </box>
  );
}
