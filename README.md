# V&S WinterSchool 2027 — Landingpage-Entwürfe

Neugestaltung der Seite zur **V&S WinterSchool 2027** („Wettbewerbskraft reloaded — Transformation im Mittelstand", 20.–22. Januar 2027, Seehotel Niedernberg).

- **Seite ansehen:** https://bennoloeffler.github.io/vunds-winter-school/ (zeigt den aktuellen Favoriten, Entwurf 15)
- **Alle Entwürfe vergleichen:** https://bennoloeffler.github.io/vunds-winter-school/previews.html — Live-Vorschau zum Durchscrollen, umschaltbar Desktop/Smartphone
- Auf jeder Seite führt ein fast unsichtbares Symbol ganz unten zur Übersicht.

## Inhalt des Repos

| Pfad | Was |
|---|---|
| `index.html` | Einstieg, leitet auf den gewählten Entwurf weiter |
| `previews.html` | Übersicht aller Entwürfe (11–17 als Live-Vorschau, 01–10 als Liste) |
| `01-…` bis `17-….html` | die Entwürfe, jeder eine eigenständige HTML-Datei |
| `CONTENT.md` | der Inhalt der Seite (Grundlage für alle Entwürfe) |
| `BRIEF.md` | Marke (Farben, Schrift, Logo), Fotos, technische Regeln |
| `FEEDBACK.md` | Designregeln aus den Reviews — verbindlich für neue Entwürfe |
| `docs/PROJEKT-DOKU.md` | Projekt-Dokumentation: Ablauf, Regeln, Erkenntnisse, WordPress-Checkliste, offene Punkte |
| `snippets/` | Partner-Logo-Block (50 Logos) |
| `tools/` | Skripte für Screenshots und Prüfungen |

## Lokal ansehen

Kein Build, kein Server nötig: `index.html`, `previews.html` oder einen Entwurf im Browser öffnen. Für die Live-Vorschau in `previews.html` ist ein lokaler Server am angenehmsten (z. B. VS Code „Live Server").

## Veröffentlichen

Jeder Push auf `main` aktualisiert GitHub Pages nach etwa einer Minute. Das Repo ist öffentlich (GitHub Free veröffentlicht Pages nur aus öffentlichen Repos).

## Ursprüngliche Aufgabe

> Du machst ein Redesign unserer WinterSchool-Seite mit sehr guten „UI / UX / Website für Veranstaltungs-Skills". Die Seite begeistert mit ihrem guten Design und der klaren inhaltlichen Verstehbarkeit. Wirkt werblich.
>
> **Inhalt:** orientiert sich STRIKT an [v-und-s.de/events-media/winter-school-2026](https://v-und-s.de/events-media/winter-school-2026/) — aber es geht um 2027. Der Inhalt bleibt gleich; Alternativvorschläge für Text, Platzierung, Kürzungen sind möglich.
>
> **Stil:** 10 verschiedene Entwürfe, orientiert am [Lager.Feuer](https://v-und-s.de/landingpage-lager-feuer-2026/) und an der bisherigen Seite.
>
> **Tech:** nur HTML und JavaScript, kein Server; später in WordPress; erst lokal, Hosting später; wenn möglich eine einzige, eigenständige Datei.
