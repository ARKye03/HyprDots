// @ts-ignore
import Gtk from "gi://Gtk";
import { fetchCode } from "./GeminiAPI";

const TextEntryWidget = Widget.subclass(Gtk.TextView);

const TextInputWidget = TextEntryWidget({
  // @ts-ignore
  wrap_mode: Gtk.WrapMode.WORD_CHAR, // Wrap text at character boundaries
  left_margin: 5, // Set left margin
  top_margin: 5, // Set left margin
  className: "inputBox",
  setup(self) {
    self.bind();
  },
});

// Wrap the TextInputWidget in a Scrollable
const ScrollableTextInputWidget = Widget.Scrollable({
  width_request: 350, // Set a fixed width of 350 pixels
  vscroll: "automatic",
  hscroll: "never",
  child: TextInputWidget,
});
// Create a reference to the center ListBox
const CenterListBox = Widget.ListBox({
  hexpand: false,
  setup(self) {
    self.add(Widget.Label({ label: "Hi there! How can I help you today?" }));
  },
});

// Wrap the ListBox in a Scrollable
const ScrollableListBox = Widget.Scrollable({
  height_request: 850,
  hscroll: "never",
  vscroll: "automatic",
  child: CenterListBox,
});

export const Chat = () =>
  Widget.Window({
    name: "Chat",
    keymode: "on-demand",
    width_request: 400,
    visible: false,
    class_name: "chat",
    anchor: ["top", "left", "bottom"],
    child: Widget.CenterBox({
      vertical: true,
      vexpand: true,
      startWidget: Widget.Box({
        vexpand: true,
        class_name: "chatHeader",
        children: [
          Widget.Icon({
            icon: "/home/archkye/.config/ags/assets/pacman.svg",
            class_name: "pacman",
            size: 60,
            hpack: "start",
            hexpand: true,
          }),
          Widget.Label({
            label: "Gemini here for you.",
            hpack: "center",
            hexpand: true,
          }),
          Widget.Button({
            onClicked: () => App.toggleWindow("Chat"),
            class_name: "closeButton",
            child: Widget.Icon({
              icon: "/home/archkye/.config/ags/assets/closeChat.svg",
              size: 50,
              hexpand: true,
            }),
          }),
        ],
      }),
      centerWidget: ScrollableListBox,
      endWidget: Widget.Box({
        class_name: "input",
        spacing: 8,
        vexpand: true,
        homogeneous: false,
        vertical: false,
        children: [
          ScrollableTextInputWidget,
          Widget.Button({
            class_name: "sendButton",
            onClicked: async () => {
              let startIter = TextInputWidget.get_buffer().get_start_iter();
              let endIter = TextInputWidget.get_buffer().get_end_iter();
              let textToSend = TextInputWidget.get_buffer().get_text(
                startIter,
                endIter,
                true
              );
              print("Send: " + textToSend);
              fetchCode(textToSend)
                .then((result) => {
                  console.log(result);
                  let resultText = Array.isArray(result)
                    ? result.join(" ")
                    : result;

                  // Create a new Box with a Label containing the text
                  let row = Widget.Box();
                  let label = Widget.Label({ wrap: true, label: resultText });
                  row.add(label);

                  // Add the Box to the top of the ListBox
                  CenterListBox.prepend(row);

                  // Show the Box
                  row.show_all();
                })
                .catch((error) => {
                  // handle the error here
                  console.log(error);
                });
            },
            child: Widget.Icon({
              icon: "/home/archkye/.config/ags/assets/send.svg",
              size: 20,
            }),
          }),
        ],
      }),
    }),
  });
