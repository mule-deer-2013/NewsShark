//     // function tellUsAboutIt(){
//     //   $.ajax({
//     //     url:"secretsubmissionroute",
//     //     type:"post",
//     //     data:getCurrentArticle()
//     //   })
//     // }

//     var prevent_bust = 0
//     window.onbeforeunload = function() { prevent_bust++ }
//     setInterval(function() {
//         if (prevent_bust > 0) {
//             prevent_bust -= 2
//             // 204 header response prevents redirect
//             window.top.location = "#"
//             tellUsAboutIt()
//             hitNext()
//         }
//     }, 1)
