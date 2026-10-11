# Learnxt · Multi-AI flashcard study studio

**A beginner-friendly website that turns topics, notes, and readable PDFs into active-recall flashcards.**

This edition upgrades the existing Learnxt website with **three AI choices: Google Gemini, Groq, and OpenAI**. The lavender/mint theme, clickable logo, flashcards, self-test, review scheduling, starred cards, deck editing, and JSON backup all remain.

The website has two parts:
- **Frontend** = `public/index.html` (the page), `public/styles.css` (colors/layout), `public/app.js` (buttons/flashcard interactions).
- **Backend** = `server.js` (runs in Node.js, reads API keys, talks to AI providers, returns JSON flashcards).

## A. First-time Windows setup — follow in order

### Step 1: Download and extract the ZIP
1. Right-click the `Learnxt-Multi-AI.zip` file in Downloads.
2. Choose **Extract All...** and click **Extract**.
3. In the extracted folder, open **Learnxt**. You should see `server.js`, `package.json`, `public`, and `.env.example`. Sometimes Windows creates an *outer* folder; open the inner one.

**Do not delete your old Learnxt folder first.** This is a separate updated project. To keep your existing decks, go to the old website's **Preferences & data → Export all decks**, then use **Import JSON** in the updated website. If you continue using the same browser address and have not cleared browser data, old decks may also still be present automatically.

### Step 2: Install what you need
- **Visual Studio Code**: https://code.visualstudio.com/
- **Node.js 20+ (prefer current LTS)**: https://nodejs.org/
- A browser: Chrome, Edge or Firefox.

VS Code is a code editor. Node.js makes the backend run. Chrome/Edge opens the website. **No `npm install` is required.**

### Step 3: Open the correct folder in VS Code
1. Open VS Code → **File → Open Folder**.
2. Choose the **Learnxt** folder that contains both `package.json` and `server.js`.
3. Click **Terminal → New Terminal**. This bottom panel is where you type commands.
4. Type `dir` and press Enter. You should see `server.js` and `package.json`.
5. Type `node -v` and press Enter. It should show version **20 or later**.

### Step 4: Set up ONE AI provider
You only need **one** key to get started. The dropdown lets you switch to any other provider when its key is configured.

Provider | Where you get a key | Key name in `.env` | Notes
--- | --- | --- | ---
Groq | https://console.groq.com/keys | `GROQ_API_KEY` | Free-tier option with usage limits. Model default: `openai/gpt-oss-20b`.
Google Gemini | https://aistudio.google.com/apikey | `GEMINI_API_KEY` | May have a free tier, model/quotas and grounding vary. Default: `gemini-2.5-flash`.
OpenAI | https://platform.openai.com/api-keys | `OPENAI_API_KEY` | Typically **paid, separate from ChatGPT subscriptions**. Default: `gpt-4.1-mini`.

Sign in with an account eligible to use the chosen service; follow provider terms and ask a parent/guardian when account/billing setup requires their involvement. Never publish or message anyone your key.

**In the VS Code terminal (PowerShell), type:**

```powershell
Copy-Item .env.example .env
```

This creates `.env`, a private text configuration file next to `server.js`. You can also right-click the main Learnxt folder → New File → `.env`, then copy the example.

**Open `.env` and replace only the placeholder for the provider you want**, for example:

```dotenv
GROQ_API_KEY=YOUR_REAL_GROQ_KEY
GROQ_MODEL=openai/gpt-oss-20b

GEMINI_API_KEY=replace_with_your_gemini_key
GEMINI_MODEL=gemini-2.5-flash

OPENAI_API_KEY=replace_with_your_openai_key
OPENAI_MODEL=gpt-4.1-mini

PORT=3000
```

No spaces around `=`. Keep `.env` in the **main Learnxt folder, not `public`**. Save with **Ctrl + S**. To enable more providers, replace their placeholders too. `GROQ_MODEL=openai/gpt-oss-20b` is a Groq-hosted open-weight model and requires a **Groq** key, not an OpenAI key.

### Step 5: Start the website

In the integrated terminal in the correct folder:

```powershell
npm start
```

Then open your browser at:

**http://localhost:3000**

Keep the terminal open while using Learnxt. You can also double-click `START_LEARNXT_WINDOWS.bat` from the project folder.

**`localhost` is a link to your own computer**, not a public internet address. A hosting service is needed before strangers can open your website.

### Step 6: Confirm configured providers
In Chrome/Edge, open **http://localhost:3000/api/status**.

Example *shape* (never displays private API keys):

```json
{
  "connected": true,
  "providers": [
    { "id": "gemini", "label": "Google Gemini", "configured": false, "model": "gemini-2.5-flash", "research": "Google Search grounding" },
    { "id": "groq", "label": "Groq", "configured": true, "model": "openai/gpt-oss-20b", "research": "Groq browser search" },
    { "id": "openai", "label": "OpenAI", "configured": false, "model": "gpt-4.1-mini", "research": "OpenAI web search" }
  ],
  "defaultProvider": "groq"
}
```

`configured: true` means the backend found a key; **it does not confirm the key is valid**. A successful AI generation is the real connection test.

### Step 7: Test flashcard generation
1. Go to **http://localhost:3000**.
2. Click **Create flashcards** in the sidebar.
3. Under **AI provider**, choose one marked **Ready**.
4. Choose **Topic** and type `Ohm's law`.
5. Select **5 flashcards**, Balanced level.
6. Keep **Web research OFF for your first test** to reduce cost and possible API errors.
7. Click **Generate my flashcards**. Successful output should show five flashcards you can flip and study.
8. You can later switch providers, enable research, paste notes, or upload a text PDF.

## B. What each provider does

Every provider produces the **same card format** (question, answer, explanation, example, memory tip, tag). Switching providers does **not** erase existing cards.

With optional **Web research** ON, the backend performs a research request before generating the JSON deck:
- **Gemini** → Google Search grounding.
- **Groq** → Groq browser-search built-in tool with a supported model (`openai/gpt-oss-20b` default).
- **OpenAI** → Responses API `web_search` built-in tool with a supported model (`gpt-4.1-mini` default).

Sources (if any) are returned by the research step and shown under the Sources tab. **Links do not guarantee card-level fact checking**; always verify key formulas, medical claims, legal facts, dates, and numerical values using reliable textbooks or sources. The deck's `verified` property stays `false`.

**PDF limitation:** Learnxt uses PDF.js (loaded when needed from cdnjs) in the browser to extract up to 30,000 characters from the first 40 pages of a selectable-text PDF (file limit 6 MB). **Image-only/scanned PDFs are not supported without OCR.** Only extracted text, not the PDF file, is sent to the chosen AI API. PDF.js needs internet access.

## C. Everyday Learnxt use

- **Home / logo:** Click the Learnxt logo at top-left to go Home.
- **Create flashcards:** Select provider, add topic/notes/PDF, pick difficulty and count.
- **Study:** Click a flashcard to reveal the answer and reasoning. Rate Again / Got it / Easy; revisit scheduled cards.
- **Self-test:** Write your own answer, reveal the model answer, rate your recall yourself (automatic grading is not included).
- **Saved cards:** Star, shuffle, search, edit, delete, and export decks.
- **Preferences & data:** Theme switch, configured provider status, JSON export/import.

Study decks are saved in **browser localStorage**, not a server database. Clearing browser data or changing browsers can lose decks. Use Export all decks for backups. The browser remembers which AI provider you selected, but **never stores API keys**.

## D. Troubleshooting

Problem | Fix
--- | ---
`npm ERR! Missing script: start` | You probably opened the wrong folder. In VS Code open the **inner** Learnxt folder, right-click that folder → **Open in Integrated Terminal**, then run `npm start`.
`node` or `npm` not recognized | Install Node.js LTS, close/reopen VS Code, then try `node -v`.
`Selected provider is not configured` | Check that `.env` exists **beside** `server.js`, has the correct provider key and no placeholder, save and restart the server (Ctrl+C, then `npm start`).
API reports 401/403 | Invalid/restricted key or account; check the chosen provider's console. Don't paste keys into messages or screenshots.
API reports 429 | Free-tier request/token limit or paid quota limit reached. Wait, reduce cards, or disable Web research.
API reports 400 | Model may be unavailable or unsupported; check which model is enabled for your account and set `GROQ_MODEL`, `GEMINI_MODEL`, or `OPENAI_MODEL` in `.env` accordingly.
Failed to load PDF | Check internet access, that PDF text is selectable, or copy its text into Paste notes.
Port 3000 already in use | Stop the earlier server (Ctrl+C in its terminal), or set `PORT=3001` and open http://localhost:3001.
Old decks missing | Open your old site/browser profile, export a JSON backup, then import into this edition.
Site shows demo only | Sample deck works without keys. `/api/status` lets you check providers' configuration states.

## E. Running tests

In VS Code terminal:

```powershell
npm test
```

This verifies input validation, server security basics, status responses, and **mocked** requests for all three providers. A passing test does not prove that a real provider API is reachable. Testing with your own key is required.

## F. Security and limits

- **Keep keys only server-side** in `.env`. `.gitignore` excludes `.env`.
- The server only serves files inside `public` (not the key file), accepts a limited request size and caps requests by IP.
- The local web server binds to `127.0.0.1` by default. **Do not publish it publicly without authentication, abuse prevention, HTTPS, persistent storage decisions, and stronger rate limits.**
- API requests submit your notes/PDF text to your chosen AI provider. Don't upload private or sensitive material without permission.
- OpenAI API is usually metered and separately billed. Research requests and long PDFs use more tokens. Groq/Gemini free-tier access and quotas vary.
- No automatic fallback or shared user login is included. You deliberately choose a provider for each deck.

## G. References

- Groq chat & JSON: https://console.groq.com/docs/api-reference
- Groq browser search: https://console.groq.com/docs/tool-use/built-in-tools/browser-search
- Gemini API: https://ai.google.dev/gemini-api/docs
- OpenAI Responses API: https://platform.openai.com/docs/api-reference/responses
- OpenAI web search: https://platform.openai.com/docs/guides/tools-web-search
- OpenAI structured outputs: https://platform.openai.com/docs/guides/structured-outputs

**Learnxt helps you practise recall and understanding; it does not replace checking authoritative course material.**
