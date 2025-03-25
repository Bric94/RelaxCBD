window.addEventListener('scroll', () => {
    const scrollTop = window.scrollY;
    const docHeight = document.body.scrollHeight - window.innerHeight;
  
    // 0 à 1 : combien de % du scroll est effectué
    const scrollPercent = scrollTop / docHeight;
  
    const parallax = document.querySelector('.background-parallax');
  
    // Distance totale qu'on veut que l'image bouge (en pixels)
    const maxTranslate = 100; // à ajuster : plus grand = effet plus visible
  
    // Calcule la position actuelle
    const translateY = scrollPercent * maxTranslate;
  
    parallax.style.transform = `translateY(${translateY}px) scale(1.2)`;
  });
  