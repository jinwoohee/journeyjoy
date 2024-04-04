window.onload = function() {
  const kindWrap =  document.querySelector('.kind_wrap');
  const slider = kindWrap.querySelector('.slider');
  const slideLis = slider.querySelectorAll('li')

  /* ul 넓이 계산해 주기 */
  const liWidth = slideLis[0].clientWidth;
  const sliderWidth = liWidth * slideLis.length;
  slider.style.width = `${sliderWidth}px` ;

  /* 리스너 설치하기 */
  let currentIdx = 0; // 슬라이드 현재 번호
  let translate = 0; // 슬라이드 위치 값

  $("#right, .next").click(function(){   //오른쪽화살표 눌렀을때 슬라이드
      if (currentIdx !== slideLis.length -1) {
        translate -= liWidth;
        slider.style.transform = `translateX(${translate}px)`;
        currentIdx += 1;
      }
  });
   $("#left").click(function(){  //왼쪽 화살표 눌렀을 때 슬라이드
        if (currentIdx !== 0) {
          translate += liWidth;
          slider.style.transform = `translateX(${translate}px)`;
          currentIdx -= 1;
        }
      });


  $("#air").change(function(){ /*항공권 여부 체크박스 */
      if($("#air").is(":checked")){``
        $("#airplane").css({"border-color":"#1E427F", "color":"#2C609C"});
        $("#air_check").attr("src","img/icon/airplane_checked.png");
      }else{
        $("#airplane").css({"border-color":"#f1f1f3", "color":"rgb(64,64,64)"});
        $("#air_check").attr("src","img/icon/airplane_check.png");
      }
    });
   $("#ho").change(function(){ /*숙소 여부 체크박스 */
      if($("#ho").is(":checked")){
        $("#hotel").css({"border-color":"#1E427F", "color":"#2C609C"});
        $("#hotel_check").attr("src","img/icon/hotel_checked.png");
      }else{
        $("#hotel").css({"border-color":"#f1f1f3", "color":"rgb(64,64,64)"});
        $("#hotel_check").attr("src","img/icon/hotel_check.png");
      }
    });

}

 function checking(id){ /*테마 체크 여부 */
  if($("input[id="+id+"]").is(":checked")){
    $("label[for="+id+"]").css({"background-color":"#1E427F", "color":"#f1f1f3"});
  }else{
    $("label[for="+id+"]").css({"background-color":"#f1f1f3", "color":"rgb(64,64,64)"});
  }
 }
function login_check(){
	alert("로그인을 해주세요.");
}
 

