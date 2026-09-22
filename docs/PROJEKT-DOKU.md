# V&S WinterSchool 2027 — Projekt-Dokumentation

Stand: 22.09.2026 · Live: https://bennoloeffler.github.io/vunds-winter-school/ · Repo: https://github.com/bennoloeffler/vunds-winter-school (öffentlich)

Diese Datei hält fest, **was gebaut wurde, nach welchen Regeln und was dabei gelernt wurde.**
Die verbindlichen Design-Regeln stehen ausführlich in [`FEEDBACK.md`](../FEEDBACK.md), der Inhalt in [`CONTENT.md`](../CONTENT.md), Marke und Technik in [`BRIEF.md`](../BRIEF.md).

---

## 1. Ziel und Ergebnis

**Ziel** (aus der ursprünglichen README): die Seite der V&S WinterSchool neu gestalten, für 2027 — werblich, klar verständlich, gutes Design. Inhalt streng nach der bisherigen Seite (v-und-s.de/events-media/winter-school-2026), Stil orientiert an der Lager.Feuer-Landingpage und der bisherigen Seite. Nur HTML + JavaScript, kein Server, später in WordPress.

**Ergebnis:**

| Datei | Zweck |
|---|---|
| `index.html` | Einstieg — leitet auf den gewählten Entwurf weiter (aktuell **15**) |
| `previews.html` | Übersicht: Live-Vorschau (scrollbar, Desktop/Smartphone) der Entwürfe 11–17, Linkliste 01–10 |
| `01-…html` bis `17-…html` | 17 Entwürfe, jeder eine eigenständige Datei |
| `snippets/logos.*` | Partner-Logo-Block (50 Logos), in allen Entwürfen ab 12 |
| `preview-link.js` | versteckter Link am Ende jeder Seite zur Übersicht |
| `thumbs/` | Vorschaubilder (Platzhalter in `previews.html`) |
| `tools/` | Screenshot- und Prüfskripte (siehe §6) |

---

## 2. Ablauf

### Runde 0 — Grundlagen
1. Originalseite und Lager.Feuer-Seite per `curl` geholt, Text extrahiert → **`CONTENT.md`** (kanonischer Inhalt; die Originalseite trug bereits die 2027er Termine 20.–22. Januar).
2. Markenwerte aus dem Elementor-Kit von v-und-s.de gelesen → **`BRIEF.md`**: Schrift **Campton** (selbst gehostet, lokal nicht verfügbar → Ersatz **Outfit** von Google Fonts), Farben Teal `#006D7E` / `#179bb1`, Slate `#364459`, Pink `#f2295b`; V&S-Logo als Inline-SVG; Foto-URLs von v-und-s.de.
3. Technische Regeln festgelegt: eine Datei pro Entwurf, alles unter `.ws27` gescoped (WordPress-tauglich), keine CDN-Skripte, keine Google-Maps-iframes, 360–1600 px ohne Querscrollen, `prefers-reduced-motion`.

### Runde 1 — zehn Richtungen (01–10) + 11
Zehn parallele Agenten, je eine Designrichtung (Tabelle §4). Währenddessen lieferte Benno 11 KI-Hero-Mockups (`img/hero/`); Bennos Hinweis „nicht alles umbauen, ich will eure Entwürfe sehen" → die Entwürfe blieben unverändert. **11** = Entwurf 09 mit neuem Statement-Hero („50 % schneller. 80 % weniger Prozess-Wahnsinn.") in drei umschaltbaren Varianten nach den Mockups.

### Runde 2 — Feedback zu 01 und 11 (12–17)
Bennos Review, festgehalten in `FEEDBACK.md`:
- Stimmung **optimistisch, freundlich, lächelnd, konzentriert** — nie neblig, düster, traurig.
- **Kein Teal→Pink- / Slate→Pink-Verlauf.** Stattdessen Teal→Blau.
- **Elegante Buttons**, dezenter Hover, kein Glow.
- Alle Original-Karussellbilder; die Impressionen-Galerie des Originals.
- Kein „Kapitel", verständliche Navigation, **Einleitungstext** nach dem Hero, Stimmen ohne Slider.

Sechs parallele Agenten bauten 12–17 (Tabelle §4). Danach kamen, jeweils live eingearbeitet:
- **Logos doppelt so groß** → erst zu groß/verrutscht → gemessene Lösung → dann **alle 50 Partner** von der Lager.Feuer-Seite (§5.3).
- **Karussell** 30 % schneller, Weiter-Knopf, Klick schaltet weiter (§5.5).
- **Keine Emojis, niemals** — nur Icons im Stil von Apple SF Symbols (§5.6).
- **Visuelle Übersicht** → erst Screenshot-Karten, dann Live-Vorschau in iframes (§5.7).
- Struktur: `index.html` → Weiterleitung auf 15, Übersicht nach `previews.html`, versteckter Link auf jeder Seite, Veröffentlichung über GitHub Pages (§5.8).
- **Einleitungstext** wortgleich in allen Entwürfen ab 11.

---

## 3. Die Regeln in Kürze

Vollständig in `FEEDBACK.md` (§1–8). Das Wichtigste:

| Thema | Regel |
|---|---|
| Stimmung | hell, freundlich, lächelnde/konzentrierte Menschen; max. eine dunkle Sektion; Overlays nur hinter Text |
| Fotos | Liste mit Einstufung in `FEEDBACK.md` §1 — bevorzugt: lachender Referent (1090706), lachende Gruppe (1130645), Plenum2, TIC-Hendrik …; vermeiden: nebliger See, dunstige Terrasse, dunkle Bar-/Bühnenbilder |
| Farben | Teal→Blau (`#006D7E → #179bb1 → #5d7fb0`); Pink nur als winziger Akzent |
| Buttons | flach, Radius 8–10 px, kein Verlauf, kein Glow; Hover eine Stufe dunkler, Pfeil 3 px, max. 1 px anheben |
| Struktur | kein „Kapitel"; Nav „Worum es geht · Programm · (Impressionen ·) Stimmen · Infos & Preise · Anmelden"; Einleitungstext nach dem Hero; alle Stimmen sichtbar |
| Logos | `snippets/logos.*` unverändert übernehmen; Größe nur über `--logo-k` |
| Karussell | 3,5 s, kein Pausieren bei Maus-Hover, Pfeile, Klick/Wischen/Pfeiltasten |
| Icons | **keine Emojis**; Inline-SVG-Linien-Icons (24er viewBox, Strich ~1,6, runde Enden) |
| Technik | eine Datei, `.ws27`-Scope, keine CDN-Skripte, keine iframes, reduced-motion, kein Querscrollen |
| Jede Seite | endet mit `<script src="preview-link.js" defer></script>` |

---

## 4. Die Entwürfe

| Nr. | Datei | Basis | Idee |
|---|---|---|---|
| 01 | `01-klassisch-vs.html` | — | Evolution der heutigen Seite (Verlauf, Tages-Tabs) |
| 02 | `02-lagerfeuer-dark.html` | — | Lager.Feuer-Schwester, schwarz, Teal als einziger Akzent |
| 03 | `03-editorial-magazin.html` | — | Magazin-Cover, Inhaltsverzeichnis, Agenda als Tabelle |
| 04 | `04-bootcamp-poster.html` | — | Plakat: 50 % / 80 % riesig, Farbblöcke, Ticker |
| 05 | `05-winter-see.html` | — | Winter am See, Frost-Palette, Glaskarten |
| 06 | `06-agenda-timeline.html` | — | Programm als Timeline mit Tagesnavigation |
| 07 | `07-split-screen.html` | — | festes Faktenpanel links, Inhalt scrollt rechts |
| 08 | `08-bento-grid.html` | — | Bento-Kacheln |
| 09 | `09-storytelling-scroll.html` | — | Erzählung in fünf Abschnitten mit Scroll-Effekten |
| 10 | `10-minimal-typo.html` | — | nur Typografie, Linien, ein Foto |
| 11 | `11-storytelling-hero.html` | 09 | Statement-Hero, Varianten `?hero=a\|b\|c` |
| 12 | `12-klassisch-hell.html` | 01 | Teal→Blau, lachende Gruppe, 8 Original-Karussellbilder |
| 13 | `13-storytelling-hell.html` | 11 | drei helle Heroes (A Collage, B Referent, C Teal-Duoton) |
| 14 | `14-storytelling-impressionen.html` | 11 | Text steht, Fotos überblenden; 24er-Galerie mit Großansicht |
| **15** | `15-storytelling-freundlich.html` | 11 | **ganz hell**, weißer Hero mit lachender Gruppe — **aktueller Einstieg** |
| 16 | `16-klassisch-impressionen.html` | 01 | Fotos überblenden hinter heller Karte, Programm in drei Spalten, Galerie |
| 17 | `17-gesichter-mosaik.html` | 11 | Hero als Mosaik lachender Gesichter um eine Botschaftskarte |

Jeder Entwurf dokumentiert im **Kopfkommentar** (direkt nach `<!DOCTYPE html>`) seine Idee und alle Abweichungen vom Original-Inhalt.

---

## 5. Erkenntnisse (teuer gelernt)

### 5.1 Inhalt und Marke
- Die Originalseite trug schon die 2027er Termine; der Inhalt wurde 1:1 übernommen, Umformulierungen nur als dokumentierte Abweichung.
- Markenfarben und Schrift stehen im Elementor-Kit (`/wp-content/uploads/elementor/css/post-5.css`): `--e-global-color-primary:#006D7E`, Schrift Campton.
- Campton ist auf v-und-s.de selbst gehostet. Die Entwürfe deklarieren `"Campton","Outfit",…` — auf WordPress greift automatisch Campton.
- Die „Max Mustermann"-Platzhalter der Originalzitate wurden nicht übernommen (anonym oder Rolle).

### 5.2 Stimmung und Fotos
- Die Seefotos (Steg, Nebel, Morgen) wirken mit dunklem Overlay sofort trüb. Menschen, die lachen oder konzentriert arbeiten, tragen die gewünschte Stimmung.
- Der lachende Referent steht vor einem roten Vorhang — passt schlecht zu Teal/Blau (Entwurf 12 nimmt deshalb die lachende Gruppe; in 13 B ist der Vorhang „laut").
- Original-Karussell (8 Folien) und Galerie (24 Fotos) wurden aus dem Seiten-HTML/Elementor-CSS ausgelesen; Liste in `FEEDBACK.md`.
- Nur 11 der 24 Galerie-Fotos gibt es in kleinerer WordPress-Größe; die übrigen laden 2560 px (lazy).

### 5.3 Partner-Logos
- Die alten `*_optimiert.jpg` sind 300×250 px mit **eingebautem weißem Rand** (Logo füllt ~65 % Breite, ~25 % Höhe). Hochskalieren per CSS schnitt Logos ab und verschob sie.
- **Lösung:** Sichtbaren Inhalt jedes Logos gemessen (Pillow für JPG/PNG, Canvas im Browser für SVG), Logo exakt darauf beschnitten (`--w`, `--l`, `--t` als CSS-Variablen) und **flächengleich** skaliert: Breite = `--logo-k` × √Seitenverhältnis. So wirken breite (Schüco) und quadratische (NORD) Logos gleich groß.
- Die Lager.Feuer-Logos sind **weiße SVGs** → auf hellem Grund `filter:brightness(0)` + Deckkraft; Klasse `on-dark` für dunkle Sektionen.
- Trumpf ist ein Vollflächen-Quadrat → wirkt dunkel wie ein Block → Klasse `soft` (heller, kleiner).
- 50 Logos, 7 pro Zeile, letzte Zeile zentriert (Flexbox), `box-sizing:border-box` nötig, sonst passen nur 6.

### 5.4 Zusammenbauen von Entwürfen aus anderen
- **Klassen-Kollisionen:** 09 stylt `.tag`, `.foot`, `.claim` global — ein neuer Hero mit denselben Klassennamen erbte fremde Styles (Pink-Pille, unsichtbare Blöcke). Lösung: Hero-Klassen mit `h-` präfixen.
- **Offset-Falle beim Einspleißen:** Positionen in einem String berechnen, dann vor dem Einsetzen etwas anderes einfügen → Einsatz landet an falscher Stelle (Hero mitten in der Navigation). Erst einsetzen, dann weitere Einfügungen.
- Inhalte „above the fold" nie vom Scroll-Reveal (IntersectionObserver) abhängig machen — eigene CSS-Einblend-Animation.

### 5.5 Karussell
- „Pausieren bei Maus-Hover" wirkt wie „hängt", sobald die Maus darüber liegt. Jetzt: nur Tastatur-Fokus und reduced-motion pausieren.
- Bildunterschriften nacheinander ein-/ausblenden, sonst überlagern sich zwei Texte.

### 5.6 Icons statt Emojis
- Emojis (☕ 🚗 🍽 🥂, ✓) wirken billig. Ersetzt durch SVG-Linien-Icons über CSS-`mask` (Farbe = `background-color`) bzw. als `background` auf dem Häkchen-Kreis. Prüfung: Suche nach Emoji-Codepoints in allen HTML-Dateien muss leer sein.

### 5.7 Vorschau-Übersicht (`previews.html`)
- Live-Vorschau = echtes `<iframe>` in **exakt 1440×900** gerendert und per `transform:scale()` verkleinert. Ist der iframe höher als ein echter Bildschirm, werden Heroes mit `100vh` riesig gestreckt.
- Smartphone-Modus: 390×844 im Telefonrahmen; Bühnenhöhe aus der Skalierung berechnen, sonst wird das Telefon unten abgeschnitten.
- Unter `file://` sind iframes fremde Ursprünge — der Vorschau-Umschalter in 11/13 blendet sich deshalb selbst aus, wenn `window.top !== window.self`.

### 5.8 Veröffentlichung
- **GitHub Free veröffentlicht Pages nur aus öffentlichen Repos.** Private Repo + Pages braucht GitHub Pro (oder Team). Entscheidung: Repo öffentlich — damit sind auch `FEEDBACK.md`, `CLAUDE.md` und die KI-Mockups öffentlich einsehbar.
- `.nojekyll` im Repo, damit Pages die Dateien unverändert ausliefert. Jeder Push auf `main` baut die Seite in ~1 Minute neu.

### 5.9 Werkzeuge und Umgebung
- **Headless Chrome feuert IntersectionObserver nur mit Fokus:** vor Screenshots `Page.bringToFront` + `Emulation.setFocusEmulationEnabled`. Ohne das bleiben alle Scroll-Reveal-Sektionen leer (frühe Review-Screenshots waren deshalb weiß — kein Fehler der Seiten).
- `chrome-agent` hat ein festes 756-px-Viewport; für Desktop-Breite einen eigenen headless Chrome mit `--remote-debugging-port` starten und per CDP steuern (`tools/shoot.py`).
- Bei `captureScreenshot` mit `clip` sind die Koordinaten **Seiten**-Koordinaten (`getBoundingClientRect` + `scrollY`).
- **zsh teilt `$var` nicht in Wörter** — Argumentlisten als Array bzw. aus Python übergeben.
- Ein Read-Hook blockiert Bilder mit „zu vielen Zeilen" — Bilder mit `limit: 1` lesen.
- Parallele Agenten: jeder bekommt einen **eigenen Chrome-Port**; Aufträge, die sich während der Arbeit ändern, in einer Datei (`FEEDBACK.md`) festhalten statt nur per Nachricht — so arbeiten alle nach demselben Stand.
- Claude Code: lange Einfügungen erscheinen als `[Pasted text #N +X lines]`. **Nochmal einfügen** klappt sie im Eingabefeld auf; `Ctrl+G` öffnet den Prompt im Editor. Der volle Text wird immer gesendet.

---

## 6. Werkzeuge (`tools/`)

Alle mit `uv run --with websocket-client --with pillow python tools/<skript> …` aus dem Repo-Wurzelverzeichnis.

| Skript | Zweck |
|---|---|
| `shoot.py <port> <datei.html> <ausgabeordner> [query]` | startet headless Chrome, prüft bei 1440 und 390 px: Querscrollen, JS-Fehler, kaputte Bilder, versteckte Sektionen; speichert Hero- und Ganzseiten-Screenshots |
| `thumbs.py <port> thumbs <datei=name> …` | erzeugt `thumbs/<name>-d.jpg` / `-m.jpg` für `previews.html` |
| `elshot.py <port> <file-url> "<selektor>" <out.png>` | Screenshot eines einzelnen Elements (z. B. Icons prüfen) |

---

## 7. WordPress-Einbau (Checkliste)

1. Endgültigen Entwurf wählen (aktuell 15).
2. Aus der Datei entfernen: `<script src="preview-link.js" defer></script>`; bei 11/13 zusätzlich die Blöcke `PREVIEW-SWITCHER` (HTML + JS) und eine Hero-Variante fest setzen (`data-hero`).
3. Eventuelle Vorschau-Hilfen wie `body{margin:0}` (in einzelnen Entwürfen als „nur Vorschau" markiert) entfernen — das Theme liefert das.
4. Inhalt von `<style>` und dem `.ws27`-Block in ein HTML-Widget/Custom-HTML-Block übernehmen; das Script am Ende mitnehmen.
5. Header/Footer der Seite liefert WordPress — die Entwurfs-Leiste ggf. weglassen.
6. Fotos und Logos liegen bereits auf v-und-s.de (absolute URLs) — nichts hochladen.

---

## 8. Offen / zu entscheiden (Benno)

- Welcher Entwurf wird es? (Einstieg zeigt derzeit 15.)
- Entwurf 13: welche Hero-Variante (A/B/C)? B: roter Vorhang zu laut?
- Einleitungstext fehlt in 01–10 (alte Runde) — ergänzen oder so lassen?
- Repo privat halten? → GitHub Pro nötig (dann Repo auf privat stellen, Pages bleibt).
- Entwurf 17 mobil: Mosaik-Fotos sind quadratisch beschnitten — so lassen oder unbeschnitten?
- Wischen im Karussell (12) auf einem echten Smartphone testen.
- Galerie (14, 16): 13 Fotos nur in 2560 px vorhanden — kleinere Versionen in WordPress erzeugen lassen.
