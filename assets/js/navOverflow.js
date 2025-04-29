export function initNavOverflow() {
  const nav = document.querySelector('.nav-links');
  if (!nav) return;

  const MOBILE_BP = 576;
  const moreLi = nav.querySelector('.nav-more');
  if (!moreLi) return;
  const moreBtn = moreLi.querySelector('button');
  const moreMenu = moreLi.querySelector('.more-menu');

  // 1) toggle du dropdown “…Plus”
  moreBtn.addEventListener('click', e => {
    e.stopPropagation();
    moreLi.classList.toggle('open');
  });
  // fermer si on clique ailleurs
  document.addEventListener('click', () => {
    moreLi.classList.remove('open');
  });

  function rebuild() {
    const w = window.innerWidth;

    // sous MOBILE_BP ⇒ tout cache
    if (w <= MOBILE_BP) {
      moreLi.style.display = 'none';
      moreLi.classList.remove('open');
      return;
    }

    // remettre tous les <li> dans la barre principale
    Array.from(moreMenu.children).forEach(item => {
      nav.insertBefore(item, moreLi);
    });

    // toujours finir par notre bouton “…Plus”
    nav.appendChild(moreLi);
    moreLi.style.display = 'none';

    // calcul place dispo
    const available = nav.clientWidth;
    let used = moreLi.offsetWidth; // on réserve d’entrée la place du bouton

    Array.from(nav.children).forEach(li => {
      if (li === moreLi) return;

      // ajoute la largeur
      used += li.offsetWidth;

      // seuil data-bp
      const bp = li.dataset.bp
        ? parseInt(li.dataset.bp, 10)
        : null;

      // on bouge dans “…Plus” si
      //  • on a dépassé la largeur dispo
      //  • ou si data-bp existe ET que w ≤ bp
      if (used > available || (bp !== null && w <= bp)) {
        moreMenu.appendChild(li);
      }
    });

    // n’affiche “…Plus” que s’il y a au moins 1 enfant
    moreLi.style.display = moreMenu.children.length ? 'block' : 'none';
  }

  window.addEventListener('resize', rebuild);
  window.addEventListener('orientationchange', rebuild);
  document.addEventListener('DOMContentLoaded', rebuild);
  rebuild();
}
