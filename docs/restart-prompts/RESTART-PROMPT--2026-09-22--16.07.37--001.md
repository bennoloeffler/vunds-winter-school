# Restart-Prompt — V&S WinterSchool 2027 (Stand: 22.09.2026, 16:07)

## ⏭️ RESUME HERE — TODOs

1. **Bennos nächste Text-Korrekturen einarbeiten** — gelten für alle Entwürfe ab 11 (11–17). Nach jeder Änderung: `tools/shoot.py` auf die geänderten Dateien, dann `git push`.
2. **`CONTENT.md` prüfen:** Benno hat während der Sitzung die Zeile zum Kasten „Was wir in Deutschland eigentlich brauchen" geändert (dritter Wert „· 30 %" o. ä.) — noch **nicht committet**. Fragen, ob das eine dritte Kennzahl für alle Entwürfe werden soll; dann in 11–17 übernehmen.
3. **Entscheidungen einholen** (siehe unten, „Was Benno entscheidet").
4. Wenn ein Hero geändert wird: Vorschaubild neu erzeugen — `uv run --with websocket-client --with pillow python tools/thumbs.py 9395 thumbs 15-storytelling-freundlich.html=15`.
5. Vor WordPress: Checkliste in `docs/PROJEKT-DOKU.md` §7.

## Was das Projekt ist

17 Landingpage-Entwürfe (reines HTML/CSS/JS) für die V&S WinterSchool 2027, Inhalt 1:1 von der bisherigen v-und-s.de-Seite. Veröffentlicht über GitHub Pages; der gewählte Entwurf kommt später in WordPress.

## Stand (gemessen)

- Live: https://bennoloeffler.github.io/vunds-winter-school/ → leitet auf **Entwurf 15** weiter (geprüft: HTTP 200, Weiterleitung greift).
- `previews.html`: 7 Live-Vorschauen (11–17), alle laden (geprüft im Browser, online und lokal), Desktop/Smartphone-Umschalter, A/B/C bei 11 und 13.
- Alle 17 Entwürfe: kein Querscrollen bei 1440 und 390 px, keine JS-Fehler, keine kaputten Bilder (`tools/shoot.py`); versteckter Übersichts-Link am Seitenende in allen 17 geprüft.
- 12–17: 50 Partner-Logos (Snippet), Teal→Blau, keine „Kapitel", Einleitungstext wortgleich in 11–17 (Textvergleich), keine Emojis in keiner Datei.
- Repo `bennoloeffler/vunds-winter-school` ist **öffentlich** (GitHub Free: Pages nur öffentlich).

## Runbook

```bash
cd ~/projects/ai/winter-school
open previews.html                                   # Übersicht lokal
uv run --with websocket-client --with pillow python tools/shoot.py 9401 15-storytelling-freundlich.html /tmp/s15
git add -A && git commit -m "…" && git push          # veröffentlicht in ~1 Minute
gh api repos/bennoloeffler/vunds-winter-school/pages/builds/latest --jq .status
```

## Gotchas

- Headless Chrome: Scroll-Reveals (IntersectionObserver) feuern nur mit Fokus-Emulation → leere Screenshots sonst. `tools/shoot.py` erledigt das.
- `chrome-agent` hat 756 px festes Viewport — für Desktop `tools/shoot.py` nehmen.
- Beim Übertragen von Abschnitten zwischen Entwürfen Klassen präfixen (09-Linie stylt `.tag/.foot/.claim` global).
- Logos nie selbst skalieren — `snippets/logos.*` 1:1, Größe nur `--logo-k`.
- zsh teilt `$var` nicht — Argumente als Array/aus Python übergeben.
- Bilder lesen nur mit `limit: 1` (Hook).

## Was ehrlich fehlt

- 01–10 haben den Einleitungstext nicht (alte Runde, bewusst nicht angefasst).
- Karussell-Wischen (12) nicht auf echtem Smartphone getestet.
- 13 der 24 Galeriefotos (14, 16) nur in 2560 px — lädt langsam bei schwacher Verbindung.
- Schrift Campton lokal nicht verfügbar (Ersatz Outfit); endgültiger Look erst in WordPress.

## Ready-to-paste Prompt

> Lies `RP.md`, `CLAUDE.md`, `FEEDBACK.md` und `docs/PROJEKT-DOKU.md` im Repo `~/projects/ai/winter-school`. Arbeite Bennos Korrekturen in alle Entwürfe ab 11 ein, halte dich an die Regeln in `FEEDBACK.md` (keine Emojis, Teal→Blau, helle Stimmung), prüfe jede geänderte Datei mit `tools/shoot.py` und pushe danach auf `main`.

## Was Benno entscheidet

- Welcher Entwurf wird es (Einstieg zeigt 15)?
- Entwurf 13: Hero A, B oder C?
- Einleitungstext auch in 01–10?
- Repo privat (GitHub Pro nötig)?
- Entwurf 17 mobil: Mosaik-Fotos quadratisch beschnitten lassen?
- Dritte Kennzahl im 50 %/80 %-Kasten (siehe `CONTENT.md`-Änderung)?
