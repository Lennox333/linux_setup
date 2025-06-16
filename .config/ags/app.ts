import { monitorFile } from "astal";
import { App } from "astal/gtk3";
import { exec } from "astal/process";
import { bash } from "./lib/utils";
import Alert from "./src/components/alert";
import Bar from "./src/widgets/bar";
// import Flatpak from "./src/widgets/flatpak";
import {
  NotificationCenter,
  NotificationPopups,
} from "./src/widgets/notifications";
import OSD from "./src/widgets/osd";
import QuickSettings from "./src/widgets/quick-settings";
// import WallPicker from "./src/widgets/wall-picker";

const scss = "./src/style/style.scss";
const css = "/tmp/ags/style.css";

function reloadCSS() {
  App.reset_css();
  exec(`sass ${scss} ${css}`);
  App.apply_css(css);
}

reloadCSS();

bash("find ./src/style -name '*.scss'").then((out) => {
  const scssFiles = out.split("\n");

  // Add manually imported file
  scssFiles.push("/home/ln607/.cache/wal/colors.scss");

  for (const path of scssFiles) {
    if (path.trim() === "") continue;
    monitorFile(path, () => reloadCSS());
  }
});

// monitorFile("./src/style", () => {
//   reloadCSS();
// });

// App.start({
//     css: css,
//     main() {
//         App.get_monitors().map(monitor => {
//             Bar(monitor)
//         })

//     }
// })

App.start({
  css: css,
  main() {
    App.get_monitors().map((monitor) => {
      Bar(monitor);
    });
    Alert();
    NotificationCenter();
    NotificationPopups();
    OSD();
    QuickSettings();
  },
});
