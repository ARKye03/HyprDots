import App from "resource:///com/github/Aylur/ags/app.js";
import { notificationPopup } from "./Widgets/Notifications/NotificationPops";
import { notificationSideBar } from "Widgets/Notifications/NotificationCenter";
import { Chat } from "Widgets/GeminiAI/Chat";
import { Bar } from "Widgets/Bar/Bar";
import { MediaWidget } from "Widgets/Media/Media";
import { applauncher } from "Widgets/AppLauncher";
import { calendar } from "Widgets/Bar/Clock";

// main scss file
const scss = `${App.configDir}/styles/MainStyle.scss`;

// target css file
const css = `/tmp/my-style.css`;

Utils.monitorFile(
  // directory that contains the scss files
  `${App.configDir}/styles/`,

  // reload function
  function () {
    // main scss file
    const scss = `${App.configDir}/styles/MainStyle.scss`;

    // target css file
    const css = `/tmp/my-style.css`;

    // compile, reset, apply
    Utils.exec(`sassc ${scss} ${css}`);
    App.resetCss();
    App.applyCss(css);
  }
);
// make sure sassc is installed on your system
Utils.exec(`sassc ${scss} ${css}`);

App.config({
  style: css,
  windows: [
    Bar(),
    notificationPopup,
    Chat(),
    MediaWidget(),
    notificationSideBar,
    applauncher,
    calendar,
  ],
});
