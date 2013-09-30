function renderIframe(url) {
  $('#iframe_window').attr('src', url)
}

$('document').ready(function(){
  $('.news_link').on('click', function(e){
    e.preventDefault();
    renderIframe(this.href);
    var currentAction = $('.edit_article').attr("action")
    var newAction = currentAction.replace(/\d{1,}$/, this.id)
    $('.edit_article').attr("action", newAction)
  })
})
