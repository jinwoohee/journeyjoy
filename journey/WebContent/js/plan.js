
	   
$(function() {
	$("input[name='edit_plan']").click(function(){
		$("form").attr("action","plan_page.jsp?paging=edit_my");
	});
	$("input[name='save_acc']").click(function(){
		$("form").attr("action","planner.jj?page=plan_update");
	});
	

	  const kindWrap =  document.querySelector('#slide_div');
	  const slider = kindWrap.querySelector('.slider');
	  const slideLis = document.getElementById('plan_li');
	  var items = document.getElementById("item").value;
	  
	  /* ul 넓이 계산해 주기 */
	  const liWidth = slideLis.clientWidth;
	  const sliderWidth = (liWidth * items*3)/4;
	  slider.style.width = `${sliderWidth}px` ;

	  /* 리스너 설치하기 */
	  let currentIdx = 0; // 슬라이드 현재 번호
	  let translate = 0; // 슬라이드 위치 값
	  
	  

	  $("#right").click(function(){   //오른쪽화살표 눌렀을때 슬라이드
	    if(translate > -(liWidth)){
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
	   $("img[src*='acc']").mouseover(function(){
		   $(this).css({'box-shadow':'rgb(0, 0, 84) 1px 1px','border':'2px solid rgb(218, 218, 218)','margin-top':'-5px'});
		   var id = $(this).attr('id');
		   $("label[id='"+id+"']").css({'margin-right':'16px'});
	   });
	   $("img[src*='acc']").mouseout(function(){
		   $(this).css({'box-shadow':'0px 0px 0px 0px','border':'0px','margin-top':'0px'});
		   var id = $(this).attr('id');
		   $("label[id='"+id+"']").css({'margin-right':'20px'});
	   });
});


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
function change_main(st){
	$("div[id*='plandiv_']").hide();
	$("div[id='plandiv_"+st+"']").show();
	
	$("label[id*='plan_radio_']").css({"border-bottom":"1px solid #CCCCCC", "color":"#CCCCCC"});
	$("label[id='plan_radio_"+st+"']").css({"border-bottom":"1px solid white", "color":"#6C94B8"});
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
    
    var map3 = new google.maps.Map(document.getElementById('map3'), {
        zoom: 15,
        center: { lat: 34.6964016465328, lng: 135.4867092276206 }
      });
    var map4 = new google.maps.Map(document.getElementById('map4'), {
        zoom: 15,
        center: { lat: 34.6964016465328, lng: 135.4867092276206 }
      });
         
      var map5 = new google.maps.Map(document.getElementById('map5'), {
          zoom: 15,
          center: { lat: 34.6964016465328, lng: 135.4867092276206 }
        });
      
      var map6 = new google.maps.Map(document.getElementById('map6'), {
          zoom: 15,
          center: { lat: 34.6964016465328, lng: 135.4867092276206 }
        });
    
    google.maps.event.addDomListener(window, "load", initMap);
  }

function up_pla(num){

	var ch_num = num-1 ;
	var me = document.getElementById("plac_name"+num);
	var change = document.getElementById("plac_name"+ch_num);
	var save_me = document.getElementById("change_name"+num);
	var save_change = document.getElementById("change_name"+ch_num);
	
	var me_val = me.innerText;
	var change_val = change.innerText;
	
	save_me.setAttribute('value',change_val);
	save_change.setAttribute('value',me_val);
	
	me.textContent = save_me.value;
	change.textContent = save_change.value;

}
function down_pla(num){

	var ch_num = num+1 ;
	var me = document.getElementById("plac_name"+num);
	var change = document.getElementById("plac_name"+ch_num);
	var save_me = document.getElementById("change_name"+num);
	var save_change = document.getElementById("change_name"+ch_num);
	
	var me_val = me.innerText;
	var change_val = change.innerText;
	
	save_me.setAttribute('value',change_val);
	save_change.setAttribute('value',me_val);

	me.textContent = save_me.value;
	change.textContent = save_change.value;	
}

function add_acc(num){
	var add_sort = document.querySelector("input[name='acc_sort"+num+"']:checked");
	var add_content = document.getElementById("acc_content"+num);
	var add_price = document.getElementById("acc_price"+num);
	var add_pay = document.getElementById("pay_with"+num);
	
	var sort = document.createElement("input");
	sort.setAttribute("type","text");
	sort.name="sort"+num;
	sort.setAttribute("value", add_sort.value);
	sort.readOnly = true;
	
	var content = document.createElement("input");
	content.setAttribute("type","text");
	content.name="content"+num;
	content.setAttribute("value",add_content.value);
	content.readOnly = true;
	
	var price = document.createElement("input");
	price.setAttribute("type","text");
	price.name="prices"+num;
	price.setAttribute("value", add_price.value);
	price.readOnly = true;
	
	var pay = document.createElement("input");
	pay.setAttribute("type","text");
	pay.name="pay_with"+num;
	pay.setAttribute("value",add_pay.value);
	pay.readOnly = true;
	
	var del = document.createElement("input");
	del.setAttribute("type", "button");
	del.value="삭제";
	del.name="del_place";
	
	del.setAttribute("onclick" , "del_pl(this,"+add_price.value+")")
	
	var taList = document.getElementById('acc_table'+num);
	var row = taList.insertRow(taList.rows.length);

	var td1 = row.insertCell(0);
	var td2 = row.insertCell(1);
	var td3 = row.insertCell(2);
	var td4 = row.insertCell(3);
	var td5 = row.insertCell(4);
	
	td1.appendChild(sort);
	td2.appendChild(content);
	td3.appendChild(pay);
	td4.appendChild(price);
	td5.appendChild(del);
	

	
	var result_price = document.getElementById("result_price");
	var before = parseInt(result_price.value);
	var bb = parseInt(add_price.value);
	var after = before + bb;

	var text = document.getElementById("result_price_text");
	text.textContent = after;
	result_price.setAttribute("value", after);
	
	add_content.value = "";
	add_price.value = " ";
	add_pay.value = "현금";
	$("div[id='pay_one_div"+num+"']").slideUp();
}
function del_pl(st, i){
	var tdd = st.parentNode;
	var trr = tdd.parentNode;
	var tbb = trr.parentNode;
	tbb.removeChild(trr);
	
	var result_price = document.getElementById("result_price");
	var before = parseInt(result_price.value);
	var bb = parseInt(i);
	var after = before - bb;
	
	var text = document.getElementById("result_price_text");
	text.textContent = after;
	result_price.setAttribute("value", after);
}
function open_acc_div(num){
	$("div[id='pay_one_div"+num+"']").slideDown();
}
function close_acc_one(num){
	var add_sort = document.getElementById("acc_sort"+num);
	var add_content = document.getElementById("acc_content"+num);
	var add_price = document.getElementById("acc_price"+num);
	var add_pay = document.getElementById("pay_with"+num);
	
	add_content.value = "";
	add_price.value = " ";
	add_pay.value = "현금";
	$("div[id='pay_one_div"+num+"']").slideUp(300);
} 

function checking(id){ /*테마 체크 여부 */
	$("input[id="+id+"]").prop("checked",true);
	
	var img_id = $("label[for='"+id+"']").attr('id');
	var before_src =  $("img[id='"+img_id+"']").attr('src').replaceAll("_check","");
	var before_cut = before_src.replaceAll(".png","");
	var after = before_cut+"_check.png";

	if($("input[id='"+id+"']").is(":checked")){  
	    $("img[id='"+img_id+"']").attr("src",after);
	  }else{
	    $("img[id='"+img_id+"']").attr("src",result);
	  }
}