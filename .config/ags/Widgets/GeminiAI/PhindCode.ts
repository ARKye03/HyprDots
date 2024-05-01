export async function PhindCode(question: string) {
    const response = await Utils.fetch(`https://https.api.phind.com/infer/`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json;charset=UTF-8",
            Origin: "https://www.phind.com",
        },
        body: JSON.stringify({
            question: question,
            options: {}, // empty options
            context: "", // empty context
            challenge: 0, // dummy challenge
        }),
    });

    const data = await response.json();

    return data;
}
