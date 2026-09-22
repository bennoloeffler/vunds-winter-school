# Design-Brief für die 10 Entwürfe

## Marke V&S (aus dem Elementor-Kit von v-und-s.de)

- Schrift: **Campton** (Selbst-gehostet auf WordPress, hier nicht verfügbar). Deklaration in jedem Entwurf:
  `font-family: "Campton", "Outfit", system-ui, sans-serif;` und Google-Fonts-Link für **Outfit** (300–800) als Ersatz.
  Gewichte im Original: Überschriften 600/700, Text 400.
- Farben:
  - Primär Teal `#006D7E` · helles Teal `#179bb1` · Logo-Teal `#00A0A8`
  - Slate/Navy `#364459`
  - Akzent Pink `#f2295b` · dunkles Rot `#c9133b` (Hero-Verlauf der aktuellen Seite geht Teal → Pink/Rot)
  - Text `#272727` · Grau `#bbbbbb` / `#C5C5C4` · Hintergrund `#F7F7F7` · Weiß
- Aktuelle Seite (Referenz 1): Hero mit Verlauf Teal→Pink, Winterfotos vom See (Steg, Nebel, Sonne), weiße Sektionen, große teal Icons, Agenda als 3 Tages-Slider, Zitate, Infos, CTA, Hotel + Karte.
- Lager.Feuer (Referenz 2): **schwarzer** Hintergrund, Lagerfeuer-Foto, Logo-Lockup, sehr große fette weiße Headlines, Sektionen mit dreieckiger Pfeil-Kante nach unten, nummerierte Vorträge „01 VORTRAG", Teal als einzige Akzentfarbe, Speaker-Karten, Agenda-Timeline. Wirkt werblich, kantig, Klartext.

## V&S-Logo (inline SVG, Kachel-Logo, Fill anpassbar)

```html
<svg viewBox="0 0 100 100" width="56" height="56" aria-label="V&S"><path fill="#00A0A8" d="M51.0334152,58.6115479 L46.4737101,54.5208845 L44.8692875,53.0628993 C43.6872236,53.7918919 42.8850123,54.8044226 42.8850123,56.0599509 C42.8850123,57.9228501 44.8692875,59.4616708 47.402457,59.4616708 C48.5847666,59.4616708 49.8090909,59.1786241 51.0334152,58.6115479 Z M46.5159705,44.3963145 C46.5159705,45.6361179 47.8670762,47.312285 50.6535627,49.8230958 L55.42457,54.2781327 L58.0324324,50.1783784 L65.0019656,50.1783784 L59.8154791,58.4088452 L66.1909091,64.3624079 L57.4088452,64.3624079 L55.5933661,62.7019656 C53.2712531,64.2002457 50.5267813,64.9697789 47.2759214,64.9692875 C40.6471744,64.9692875 36.2985258,61.4869779 36.2982801,56.3031941 C36.2985258,52.9415233 38.3250614,50.5115479 41.1538084,49.0538084 C39.9717445,47.4336609 39.4228501,45.9353808 39.4228501,44.234398 C39.4228501,39.8199017 43.1383292,36.2154791 49.0068796,36.2154791 C54.7068796,36.2154791 58.6334152,39.9914005 58.6334152,45.3815725 L52.2157248,45.3815725 C52.0046683,43.4375921 50.9068796,41.8044226 49.2181818,41.8044226 C47.6980344,41.8044226 46.5159705,42.8169533 46.5159705,44.3963145 Z M99.9520885,29.3233415 L29.27543,0.0479115479 L13.9547912,37.0351351 L22.2945946,55.385258 L30.7297297,36.8255528 L38.817199,36.8255528 L26.0339066,64.3633907 L18.5987715,64.3633907 L10.14914,46.2226044 L0,70.72457 L70.6769042,100 L85.7041769,63.7206388 C83.8859951,64.4395577 81.7014742,64.8262899 79.2334152,64.8262899 C72.5810811,64.8262899 66.5808354,61.8184275 65.885258,54.990172 L73.2769042,54.990172 C73.7552826,57.429484 75.9727273,59.0140049 79.4511057,59.0140049 C82.0599509,59.0140049 83.6253071,58.0388206 83.6253071,56.4941032 C83.6253071,55.5191646 83.0599509,54.5027027 80.4945946,54.0555283 L75.6248157,53.080344 C69.7985258,51.9017199 67.0592138,49.422113 67.0592138,45.0326781 C67.0592138,39.504914 71.8420147,36.0095823 78.7990172,36.0095823 C83.5818182,36.0095823 90.7125307,37.7572482 91.4515971,45.195086 L84.0599509,45.195086 C83.6687961,43.1223587 82.3208845,41.4560197 79.190172,41.455774 C76.5813268,41.455774 74.8857494,42.5125307 74.8857494,44.3009828 C74.8857494,45.8862408 76.1031941,46.5771499 78.4511057,47.0243243 L82.5815725,47.9184275 C86.3115479,48.6714988 89.1194103,49.8840295 90.514742,52.1076167 L99.9520885,29.3233415 Z"/></svg>
```

## Bilder (liegen auf v-und-s.de — per URL einbinden, nicht herunterladen; Seite landet später auf demselben WordPress)

Winter/See (Stimmung, Hero-tauglich, 2560px breit):
- `https://v-und-s.de/wp-content/uploads/2024/01/1110544-scaled.jpeg` — Steg im See, Schnee, Sonne (das aktuelle Hero-Motiv) ★
- `https://v-und-s.de/wp-content/uploads/2024/01/1110539-scaled.jpeg` — Seehotel-Häuser am Ufer, Winter, blaue Stunde ★
- `https://v-und-s.de/wp-content/uploads/2024/01/1110545-scaled.jpeg` — Sonne über See, Uferhütten, Schnee
- `https://v-und-s.de/wp-content/uploads/2024/01/1110550-scaled.jpeg` — Terrasse mit Blick auf See, Sonne
- `https://v-und-s.de/wp-content/uploads/2023/01/Morgendlicher-See-scaled.jpg` — nebliger Morgen-See, ruhig
- `https://v-und-s.de/wp-content/uploads/2022/10/Foto-28.01.17-07-46-16-scaled.jpg` — Sonnenuntergang orange über See, Bank (Lagerfeuer-Stimmung)

Menschen / Veranstaltung (Querformat 2560px):
- `https://v-und-s.de/wp-content/uploads/2025/03/20240926_090007735_iOS-scaled.jpg` — Plenum im Holzsaal mit Lampions, viele Teilnehmer ★
- `https://v-und-s.de/wp-content/uploads/2025/05/1140426-scaled.jpeg` — Teilnehmer im Holzsaal, lockere Stimmung
- `https://v-und-s.de/wp-content/uploads/2024/10/1130645-scaled.jpeg` — Gruppe lachend, stehend
- `https://v-und-s.de/wp-content/uploads/2024/10/1130769-scaled.jpeg` — Diskussion am Tisch
- `https://v-und-s.de/wp-content/uploads/2024/01/Reblaus3-scaled.jpg` — Abendessen in der „Reblaus", Kerze
- `https://v-und-s.de/wp-content/uploads/2024/01/Plenum2-scaled.jpeg` — Kleingruppe am Tisch
- `https://v-und-s.de/wp-content/uploads/2024/01/IMG_3930-scaled.jpg` — Arbeit mit Karten am Tisch
- `https://v-und-s.de/wp-content/uploads/2023/01/1100099-2-scaled.jpeg` — Workshop mit Moderationskarten
- `https://v-und-s.de/wp-content/uploads/2023/01/1100116-scaled.jpeg` — Referent mit Mikro vor rotem Vorhang
- `https://v-und-s.de/wp-content/uploads/2024/05/Impressionen_09.webp` — Gruppe vor Bildschirm

Hochformat-Fotos (683×1024, Teilnehmer/Stimmung): `https://v-und-s.de/wp-content/uploads/2023/11/274A0081_websize-683x1024.jpg`, `…/274A0153_websize-683x1024.jpg`, `…/274A0277_websize-683x1024.jpg`, `…/274A0581_websize-683x1024.jpg`, `…/274A0704-683x1024.jpg`, `…/274A0761_websize-683x1024.jpg`, `…/274A9734_websize-1-683x1024.jpg`, `…/274A9757_websize-683x1024.jpg`, `…/274A9908_websize-683x1024.jpg`

Partner-Logos (jpg, weißer Hintergrund): `https://v-und-s.de/wp-content/uploads/2021/12/<Name>_optimiert.jpg` mit Name ∈ BBG, Bosch, Faschang, Flottweg, Grimme, Herding, Knoll, Mahr, Nord_Drivesystems, Oerlikon, Phoenix_Contact, Schleifring, Schueco, Syntegon, Woerner, coswig, ife; außerdem `2023/11/stopa.png`, `2025/03/Dungs_logo-e1782291546246.png`, `2025/03/logo_ipco.png`.

## Hero-Mockups (img/hero/, 11 KI-generierte Kompositionen, 1672×941, Text eingebrannt)

Gelten als **Kompositions-Vorlage**, nicht als fertiges Bild: Hero in HTML nachbauen (Foto von v-und-s.de + echter Text).
Gemeinsamer Kern aller Mockups: „Was wir in Deutschland eigentlich brauchen:" → **50 % schneller. / 80 % weniger Prozess-Wahnsinn.**
als DIE Hauptaussage (Prozentzahlen riesig, Teal oder Weiß), darüber klein „V&S WinterSchool 2027 / Wettbewerbskraft reloaded /
Transformation im Mittelstand", darunter Datum + Ort mit kleinen Icons, „Zukunft. Besser. Machen." und Button „Programm & Anmeldung →".
Zuordnung Mockup → Entwurf steht in der jeweiligen HTML-Kopfzeile. Foto-Entsprechungen: Referent vor rotem Vorhang = `2023/01/1100116`,
Tischdiskussion = `2024/10/1130769`, Plenum Holzsaal = `2025/03/20240926_090007735_iOS`, Karten am Tisch = `2024/01/IMG_3930`,
Gruppe vor Bildschirm = `2024/05/Impressionen_09`, Kleingruppe = `2024/01/Plenum2`.

## Technische Regeln (gelten für jeden Entwurf)

1. **Eine Datei**, komplett self-contained: HTML + `<style>` + `<script>` inline. Keine Frameworks, keine CDN-Skripte, kein Build. Einzige externe Ressourcen: Google Fonts (Outfit) und die Fotos/Logos von v-und-s.de.
2. Vanilla JS nur für: mobile Navigation, Agenda-Tabs/Akkordeon, Scroll-Reveal (IntersectionObserver), ggf. Wort-Rotation im Hero, Zähler. Alles muss ohne JS lesbar bleiben (Agenda-Inhalt darf nicht nur per JS erscheinen).
3. Responsiv: 360 px bis 1600 px, 16 px Seitenrand am Handy, kein horizontales Scrollen. `prefers-reduced-motion` respektieren.
4. **WordPress-tauglich:** alle Styles unter einem Wrapper `.ws27` scopen (z. B. `.ws27 h2 {…}`), keine globalen Resets auf `body`/`*` außer minimal `box-sizing` innerhalb `.ws27`. Kein `<header>`-Menü der Website nachbauen — nur eine schlanke Seiten-eigene Leiste (Logo + Sprungmarken + Anmelden-Button) ist erlaubt.
5. Keine Google-Maps-iframes, keine Cookie-pflichtigen Einbettungen. Karte = Link.
6. Deutsch, `lang="de"`, korrekte Typografie („ " – …), `<title>V&S WinterSchool 2027 – Wettbewerbskraft reloaded</title>`, Meta description.
7. Semantisches HTML (`<section>`, `<h2>`…), sichtbare Fokus-Zustände, Kontrast AA.
8. CTA „Anmelden" mindestens: im Hero, nach der Agenda, am Ende. Kontakt Nicole Tietz immer sichtbar im CTA-Block.
9. Kopfkommentar `<!-- Entwurf NN: <Name> — Idee: … — Abweichungen vom Original: … -->` direkt nach `<!DOCTYPE html>`.
10. Dateiname `NN-<slug>.html` im Repo-Root.
