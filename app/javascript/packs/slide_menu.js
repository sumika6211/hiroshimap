document.addEventListener('turbolinks:load', function() {
  const btn = document.querySelector('#btn-menu');
  const nav = document.querySelector('.collapse');

  btn.addEventListener('click', () => {
    nav.classList.toggle('open-menu')
  });
})