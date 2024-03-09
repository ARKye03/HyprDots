export async function fetchCode(input: string) {
  // @ts-ignore
  const API_KEY = process.env.API_KEY;
  console.log(
    "Hello from fetchCode!+----------------------------------------------------------"
  );

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
