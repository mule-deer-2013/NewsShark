function renderIframe(url) {
  $('#iframe_window').attr('src', url)
}

function updateForm(link_id) {
  var currentAction = $('.edit_article').attr("action");
  var newAction = currentAction.replace(/\d{1,}$/, link_id)
  $('.edit_article').attr("action", newAction)
}

$('document').ready(function(){
  $('.news_link').on('click', function(e){
    e.preventDefault();
    renderIframe(this.href);
    updateForm(this.id);
  })
})
