// @ts-ignore
import Gtk from "gi://Gtk";
import { fetchCode } from "./GeminiAPI";
import { icons } from "assets/Assets";
import { fetchGroq } from "./GroqAPI";

const TextEntryWidget = Widget.subclass(Gtk.TextView);

const TextInputWidget = TextEntryWidget({
  // @ts-ignore
  wrap_mode: Gtk.WrapMode.WORD_CHAR,
  left_margin: 5,
  top_margin: 5,
  setup(self) {
    self.bind();
  },
});

// Wrap the TextInputWidget in a Scrollable
const ScrollableTextInputWidget = Widget.Scrollable({
  vscroll: "automatic",
  hscroll: "never",
  class_name: "inputBox",
  child: TextInputWidget,
});
// Create a reference to the center ListBox
const CenterListBox = Widget.ListBox({
  hexpand: false,
  class_name: "chatBox",
  setup(self) {
    self.add(
      Widget.Label({
        wrap: true,
        use_markup: true,
        label: "Hi there! How can I help you today?",
      })
    );
  },
});
const geminiChatHeader = Widget.Box({
  vexpand: true,
  class_name: "chatHeader",
  children: [
    Widget.Icon({
      icon: icons.Pacman,
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
      can_focus: false,
      onClicked: () => App.toggleWindow("Chat"),
      child: Widget.Icon({
        icon: icons.closeChatSvg,
        size: 50,
        hexpand: true,
      }),
    }),
  ],
});
const ScrollableListBox = Widget.Scrollable({
  class_name: "scrollChatBox",
  hscroll: "never",
  vscroll: "automatic",
  child: CenterListBox,
});
const resultListBox = Widget.Box({
  class_name: "input",
  spacing: 8,
  vexpand: true,
  homogeneous: false,
  vertical: false,
  children: [
    ScrollableTextInputWidget,
    Widget.Button({
      can_focus: false,
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
        fetchGroq(textToSend)
          .then((result) => {
            console.log(result);
            let resultText = Array.isArray(result) ? result.join(" ") : result;

            // Create a new Box with a Label containing the text
            let row = Widget.Box();
            let label = Widget.Label({
              label: resultText,
              wrap: true,
              use_markup: true,
              selectable: true,
            });
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
        icon: icons.sendSvg,
        size: 20,
      }),
    }),
  ],
});

const sideBarContent = Widget.CenterBox({
  vertical: true,
  vexpand: true,
  startWidget: geminiChatHeader,
  centerWidget: ScrollableListBox,
  endWidget: resultListBox,
});
export const Chat = () =>
  Widget.Window({
    name: "Chat",
    keymode: "on-demand",
    exclusivity: "normal",
    visible: false,
    class_name: "chat",
    anchor: ["top", "left", "bottom"],
    child: sideBarContent,
  });
