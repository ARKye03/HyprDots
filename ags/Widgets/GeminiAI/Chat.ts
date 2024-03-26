// @ts-ignore
import WebKit2 from "gi://WebKit2";
import GLib from "gi://GLib";

// Create a WebView
const webView = new WebKit2.WebView();

// Convert the path of your HTML file to a file:// URI
const htmlFilePath = GLib.filename_to_uri("/home/archkye/.config/ags/Widgets/GeminiAI/GeminiChat.html", null);
console.log(htmlFilePath);

// Load the HTML file into the WebView
webView.load_uri(htmlFilePath);

export const Chat = () =>
  Widget.Window({
    name: "Chat",
    width_request: 400,
    keymode: "on-demand",
    class_name: "chat",
    exclusivity: "normal",
    visible: false,
    anchor: ["top", "left", "bottom"],
    child: webView,
  });