window.onload = function() {
$(function() {
	$('input[name=plan], .place').mouseover(function(){
		$(this).css({"background-color":"#0D112D", "color":"#f1f1f3"});
	});
	$('input[name=plan], .place').mouseout(function(){
		$(this).css({"background-color":"white", "color":"#0D112D"});
	});

});
}
function open_div(num){
	$("img[id='open"+num+"']").css({"display":"none"});
	$("img[id='close"+num+"']").show();
	$("div[id='detail_info"+num+"']").slideDown();
}
function close_div(num){
	$("img[id='close"+num+"']").css({"display":"none"});
	$("img[id='open"+num+"']").show();
	$("div[id='detail_info"+num+"']").slideUp();
}