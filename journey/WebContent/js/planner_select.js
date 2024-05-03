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
	$("input[name='close']").click(function() { //선택한 일정 (페이지 하단)div 닫기
		$("#select_div").hide();
		$("input[name='open']").show();
		$("#side_menu").show();
	});
	$("input[name='open']").click(function() { //선택한 일정 (페이지 하단)div 열기
		$("#select_div").show();
		$("input[name='open']").hide();
		$("#side_menu").hide();
	});
/*	$(".button").mouseover(function(){
		$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
	});
	$(".button").mouseout(function(){
		$(this).css({'box-shadow':''});
	});*/

	$("input[name*='select']").click(function() {
		$("input[name='open']").hide();
		$("#side_inner").css({"border-bottom":"0"});
		$("#select_div").show();
	});
	$("input[name='finish']").click(function(){
		$("form").submit();
	});
});
function add_plan(num){
	var button = document.getElementsByName("select"+num);
	
	var act = document.getElementById("place_pic"+num);
	var img_value = act.src;
	
	var select = document.getElementsByName("select_values"+num);
	var selected_value ="";
	
	for(var i = 0 ; i < select.length ; i++){
		selected_value += select[i].value+"," ;
	}
	var img = document.getElementsByClassName("sel_picture");
	var save_value = document.getElementsByClassName("selected");

	for(var j = 0 ; j < img.length ; j++){
		var day = j+1;
		var pick = document.getElementById("next_a"+day);
		
		if(pick.value == img_value){
			alert("중복된 일정입니다.");
			console.log("1-1번");
			return false;
		}else if(pick.value !=="none"){
			continue
		}
		else {
			img[j].setAttribute('src', img_value);
			img[j].setAttribute('value', "1");		
			save_value[j].setAttribute('value',selected_value);
			pick.setAttribute('value',img_value);
			console.log("3성공");
			break;				
		
		/*else{ if(pick.value === "none"){
			for(var l = j+1 ; l < img.length ; l++){
				
				var date = l+1;
				if(date <= (img.length)){
					var next = document.getElementById("next_a"+date);
					
					if(next.value !== "none"){
						if(next.value == img_value){
							alert("중복된 일정입니다.");
							console.log("1번");
							return false;
						}
						else if(pick.value == img_value){
							alert("중복된 일정입니다.");
							console.log("2번");
							return false;
						}
						else {if(pick.value != img_value){
							img[j].setAttribute('src', img_value);
							save_value[j].setAttribute('value',selected_value);
							pick.setAttribute('value',img_value);
							console.log("3성공");
							break;				
						}
					}else{
						alert("4번");
						continue
					}
				}
			}
		}else{
			alert("5번");
			continue;
		}
		}*/
	}
}
}
			
function del_plan(num){
	var img = document.getElementById("select_pic"+num);
	var next = document.getElementById("next_a"+num);
	img.setAttribute('src', "img/icon/select_plz.png");
	next.setAttribute('value','none');
}
function check_plan(){
	var img = document.getElementsByClassName("sel_picture");

	for(var j = 0 ; j < img.length ; j++){
		var day = j+1;
		var pick = document.getElementById("next_a"+day);
		if(pick.value === "none"){
			alert("일정을 선택해주세요.");
			return false;
		}else{
			$("form").submit();
		}
		
	}
	
}