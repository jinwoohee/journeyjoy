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
	$(".button").mouseover(function(){
		$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
	});
	$(".button").mouseout(function(){
		$(this).css({'box-shadow':''});
	});
	$("input[name='add_place']").click(function(){
		$("form").attr("action","planner_add_place.jsp");
	});
});
function day_select(num){
	var day = "#day"+num;
	var list_no = "#plan_list_day"+num;
	
	$("p[id*='day']").css({'font-size':'15px', 'margin-top':'0px', 'cursor':'pointer'});
	$(day).css({'font-size':'20px', 'margin-top':'-7px', 'cursor':'auto'});
	$("div[id*='plan_list_day']").css({'display':'none'});
	$(list_no).css({'display':'block'});
	
}


function del_list(num){
	var day = Math.trunc(num/100);
	
	var val = document.getElementById("pla_val"+num).value+",";
	var place = document.getElementById("place_name"+day);
	
	var result = place.value.replaceAll(val,"");
	place.setAttribute('value',result);
	 
	var list = document.getElementById("list_content"+num);
	list.remove();
}