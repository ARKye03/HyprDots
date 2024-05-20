//Not used anymore, changed to html
import GLib from "gi://GLib";

export async function fetchGroq(input: string) {
  const API_KEY = GLib.getenv("GROQ_API_KEY");

  if (!API_KEY) {
    throw new Error("API_KEY not found");
  }

  const response = await Utils.fetch(
    `https://api.groq.com/openai/v1/chat/completions`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${API_KEY}`,
      },
      body: JSON.stringify({
        messages: [
          {
            role: "user",
            content: input,
          },
        ],
        model: "llama2-70b-4096",
      }),
    }
  );

  const data = await response.json();

  const textParts = data.choices.map((choice: any) => choice.message.content);

  return textParts;
}
/*
curl -X POST "https://api.groq.com/openai/v1/chat/completions" \
     -H "Authorization: Bearer $GROQ_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"messages": [{"role": "user", "content": "Explain the importance of low latency LLMs"}], "model": "mixtral-8x7b-32768"}'
*/
