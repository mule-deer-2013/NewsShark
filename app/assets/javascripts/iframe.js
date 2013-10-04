function renderIframe(url) {
  $('#iframe_window').attr('src', url)
}

function updateForm(action) {
  $('.edit_article').attr("action", action)
}

$('document').ready(function(){
  $('.news_link').on('click', function(e){
    e.preventDefault();
    renderIframe(this.href);
    updateForm($(this).data('action'));
  })
})

var myIframe = document.getElementById('iframe');
myIframe.onload = function () {
    myIframe.contentWindow.scrollTo(0,20);
}
