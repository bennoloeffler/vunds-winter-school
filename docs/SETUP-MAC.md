# Mac einrichten für die WinterSchool-Seite

Anleitung für Arne. Ein Skript (`tools/setup-mac.sh`) richtet alles ein, was du zum
Bearbeiten, Ansehen und Veröffentlichen der Landingpage brauchst.

## Vorher erledigen (einmalig, von Hand)

1. **GitHub-Konto** anlegen (github.com, kostenlos), falls noch keins da ist.
   Benutzernamen an Benno schicken.
2. **Benno lädt dich** als Mitarbeiter (Collaborator) zum Repo
   `bennoloeffler/vunds-winter-school` ein. Die Einladung kommt per Mail: auf
   **Accept invitation** klicken. Ohne das kannst du lesen, aber nicht veröffentlichen.
3. **Claude-Konto mit Bezahlplan** (Pro, Max oder Team). Claude Code läuft
   nicht mit dem kostenlosen Konto.

## Skript starten

Terminal öffnen (Spotlight: `Terminal`) und eingeben (Pfad an deinen Dropbox-Ordner anpassen):

```bash
bash ~/Dropbox/<Ordner>/setup-mac.sh
```

Tipp: `bash ` tippen (mit Leerzeichen), dann die Datei aus dem Finder ins Terminal
ziehen, Enter.

- Einmal fragt macOS nach deinem **Mac-Passwort** (für Homebrew; die Eingabe bleibt unsichtbar).
- Git fragt nach **Name und E-Mail** (die gleiche E-Mail wie bei GitHub).
- Für GitHub öffnet sich der **Browser**: den angezeigten Code eingeben, bestätigen.
- Dauer beim ersten Mal: ca. 10 bis 20 Minuten.

Das Skript kann **beliebig oft** laufen: es prüft jeden Schritt und installiert nur, was
fehlt. Bei einem Abbruch einfach noch einmal starten. Nur anschauen, ohne etwas zu
ändern: `bash setup-mac.sh --dry-run`. Alle Optionen: `bash setup-mac.sh --help`.

## Was das Skript einrichtet

| Was | Wozu |
|---|---|
| Homebrew, git, gh, uv | Paketverwaltung, Versionsverwaltung, GitHub-Anmeldung, Prüfskripte |
| Visual Studio Code + Erweiterungen | Editor mit HTML-, PDF-, SVG- und Bildvorschau, Farbanzeige, Rechtschreibung Deutsch |
| Google Chrome | Browser mit Entwicklerwerkzeugen |
| Claude Desktop (mit Cowork) | Claude als App |
| Claude Code (`claude`) | Claude im Terminal und in VS Code, arbeitet direkt im Projekt |
| RTK | kürzt Terminal-Ausgaben für Claude Code, spart Kontingent |
| Claude-Skills von Anthropic | `frontend-design`, `canvas-design`, `brand-guidelines`, `theme-factory`, `playground`, PDF/Word/PowerPoint/Excel |
| Projekt | wird nach `~/projects/vunds-winter-school` geklont und in VS Code geöffnet |

## Vorschau in VS Code

- **HTML-Seite:** Datei öffnen, Rechtsklick im Editor, **Show Preview**. Die Vorschau
  lädt beim Speichern neu. Im Browser öffnen: Rechtsklick, **Live Preview: Show Preview (External Browser)**.
- **PDF, SVG, Bilder:** im Explorer links anklicken, die Vorschau öffnet sich direkt.
  Bei SVG-Code: oben rechts das Vorschau-Symbol.
- Bilder im Code: mit der Maus über einen Bildpfad fahren zeigt eine Mini-Vorschau.

## Claude Code starten

```bash
cd ~/projects/vunds-winter-school
claude
```

Beim ersten Start öffnet sich der Browser zur **Anmeldung** mit deinem Claude-Konto.
Danach einfach auf Deutsch schreiben, was du willst, zum Beispiel:
„Zeig mir Entwurf 15 und mach den Hero-Bereich heller".

Wichtig: Claude liest im Projekt `CLAUDE.md` und `FEEDBACK.md` (verbindliche Gestaltungsregeln).

Alternativ: **Claude Desktop, Cowork**, Ordner `~/projects/vunds-winter-school` auswählen.
Oder in VS Code links das Claude-Symbol.

## Veröffentlichen

In VS Code links **Quellcodeverwaltung**: Nachricht eintippen, **Commit**, dann **Sync**.
Oder Claude bitten: „commit and push". Nach ca. 1 Minute ist die Änderung live:
https://bennoloeffler.github.io/vunds-winter-school/
