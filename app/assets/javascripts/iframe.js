function renderIframe(url) {
  $('#iframe_window').attr('src', url)
}

$('document').ready(function(){
  $('.news_link').on('click', function(e){
    e.preventDefault();
    renderIframe(this.href);
  })
})