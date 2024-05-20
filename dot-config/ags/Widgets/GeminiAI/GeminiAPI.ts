//Not used anymore, changed to html
import GLib from "gi://GLib";

export async function fetchCode(input: string) {
  const API_KEY = GLib.getenv("API_KEY");

  if (!API_KEY) {
    throw new Error("API_KEY not found");
  }

  const response = await Utils.fetch(
    `https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=${API_KEY}`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        contents: [
          {
            role: "user",
            parts: [
              {
                text: input,
              },
            ],
          },
        ],
      }),
    }
  );

  const data = await response.json();

  const textParts = data.candidates.map((candidate: any) =>
    candidate.content.parts.map((part: any) => part.text)
  );

  return textParts;
}
