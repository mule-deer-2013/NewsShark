function renderIframe(url) {
  $('#iframe_window').attr('src', url)
}

function updateForm(id) {
  $.ajax({
    type: "GET",
    url: "/articles/" + id
  }).done(function(server_data){
    $('.btn-group').replaceWith(server_data);
  }).fail(function(){
    console.log("Something went wrong")
  })
}

$('document').ready(function(){
  $('.news_link').on('click', function(e){
    e.preventDefault();
    updateForm($(this).data("id"))
    renderIframe(this.href);
  })

  $('.page').on('ajax:success', '.btn-group form', function(e, server_data){
    $('.btn-group').after('Vote recorded.')
    if (this.action[this.action.length - 2] === '-'){
      $('.btn-group').replaceWith(server_data.feedback_partial);
      renderIframe(server_data.url)
    } else if (this.action[this.action.length - 1] === '0'){
      $('.btn-group').replaceWith(server_data.feedback_partial);
      renderIframe(server_data.url)
    }
  })

})
