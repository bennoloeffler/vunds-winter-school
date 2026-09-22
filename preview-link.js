/* Versteckter Link zur Entwurfs-Übersicht (previews.html) — am Ende jeder Seite.
   Eine Datei für alle Entwürfe (DRY). Vor dem WordPress-Einbau einfach die Zeile
   <script src="preview-link.js" defer></script> aus der Seite entfernen. */
(function () {
  if (window.top !== window.self) return;            // nicht in den Vorschau-Karten
  if (document.getElementById('vs-preview-link')) return;
  var a = document.createElement('a');
  a.id = 'vs-preview-link';
  a.href = 'previews.html';
  a.setAttribute('aria-label', 'Alle Entwürfe ansehen');
  a.title = 'Alle Entwürfe';
  a.innerHTML =
    '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" ' +
    'stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' +
    '<rect x="3.5" y="3.5" width="7" height="7" rx="1.8"/><rect x="13.5" y="3.5" width="7" height="7" rx="1.8"/>' +
    '<rect x="3.5" y="13.5" width="7" height="7" rx="1.8"/><rect x="13.5" y="13.5" width="7" height="7" rx="1.8"/></svg>';
  var css = document.createElement('style');
  css.textContent =
    '#vs-preview-link{display:flex;align-items:center;justify-content:center;width:36px;height:36px;margin:18px auto 22px;' +
    'border-radius:10px;color:#364459;opacity:.14;text-decoration:none;transition:opacity .25s ease,background .25s ease}' +
    '#vs-preview-link:hover,#vs-preview-link:focus-visible{opacity:1;background:rgba(0,109,126,.08);outline:none}' +
    '#vs-preview-link:focus-visible{box-shadow:0 0 0 3px #179bb1}';
  document.head.appendChild(css);
  document.body.appendChild(a);
})();
