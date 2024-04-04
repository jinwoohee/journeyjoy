window.onload = function() {
$(function() {
	$('input[name=plan], .place').mouseover(function(){
		$(this).css({"background-color":"#0D112D", "color":"#f1f1f3"});
	});
	$('input[name=plan], .place').mouseout(function(){
		$(this).css({"background-color":"white", "color":"#0D112D"});
	});
	$('img[src*=up]').click(function() {
		$('img[src*=up]').css({"display":"none"});
		$('img[src*=down]').show();
		$('.detail_info').slideUp();
	});
	$('img[src*=down]').click(function() {
		$('img[src*=down]').css({"display":"none"});
		$('img[src*=up]').show();
		$('.detail_info').slideDown();
	});

});


}