$(function() {
	$(".button, #end_check").mouseover(function(){
		$(this).css({'box-shadow':'inset 5px 5px 10px #CCCCCC'});
	});
	$(".button, #end_check").mouseout(function(){
		$(this).css({'box-shadow':''});
	});
	$(".plan").mouseover(function() {
		$(this).css({'box-shadow':'0 0 0 2px rgb(64,64,64) inset'});
	});
	$(".plan").mouseout(function() {
		$(this).css({'box-shadow':'0 0 0 0px rgb(64,64,64) inset'});
	});
});

function checking(id){ /*테마 체크 여부 */
  if($("input[id="+id+"]").is(":checked")){
    $("label[for="+id+"]").css({"background-color":"#0D112D", "color":"white"});
  }else{
    $("label[for="+id+"]").css({"background-color":"white", "color":"#6C94B8"});
  }
 }