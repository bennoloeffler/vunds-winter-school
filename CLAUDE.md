# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project state

Greenfield: the repo currently contains only `README.md` (the brief, in German). No code, build system, tests or git history yet.

## The brief (from README.md)

Redesign of the V&S **Winter School** event page, now for **2027**. The page should impress through design, be immediately understandable, and read as promotional (werblich).

- **Content:** follow STRICTLY the existing page https://v-und-s.de/events-media/winter-school-2026/ — same content, updated to 2027. Alternative wording, placement and cuts may be *proposed*, not silently applied.
- **Style:** build **10 different drafts**, inspired by
  - the Lager.Feuer landing page: https://v-und-s.de/landingpage-lager-feuer-2026/
  - the current Winter School 2026 page (link above).
- **Tech constraints:**
  - Only HTML + JavaScript. No server, no build step, no backend.
  - Target is later embedding in **WordPress** — keep markup/CSS portable (scoped styles, no global resets that would clash with a WP theme).
  - Local only for now; hosting comes later.
  - Ideally **one single, fully self-contained `index.html`** (inline CSS/JS/assets).

Decided (2026-09-22): the 10 drafts are **10 separate, self-contained HTML files**, one per design direction.

## Files

- `CONTENT.md` — canonical page content (from the 2026 page, dates 2027). All drafts use it; deviations go in each draft's header comment.
- `BRIEF.md` — brand tokens (Campton → Outfit fallback, teal/slate/pink), inline V&S logo SVG, photo URLs on v-und-s.de, technical rules (`.ws27` scoping for WordPress, no iframes, no build).
- `NN-<slug>.html` — the drafts; `index.html` links them. `img/hero/` holds AI hero mockups (text baked in; use as composition reference only, never embed).
- `11-storytelling-hero.html` = draft 09 + three hero variants switchable via `?hero=a|b|c`; remove the `PREVIEW-SWITCHER` blocks before WordPress.
- `FEEDBACK.md` — Benno's review rules from round 2 (mood: bright/friendly/optimistic, never foggy/dark; teal→blue gradients only, no teal/slate→pink; calm buttons; no "Kapitel"; testimonials all visible; carousel rules; photo list rated by mood). **Read it before touching any draft ≥ 12.**
- `snippets/logos.html` + `logos.css` — the partner-logo block (50 logos: all Lager.Feuer SVGs + WinterSchool-only JPGs), content-cropped and area-balanced. Copy 1:1; size only via `--logo-k`. Preview: `snippets/logos-preview.html`.
- Round 2 drafts: 12/16 derive from 01, 13/14/15/17 from 11.
- **Never use emojis** (not in text, not in CSS `content`). Icons are SF-Symbols-style inline SVG line icons (24 viewBox, ~1.6 stroke, round caps/joins). See FEEDBACK.md §7.
- `index.html` shows desktop + phone hero thumbnails from `thumbs/NN-d.jpg` / `thumbs/NN-m.jpg`. After changing a draft's hero, regenerate its thumbnail (script in the session scratchpad was `thumbs.py`: headless Chrome with focus emulation, 1440×900 → 720 px and 390×844 → 234 px).

## Headless screenshots

Scroll reveals use IntersectionObserver. In headless Chrome it only fires when the page is focused: send `Page.bringToFront` + `Emulation.setFocusEmulationEnabled` first, otherwise sections render blank.

## Running

No tooling: open the HTML file directly in a browser (`open index.html`). Verify in a fresh/incognito window to rule out cache effects.
