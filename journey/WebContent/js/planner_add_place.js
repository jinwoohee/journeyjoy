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
	$("button[name='search_btn']").click(function(){
		$("form").attr("action","planner.jj?page=place_search");
	});

});
function day_select(num){
	var day = "#day"+num;
	var places = "#places"+num;
	var add_btn = "#plan_add"+num;
	
	$("p[id*='day']").css({'font-size':'15px', 'margin-top':'0px', 'cursor':'pointer'});
	$(day).css({'font-size':'20px', 'margin-top':'-7px', 'cursor':'auto'});
	$("div[id*='places']").css({'display':'none'});
	$(places).css({'display':'block'});
	$("input[id*='plan_add']").css({'display':'none'});
	$(add_btn).css({'display':'block'});
}
function checking(id){ /*테마 체크 여부 */
	$("input[type='checkbox']").prop("checked", false);
	$("label").css({"background-color":"white", "color":"rgb(64,64,64)"});
	$("input[id="+id+"]").prop("checked",true);	
	  
	if($("input[id="+id+"]").is(":checked")){  
	    $("label[for="+id+"]").css({"background-color":"#1E427F", "color":"#f1f1f3"});
	  }else{
	    $("label[for="+id+"]").css({"background-color":"white", "color":"rgb(64,64,64)"});
	  }
}

function plan_add_btn(num){	
	var edit = document.getElementById("edited"+num);
	var before =document.getElementById("places_text"+num).innerText;
	var empty = document.getElementById("places_textb"+num);
	if(empty !=null){
		empty.remove();
	}
	$("input[name='place_one']").each(function(){
	    if( $(this).is(":checked") == true ){	    	
	      var id = $(this).attr('id');
	      var checkVal = " #"+$(this).val();
	      document.getElementById("places_text"+num).textContent = before+checkVal ;
	      
	      $(this).prop("checked", false);
	      $("label[for="+id+"]").css({"background-color":"white", "color":"rgb(64,64,64)"});
	      
	      var after = document.getElementById("places_text"+num).innerText;
	  	  edit.setAttribute('value',after);
	    }
	});
	
}

window.initMap = function () {
	const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 34.6964016465328, lng: 135.4867092276206 }, 
    zoom: 9,
  });
}


