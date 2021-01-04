import utils from './Utils';
/*-----------------------------------------------
|   Smooth Scrollbar
-----------------------------------------------*/
utils.$document.ready(() => {

  const scrollbars = document.querySelectorAll('[data-scrollbar]');
  if(scrollbars.length){
    $.each(scrollbars, (item, value) => {
      const $this = $(value);
      const { from } = $this.data('scrollbar');

      Scrollbar.init(value);

      if(from === 'bottom'){
        const scrollContent = Scrollbar.get(value);
        scrollContent.setPosition(0, scrollContent.limit.y);
      }
    });
  }
});
