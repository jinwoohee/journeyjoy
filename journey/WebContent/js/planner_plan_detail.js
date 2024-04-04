$(document).ready(function() {
	$('#up').click(function() { // 테마정보 화살표 눌렀을때 (닫힘)

		$('#detail_div').hide();
		$('#up').css({'display':'none'});
		$('#down').css({'display':'block'});
	});
	$("#down").click(function() {// 테마정보 화살표 눌렀을때 (열림)
		$('#detail_div').show();
		$('#down').css({'display':'none'});
		$('#up').css({'display':'block'});
	});
	$("input[name=close]").click(function() {
		$("#select_div").hide();
		$("input[name=open]").show();
	});
	$("input[name=open]").click(function() {
		$("#select_div").show();
		$("input[name=open]").hide();
	});
	$(".button").mouseover(function(){
		$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
	});
	$(".button").mouseout(function(){
		$(this).css({'box-shadow':''});
	});
	$(".del_plan").click(function() {
		$(".select_pic").attr("src","../img/icon/select_plz.png");
	});
	$(".add_plan").click(function() {
		$(".select_pic").attr("src", "../img/japan/osaka1.jpg");
	});
});