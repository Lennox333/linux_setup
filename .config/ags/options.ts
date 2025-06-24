import { exec } from "astal";

export const home = `/home/${exec("whoami")}`;

export const options = {
  terminal: "kitty",
  notification_timeout: 5000,
  quicksettings: {
    profile_picture: "./lib/profile.txt",
    recording_path: `${home}/Videos`,
    screenshot: {
      path: `${home}/Pictures/screenshots`,
    },
    random_wall: {
      path: `${home}/Wallpapers`,
    },
  },
  mpris: {
    fallback_img: "./lib/fallback.svg",
  },
  wallpaper_picker: {
    path: `${home}/.config/swww/compressed-walls`,
  },
};
