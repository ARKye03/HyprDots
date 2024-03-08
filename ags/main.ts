import App from "resource:///com/github/Aylur/ags/app.js";
import { notificationPopup } from "./Widgets/NotificationPops";
import { Chat } from "Widgets/GeminiAI/Chat";
import { Bar } from "Widgets/Bar";

App.config({
  style: "./styles/style.css",
  windows: [Bar(), notificationPopup, Chat()],
});
