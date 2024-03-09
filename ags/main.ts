import App from "resource:///com/github/Aylur/ags/app.js";
import { notificationPopup } from "./Widgets/NotificationPops";
import { Chat } from "Widgets/GeminiAI/Chat";
import { Bar } from "Widgets/Bar";
//import Dock from "Widgets/Dock/main";

App.config({
  style: "./styles/style.css",
  windows: [Bar(), notificationPopup, Chat() /* , Dock() */],
});
