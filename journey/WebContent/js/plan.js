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
	$("input[name='edit_plan']").click(function(){
		$("form").attr("action","plan_page.jsp?paging=edit_my");
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

function add_prod(num){
	var product_name = document.getElementById("product_name"+num).innerText;
	var product_sort = document.getElementById("product_sort"+num).value;
	var product_price = document.getElementById("product_price"+num).innerText;
	var product_no = document.getElementById("product_no"+num).value;
	
	var name = document.createElement("p");
	name.textContent = product_name;
	name.id = "product_add_name"+num;
	
	var sort = document.createElement("p");
	sort.textContent = product_sort;
	sort.id = "product_add_sort"+num;
	
	var price = document.createElement("p");
	price.textContent = product_price;
	price.id = "product_add_price"+num;
	
	var del = document.createElement("img");
	del.setAttribute("src", "img/icon/minus.png");
	del.setAttribute("onclick" , "cancel_prod("+num+")");
	del.id = "del"+num;
	
	var no = document.createElement("input");
	no.setAttribute("type","hidden");
	no.value = product_no;
	no.id = "num"+num;
	
	var taList = document.getElementById('product_table');
	var row = taList.insertRow(taList.rows.length);
	
	var td1 = row.insertCell(0);
	var td2 = row.insertCell(1);
	var td3 = row.insertCell(2);
	var td4 = row.insertCell(3);
	
	td1.appendChild(name);
	td1.appendChild(no);
	td2.appendChild(sort);
	td3.appendChild(price);
	td4.appendChild(del);
	
	var div = document.getElementById("product_item"+num);
	div.style.display = "none";
	
	
	var select = document.getElementById("selected_prod");
	
	var after = select.value+product_no+",";
	select.setAttribute('value',after);
}
function cancel_prod(num){
	var select = document.getElementById("selected_prod");
	var no = document.getElementById("num"+num).value+",";
	var result = select.value.replaceAll(no,"");
	select.setAttribute('value',result);
	
	var tdd = document.getElementById("del"+num).parentNode;
	var trr = tdd.parentNode;
	var tbb = trr.parentNode;
	tbb.removeChild(trr);
	
	var div = document.getElementById("product_item"+num);
	div.style.display = "block";
	
}

function initMap() {
    var map1 = new google.maps.Map(document.getElementById('map1'), {
      zoom: 15,
      center: { lat: 34.6964016465328, lng: 135.4867092276206 }
    });
       
    var map2 = new google.maps.Map(document.getElementById('map2'), {
        zoom: 15,
        center: { lat: 34.6964016465328, lng: 135.4867092276206 }
      });

    google.maps.event.addDomListener(window, "load", initMap);
  }



