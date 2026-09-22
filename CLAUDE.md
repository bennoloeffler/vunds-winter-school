# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Landing-page drafts for the **V&S WinterSchool 2027** (Vollmer & Scheffczyk, management consultancy). Plain HTML/CSS/JS, no build, no server; the chosen draft will later be pasted into WordPress (v-und-s.de, Elementor theme).

- Live (GitHub Pages): https://bennoloeffler.github.io/vunds-winter-school/ — repo `bennoloeffler/vunds-winter-school` (**public**; GitHub Free can't do Pages from private repos). Every push to `main` redeploys in ~1 min.
- Full history, rules and lessons learned: **`docs/PROJEKT-DOKU.md`**. Current hand-off: `RP.md`.
- Language: page content and docs are German; Benno writes prompts in English or German.

## Read before changing anything

| File | What it is |
|---|---|
| `FEEDBACK.md` | **Binding design rules** from Benno's reviews (mood, colors, buttons, structure, logos, carousel, no emojis). Read fully before touching drafts ≥ 11. |
| `CONTENT.md` | Canonical page text (from the 2026 page, dates already 2027). Don't invent content; deviations go in the draft's head comment. |
| `BRIEF.md` | Brand tokens, inline V&S logo SVG, photo URLs on v-und-s.de, tech rules. |

## Layout

- `index.html` — only redirects to the chosen draft (currently `15-storytelling-freundlich.html`). To change the entry page, edit the three URLs in it.
- `previews.html` — overview: live, scrollable iframe previews of 11–17 (rendered at exactly 1440×900 or 390×844 and scaled; Desktop/Smartphone toggle; A/B/C buttons for 11 and 13) plus a link list for 01–10. When adding a draft, add an `<article class="pv">` there and a thumbnail.
- `NN-<slug>.html` — one self-contained draft each. Round 1: 01–10 (+11 = 09 with statement hero). Round 2 (after feedback): 12/16 derive from 01; 13/14/15/17 from 11.
- `snippets/logos.html` + `logos.css` — partner-logo block (50 logos), copy 1:1; size only via `--logo-k`, never add sizing to `.lg`/`img`.
- `preview-link.js` — hidden link to `previews.html` at the end of every page (skipped inside iframes).
- `thumbs/` — `NN-d.jpg` (1440×900 → 720 px) and `NN-m.jpg` (390×844 → 234 px) placeholders for `previews.html`.
- `tools/` — screenshot/check scripts (below). `img/hero/` — AI hero mockups: composition reference only, text baked in, never embed.

## Conventions every draft must keep

- Everything scoped under `.ws27` (no global resets) so it survives inside a WordPress theme. Font stack `"Campton","Outfit",…` (Campton is self-hosted on v-und-s.de; Outfit via Google Fonts locally).
- Photos and logos are absolute URLs on `v-und-s.de/wp-content/uploads/…` — don't download them into the repo.
- No CDN scripts, no iframes/Google Maps embeds (map = link), `prefers-reduced-motion` respected, no horizontal scroll from 360 to 1600 px.
- **Never emojis.** Icons = inline SVG line icons in SF-Symbols style (24 viewBox, stroke ~1.6, round caps/joins, `currentColor` or CSS `mask`).
- Mood bright and friendly (see photo rating in `FEEDBACK.md`); teal→blue gradients only, never teal/slate→pink; flat buttons with calm hover.
- Head comment right after `<!DOCTYPE html>`: `<!-- Entwurf NN: … — Idee: … — Abweichungen vom Original: … -->`.
- Last line before `</body>`: `<script src="preview-link.js" defer></script>`.
- The intro text after the hero is identical in 11–17 (exact wording in `FEEDBACK.md` §4).
- 11 and 13 contain a `PREVIEW-SWITCHER` (hero A/B/C via `?hero=`); remove before WordPress.

## Commands

```bash
open index.html                 # or any draft; no build step
open previews.html              # the overview (iframes work best via a local server, e.g. VS Code Live Server)

# Check a draft: overflow, JS errors, broken images, hidden sections + screenshots at 1440 and 390
uv run --with websocket-client --with pillow python tools/shoot.py 9401 15-storytelling-freundlich.html /tmp/s15
#   one port per parallel run; look at /tmp/s15/*-hero.jpg and *-full-*.jpg (Read with limit: 1)

# Regenerate thumbnails after a hero changes (pass args as separate words)
uv run --with websocket-client --with pillow python tools/thumbs.py 9395 thumbs 15-storytelling-freundlich.html=15 "13-storytelling-hell.html?hero=b=13b"

# Emoji check (must print nothing)
python3 -c "import re,glob;[print(f) for f in glob.glob('*.html') if re.search('[\U0001F000-\U0001FAFF☀-➿]',open(f,encoding='utf-8').read())]"

git push                        # publishes via GitHub Pages
```

## Gotchas

- Headless Chrome fires IntersectionObserver (scroll reveals) only with focus: `Page.bringToFront` + `Emulation.setFocusEmulationEnabled` (the tools do this). Blank sections in a screenshot usually mean this, not a bug.
- `chrome-agent` has a fixed 756 px viewport — use `tools/shoot.py` for real desktop width.
- When splicing a section from one draft into another, prefix its classes (drafts style `.tag`, `.foot`, `.claim` globally) and insert before computing further offsets.
- zsh doesn't word-split `$var` — pass argument lists as arrays or from Python.
- Image reads are blocked by a line-count hook unless `limit: 1` is passed.
