window.onload = function() {
	  const kindWrap =  document.querySelector('#slide_div');
	  const slider = kindWrap.querySelector('.slider');
	  const slideLis = document.getElementById('plan_li');
	  var items = document.getElementById("item").value;
	  
	  /* ul 넓이 계산해 주기 */
	  const liWidth = slideLis.clientWidth;
	  const sliderWidth = liWidth * items;
	  slider.style.width = `${sliderWidth}px` ;

	  /* 리스너 설치하기 */
	  let currentIdx = 0; // 슬라이드 현재 번호
	  let translate = 0; // 슬라이드 위치 값
	  
	  

	  $("#right").click(function(){   //오른쪽화살표 눌렀을때 슬라이드
	    if(translate > -(sliderWidth)){
	        translate -= liWidth;
	        slider.style.transform = `translateX(${translate}px)`;
	        currentIdx += 1;
	    }
	  });
	   $("#left").click(function(){  //왼쪽 화살표 눌렀을 때 슬라이드
		   if(translate < 0){
	          translate += liWidth;
	          slider.style.transform = `translateX(${translate}px)`;
	          currentIdx -= 1;
		   }
	   });
	   
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