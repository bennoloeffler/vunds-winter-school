#!/bin/bash
# =============================================================================
# setup-mac.sh — Mac einrichten für die Arbeit an der V&S WinterSchool-Seite
#
# Installiert (nur was fehlt), richtet Git/GitHub, Claude Code (mit RTK und
# Design-Skills) ein, klont das Projekt und öffnet es in VS Code.
# Mehrfach ausführbar: jede Voraussetzung wird geprüft, Vorhandenes übersprungen.
# Anleitung für Arne: docs/SETUP-MAC.md
#
# Aufruf (Terminal):   bash setup-mac.sh            # alles einrichten
#                      bash setup-mac.sh --help     # Hilfe
#                      bash setup-mac.sh --dry-run  # nur anzeigen, nichts ändern
#
# Läuft mit der macOS-Standard-Bash 3.2 (kein mapfile, keine assoziativen Arrays).
# =============================================================================

REPO_SLUG="bennoloeffler/vunds-winter-school"
REPO_URL="https://github.com/${REPO_SLUG}.git"
SITE_URL="https://bennoloeffler.github.io/vunds-winter-school/"
DEFAULT_DIR="$HOME/projects/vunds-winter-school"

# Fallback, falls .vscode/extensions.json im Projekt (noch) fehlt
FALLBACK_EXTENSIONS="ms-vscode.live-server tomoki1207.pdf jock.svg anthropic.claude-code kisstkondoros.vscode-gutter-preview naumovs.color-highlight ecmel.vscode-html-css pranaygp.vscode-css-peek formulahendry.auto-rename-tag esbenp.prettier-vscode streetsidesoftware.code-spell-checker streetsidesoftware.code-spell-checker-german yzhang.markdown-all-in-one mhutchie.git-graph"

DRY_RUN=0
WITH_OPTIONAL=1
OPEN_VSCODE=1
PROJECT_DIR="$DEFAULT_DIR"

# ---------- Ausgabe ----------
if [ -t 1 ]; then B=$'\033[1m'; G=$'\033[32m'; Y=$'\033[33m'; R=$'\033[31m'; D=$'\033[2m'; N=$'\033[0m'; else B=""; G=""; Y=""; R=""; D=""; N=""; fi
step()  { printf '\n%s==> %s%s\n' "$B" "$1" "$N"; }
ok()    { printf '  %s✓%s %s\n' "$G" "$N" "$1"; }
info()  { printf '  %s•%s %s\n' "$D" "$N" "$1"; }
warn()  { printf '  %s!%s %s\n' "$Y" "$N" "$1"; }
fail()  { printf '\n%sFehler:%s %s\n' "$R" "$N" "$1" >&2; exit 1; }
# Befehl ausführen – oder im Probelauf nur anzeigen
run()   { if [ "$DRY_RUN" = 1 ]; then printf '  %s[Probelauf]%s %s\n' "$Y" "$N" "$*"; else "$@"; fi; }
run_sh(){ if [ "$DRY_RUN" = 1 ]; then printf '  %s[Probelauf]%s %s\n' "$Y" "$N" "$1"; else /bin/bash -c "$1"; fi; }
ask()   { # ask "Frage" VAR  – liest vom Terminal, auch wenn das Skript per Pipe läuft
  local answer=""; printf '  %s? %s%s ' "$B" "$1" "$N"
  if [ -r /dev/tty ]; then IFS= read -r answer </dev/tty; else IFS= read -r answer; fi
  printf -v "$2" '%s' "$answer"
}
# Erfolgsmeldung nur, wenn wirklich ausgeführt (nicht im Probelauf)
done_ok(){ [ "$DRY_RUN" = 1 ] || ok "$1"; }

usage() {
  cat <<EOF
${B}setup-mac.sh${N} — Mac einrichten für die V&S WinterSchool-Seite

Richtet in einem Durchgang ein, was man zum Bearbeiten, Ansehen und Veröffentlichen
der Seite braucht, und klont das Projekt von GitHub.

Gefahrlos wiederholbar: jeder Schritt prüft zuerst, ob es schon da ist, und
meldet dann nur "vorhanden" (grüner Haken). Installiert wird nur, was fehlt.
Bei einem Abbruch (z. B. WLAN weg) einfach noch einmal starten.

${B}Aufruf${N}
  bash setup-mac.sh [Optionen]

${B}Optionen${N}
  --dir PFAD          Zielordner für das Projekt (Standard: ${DEFAULT_DIR/#$HOME/~})
  --dry-run           Probelauf: zeigt jeden Schritt, ändert nichts
  --skip-optional     Optionale Programme weglassen (ImageOptim)
  --no-open           VS Code am Ende nicht öffnen
  -h, --help          Diese Hilfe

${B}Was installiert wird (nur falls es fehlt)${N}
  Homebrew            Paketverwaltung für macOS (fragt einmal nach dem Mac-Passwort)
  git, gh             Versionsverwaltung + GitHub-Anmeldung/Push
  uv                  startet die Prüfskripte in tools/ (Python, ohne weitere Einrichtung)
  Visual Studio Code  Editor, dazu die Erweiterungen aus .vscode/extensions.json:
                      Live Preview (HTML), PDF-Vorschau, SVG-Vorschau, Bildvorschau,
                      Farbanzeige, HTML/CSS-Hilfen, Rechtschreibprüfung Deutsch,
                      Git Graph, Claude Code für VS Code
  Google Chrome       Browser mit Entwicklerwerkzeugen; von den Prüfskripten genutzt
  Claude (Desktop)    Claude-App inkl. Cowork
  Claude Code (CLI)   \`claude\` im Terminal (offizieller Installer nach ~/.local/bin,
                      aktualisiert sich selbst)
  RTK                 Rust Token Killer (brew install rtk + rtk init -g): Claude Code
                      liest Terminal-Ausgaben gekürzt – spart Tokens/Kontingent
  Claude-Plugins      Marktplätze anthropics/skills und anthropics/claude-plugins-official,
                      daraus: document-skills (PDF, Word, PowerPoint, Excel),
                      example-skills (canvas-design, brand-guidelines, theme-factory,
                      frontend-design …), frontend-design, playground
  ImageOptim          optional: Bilder verlustfrei verkleinern

${B}Was außerdem passiert${N}
  • Git-Name und -E-Mail setzen (wird abgefragt, falls noch leer)
  • bei GitHub anmelden (Browser öffnet sich) und Git mit dieser Anmeldung verbinden
  • Projekt nach --dir klonen bzw. aktualisieren (git pull)
  • prüfen, ob dein GitHub-Konto Schreibrechte hat (sonst: Benno muss dich einladen)
  • VS Code mit dem Projekt öffnen
  Nicht automatisiert: die Claude-Anmeldung (beim ersten \`claude\`-Start im Browser)
  und die GitHub-Einladung durch Benno.

${B}Voraussetzungen${N}
  macOS 13 oder neuer · Internet · ein GitHub-Konto ·
  für Claude Code ein bezahltes Claude-Konto (Pro, Max, Team oder Enterprise)

${B}Danach${N}
  cd ${DEFAULT_DIR/#$HOME/~} && claude        # Claude Code starten (erster Start: Anmeldung im Browser)
  Anleitung im Projekt: docs/SETUP-MAC.md
EOF
}

# ---------- Argumente ----------
while [ $# -gt 0 ]; do
  case "$1" in
    --dir) [ -n "${2:-}" ] || fail "--dir braucht einen Pfad"; PROJECT_DIR="$2"; shift 2 ;;
    --dir=*) PROJECT_DIR="${1#--dir=}"; shift ;;
    --dry-run) DRY_RUN=1; shift ;;
    --skip-optional) WITH_OPTIONAL=0; shift ;;
    --no-open) OPEN_VSCODE=0; shift ;;
    -h|--help) usage; exit 0 ;;
    *) usage; fail "Unbekannte Option: $1" ;;
  esac
done
case "$PROJECT_DIR" in "~"*) PROJECT_DIR="$HOME${PROJECT_DIR#\~}" ;; esac

# ---------- Vorabprüfung ----------
step "Vorabprüfung"
[ "$(uname -s)" = "Darwin" ] || fail "Dieses Skript ist für macOS."
MACOS_VERSION="$(sw_vers -productVersion)"
MACOS_MAJOR="${MACOS_VERSION%%.*}"
ok "macOS $MACOS_VERSION ($(uname -m))"
[ "$MACOS_MAJOR" -ge 13 ] 2>/dev/null || warn "Claude Code braucht macOS 13 oder neuer – der Rest funktioniert trotzdem."
[ "$DRY_RUN" = 1 ] && warn "Probelauf: es wird nichts installiert oder geändert."
curl -fsS --max-time 10 -o /dev/null https://github.com || fail "Keine Internetverbindung zu github.com."
ok "Internet erreichbar"

# ---------- Homebrew ----------
step "Homebrew (Paketverwaltung)"
brew_shellenv() {
  if [ -x /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then eval "$(/usr/local/bin/brew shellenv)"; fi
}
brew_shellenv
if command -v brew >/dev/null 2>&1; then
  ok "Homebrew vorhanden ($(brew --version | head -1))"
else
  info "Homebrew wird installiert – dabei fragt macOS nach deinem Mac-Passwort (Eingabe bleibt unsichtbar)."
  # shellcheck disable=SC2016  # absichtlich einfache Anführungszeichen: wird erst in run_sh expandiert
  run_sh '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  brew_shellenv
  if [ "$DRY_RUN" = 0 ]; then command -v brew >/dev/null 2>&1 || fail "Homebrew-Installation fehlgeschlagen."; fi
  # dauerhaft in neuen Terminals verfügbar machen
  BREW_BIN="/opt/homebrew/bin/brew"; [ -x "$BREW_BIN" ] || BREW_BIN="/usr/local/bin/brew"
  if ! grep -qs 'brew shellenv' "$HOME/.zprofile"; then
    run_sh "echo 'eval \"\$($BREW_BIN shellenv)\"' >> \"$HOME/.zprofile\""
  fi
  done_ok "Homebrew installiert"
fi

# ---------- Kommandozeilen-Werkzeuge ----------
step "Werkzeuge: git, gh (GitHub), uv (Prüfskripte)"
for f in git gh uv; do
  if brew list --formula "$f" >/dev/null 2>&1; then ok "$f vorhanden"
  else info "installiere $f …"; run brew install "$f" && done_ok "$f installiert"; fi
done

# ---------- Programme ----------
step "Programme"
install_cask() { # install_cask <cask> <App-Name in /Applications> <Beschreibung>
  if [ -d "/Applications/$2.app" ] || [ -d "$HOME/Applications/$2.app" ]; then ok "$3 vorhanden"
  elif brew list --cask "$1" >/dev/null 2>&1; then ok "$3 vorhanden (Homebrew)"
  else info "installiere $3 …"; run brew install --cask "$1" && done_ok "$3 installiert"; fi
}
install_cask visual-studio-code "Visual Studio Code" "Visual Studio Code"
install_cask google-chrome "Google Chrome" "Google Chrome"
install_cask claude "Claude" "Claude Desktop-App (mit Cowork)"
if [ "$WITH_OPTIONAL" = 1 ]; then install_cask imageoptim "ImageOptim" "ImageOptim (optional)"; else info "ImageOptim übersprungen (--skip-optional)"; fi

# ---------- Claude Code CLI ----------
step "Claude Code (Terminal)"
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) PATH="$HOME/.local/bin:$PATH" ;; esac
if command -v claude >/dev/null 2>&1; then
  ok "Claude Code vorhanden ($(claude --version 2>/dev/null | head -1))"
else
  info "offizieller Installer von claude.ai (landet in ~/.local/bin, aktualisiert sich danach selbst)"
  run_sh 'curl -fsSL https://claude.ai/install.sh | bash'
  if [ "$DRY_RUN" = 0 ]; then
    if "$HOME/.local/bin/claude" --version >/dev/null 2>&1; then ok "Claude Code installiert ($("$HOME/.local/bin/claude" --version 2>/dev/null | head -1))"
    else warn "Claude Code-Installation nicht bestätigt – bitte später im Terminal: curl -fsSL https://claude.ai/install.sh | bash"; fi
  fi
fi
if grep -qs '.local/bin' "$HOME/.zshrc"; then ok "Pfad ~/.local/bin steht in ~/.zshrc"
else
  run_sh "printf '\n# Claude Code\nexport PATH=\"\$HOME/.local/bin:\$PATH\"\n' >> \"$HOME/.zshrc\""
  done_ok "Pfad ~/.local/bin in ~/.zshrc eingetragen (für neue Terminal-Fenster)"
fi
info "Anmeldung: beim ersten Start von 'claude' im Browser – nötig ist ein bezahltes Claude-Konto (Pro, Max, Team)."
CLAUDE_BIN="$(command -v claude 2>/dev/null)"
[ -n "$CLAUDE_BIN" ] || CLAUDE_BIN="$HOME/.local/bin/claude"

# ---------- RTK (spart Claude-Tokens bei Terminal-Ausgaben) ----------
step "RTK – Rust Token Killer (kürzt Terminal-Ausgaben für Claude Code)"
# Vorsicht Namensgleichheit: ein anderes Programm "rtk" (Rust Type Kit) kennt 'rtk gain' nicht.
if command -v rtk >/dev/null 2>&1 && rtk gain >/dev/null 2>&1; then
  ok "RTK vorhanden ($(rtk --version 2>/dev/null | head -1))"
else
  command -v rtk >/dev/null 2>&1 && warn "ein anderes 'rtk' ($(command -v rtk)) ist installiert – installiere das richtige per Homebrew"
  info "installiere rtk …"; run brew install rtk
  if [ "$DRY_RUN" = 0 ]; then
    hash -r
    if rtk gain >/dev/null 2>&1; then ok "RTK installiert ($(rtk --version 2>/dev/null | head -1))"
    else warn "RTK nicht bestätigt ('rtk gain' schlägt fehl) – bitte Benno fragen"; fi
  fi
fi
# Hook in ~/.claude/settings.json: Claude Code leitet Terminal-Befehle dann über rtk.
# rtk init braucht einen vorhandenen Ordner ~/.claude (auf einem frischen Mac fehlt er noch).
if grep -qs 'rtk hook' "$HOME/.claude/settings.json"; then
  ok "RTK-Hook für Claude Code eingerichtet"
else
  run mkdir -p "$HOME/.claude"
  if [ "$DRY_RUN" = 1 ]; then run rtk init -g --auto-patch
  elif rtk init -g --auto-patch </dev/null >/dev/null 2>&1 && grep -qs 'rtk hook' "$HOME/.claude/settings.json"; then
    ok "RTK-Hook für Claude Code eingerichtet (~/.claude/settings.json, ~/.claude/RTK.md)"
  else warn "RTK-Hook nicht eingerichtet – später im Terminal: rtk init -g"; fi
fi

# ---------- Claude-Plugins (Skills für Gestaltung und Dokumente) ----------
step "Claude Code: Anthropic-Marktplätze und Design-Skills"
# Marktplatz-Name (wie Claude ihn anzeigt) und GitHub-Quelle, paarweise
MARKETPLACES="anthropic-agent-skills=anthropics/skills claude-plugins-official=anthropics/claude-plugins-official"
# document-skills: PDF, Word, PowerPoint, Excel · example-skills: canvas-design, brand-guidelines,
# theme-factory, frontend-design, algorithmic-art … · frontend-design: Web-Gestaltung ·
# playground: interaktive HTML-Spielwiesen mit Live-Vorschau
PLUGINS="document-skills@anthropic-agent-skills example-skills@anthropic-agent-skills frontend-design@claude-plugins-official playground@claude-plugins-official"
if [ "$DRY_RUN" = 0 ] && ! "$CLAUDE_BIN" --version >/dev/null 2>&1; then
  warn "Claude Code fehlt – Plugins übersprungen (Skript nach der Claude-Installation erneut starten)"
else
  MP_LIST="$("$CLAUDE_BIN" plugin marketplace list --json 2>/dev/null)"
  for pair in $MARKETPLACES; do
    mp="${pair%%=*}"; src="${pair#*=}"
    if printf '%s' "$MP_LIST" | grep -q "\"name\": *\"$mp\""; then ok "Marktplatz $mp"
    elif [ "$DRY_RUN" = 1 ]; then run "$CLAUDE_BIN" plugin marketplace add "$src"
    elif "$CLAUDE_BIN" plugin marketplace add "$src" </dev/null >/dev/null 2>&1; then ok "Marktplatz $mp hinzugefügt"
    else warn "Marktplatz $src konnte nicht hinzugefügt werden"; fi
  done
  PL_LIST="$("$CLAUDE_BIN" plugin list --json 2>/dev/null)"
  for p in $PLUGINS; do
    if printf '%s' "$PL_LIST" | grep -q "\"id\": *\"$p\""; then ok "Plugin $p"
    elif [ "$DRY_RUN" = 1 ]; then run "$CLAUDE_BIN" plugin install "$p" --scope user
    elif "$CLAUDE_BIN" plugin install "$p" --scope user </dev/null >/dev/null 2>&1; then ok "Plugin $p installiert"
    else warn "Plugin $p konnte nicht installiert werden"; fi
  done
fi

# ---------- Git-Identität ----------
step "Git: Name und E-Mail für deine Änderungen"
GIT_NAME="$(git config --global user.name 2>/dev/null)"
GIT_MAIL="$(git config --global user.email 2>/dev/null)"
if [ -n "$GIT_NAME" ] && [ -n "$GIT_MAIL" ]; then ok "$GIT_NAME <$GIT_MAIL>"
else
  [ -n "$GIT_NAME" ] || { ask "Dein Name (z. B. Arne Binner):" GIT_NAME; run git config --global user.name "$GIT_NAME"; }
  [ -n "$GIT_MAIL" ] || { ask "Deine E-Mail (die gleiche wie bei GitHub):" GIT_MAIL; run git config --global user.email "$GIT_MAIL"; }
  done_ok "gesetzt: $GIT_NAME <$GIT_MAIL>"
fi
[ -n "$(git config --global init.defaultBranch 2>/dev/null)" ] || run git config --global init.defaultBranch main

# ---------- GitHub-Anmeldung ----------
step "GitHub-Anmeldung"
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  GH_USER="$(gh api user --jq .login 2>/dev/null)"; ok "angemeldet als $GH_USER"
else
  info "Es öffnet sich der Browser: GitHub-Code eingeben und bestätigen."
  run gh auth login --hostname github.com --git-protocol https --web
  [ "$DRY_RUN" = 1 ] || GH_USER="$(gh api user --jq .login 2>/dev/null)"
fi
if [ "$DRY_RUN" = 1 ]; then run gh auth setup-git; else gh auth setup-git >/dev/null 2>&1; fi
[ -n "${GH_USER:-}" ] && ok "Git nutzt jetzt diese GitHub-Anmeldung"

# ---------- Projekt klonen ----------
step "Projekt: $REPO_SLUG"
if [ -d "$PROJECT_DIR/.git" ]; then
  ok "schon vorhanden: $PROJECT_DIR"
  if [ -n "$(git -C "$PROJECT_DIR" status --porcelain 2>/dev/null)" ]; then
    warn "lokale, nicht gespeicherte Änderungen – kein automatisches Aktualisieren"
  else
    run git -C "$PROJECT_DIR" pull --ff-only && done_ok "auf den neuesten Stand gebracht"
  fi
elif [ -e "$PROJECT_DIR" ] && [ -n "$(ls -A "$PROJECT_DIR" 2>/dev/null)" ]; then
  fail "$PROJECT_DIR existiert und ist kein Git-Projekt. Bitte mit --dir einen anderen Ordner angeben."
else
  run mkdir -p "$(dirname "$PROJECT_DIR")"
  run git clone "$REPO_URL" "$PROJECT_DIR" && done_ok "geklont nach $PROJECT_DIR"
fi

# Schreibrechte prüfen
if [ -n "${GH_USER:-}" ]; then
  PERM="$(gh api "repos/$REPO_SLUG" --jq '.permissions.push' 2>/dev/null)"
  if [ "$PERM" = "true" ]; then ok "Schreibrechte vorhanden – du kannst Änderungen veröffentlichen (git push)"
  else warn "Noch keine Schreibrechte für $GH_USER. Benno lädt dich ein; danach die Einladung auf github.com annehmen."; fi
fi

# ---------- VS Code-Erweiterungen ----------
step "VS Code-Erweiterungen"
CODE_BIN="$(command -v code 2>/dev/null)"
[ -n "$CODE_BIN" ] || CODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
if [ "$DRY_RUN" = 0 ] && [ ! -x "$CODE_BIN" ]; then
  warn "VS Code-Befehl nicht gefunden – Erweiterungen bitte in VS Code über die Vorschläge installieren."
else
  EXT_FILE="$PROJECT_DIR/.vscode/extensions.json"
  if [ -f "$EXT_FILE" ]; then
    EXTENSIONS="$(grep -oE '"[A-Za-z0-9-]+\.[A-Za-z0-9.-]+"' "$EXT_FILE" | tr -d '"' | tr '\n' ' ')"
  else EXTENSIONS="$FALLBACK_EXTENSIONS"; fi
  INSTALLED=" $([ -x "$CODE_BIN" ] && "$CODE_BIN" --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]' | tr '\n' ' ') "
  for ext in $EXTENSIONS; do
    low="$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')"
    case "$INSTALLED" in *" $low "*) ok "$ext" ;;
      *) if [ "$DRY_RUN" = 1 ]; then run "$CODE_BIN" --install-extension "$ext"
         elif "$CODE_BIN" --install-extension "$ext" --force >/dev/null 2>&1; then ok "$ext installiert"
         else warn "$ext konnte nicht installiert werden"; fi ;;
    esac
  done
fi

# ---------- Abschluss ----------
step "Fertig"
printf '  Projektordner:  %s\n' "$PROJECT_DIR"
printf '  Live-Seite:     %s\n' "$SITE_URL"
printf '  Alle Entwürfe:  %spreviews.html\n' "$SITE_URL"
cat <<EOF

  ${B}So geht's weiter${N}
  1. In VS Code: HTML-Datei öffnen → Rechtsklick → "Show Preview" (Live Preview) – aktualisiert sich beim Speichern.
     PDF, SVG und Bilder: einfach im Explorer anklicken, die Vorschau öffnet sich direkt.
  2. Claude Code im Terminal:   cd "$PROJECT_DIR" && claude
     (beim ersten Start im Browser anmelden – bezahltes Claude-Konto: Pro, Max oder Team)
  3. Oder Claude Desktop → Cowork → Ordner "$PROJECT_DIR" auswählen.
  4. Änderungen veröffentlichen: in VS Code links "Quellcodeverwaltung" → Nachricht → Commit → Sync,
     oder Claude bitten: "commit and push". Die Live-Seite aktualisiert sich nach ~1 Minute.
  Anleitung: docs/SETUP-MAC.md
EOF
if [ "$OPEN_VSCODE" = 1 ] && [ "$DRY_RUN" = 0 ] && [ -x "$CODE_BIN" ] && [ -d "$PROJECT_DIR" ]; then
  "$CODE_BIN" "$PROJECT_DIR" >/dev/null 2>&1 &
fi
exit 0
