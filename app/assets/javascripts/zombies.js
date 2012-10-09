$(window).load(function(){
$("#zombie_nickname").keyup(function() {
    var input = $(this);
    text = input.val().replace(/[^hrungoaHRUNGOA!]/g, "");
    if(input.val()!=text){
      $("#nickname_error").show();
    }
    input.val(text);
});
});
