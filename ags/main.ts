import App from "resource:///com/github/Aylur/ags/app.js";
import { notificationPopup } from "./Widgets/Notifications/NotificationPops";
import { Chat } from "Widgets/GeminiAI/Chat";
import { Bar } from "Widgets/Bar";

// main scss file
const sass = `${App.configDir}/styles/MainStyle.sass`;

// target css file
const css = `/tmp/my-style.css`;

Utils.monitorFile(
  // directory that contains the scss files
  `${App.configDir}/styles/`,

  // reload function
  function () {
    console.log("Hello");
    // main scss file
    const sass = `${App.configDir}/styles/MainStyle.sass`;

    // target css file
    const css = `/tmp/my-style.css`;

    // compile, reset, apply
    Utils.exec(`sassc ${sass} ${css}`);
    App.resetCss();
    App.applyCss(css);
  }
);

// make sure sassc is installed on your system
Utils.exec(`sassc ${sass} ${css}`);

App.config({
  style: css,
  windows: [Bar(), notificationPopup, Chat()],
});
