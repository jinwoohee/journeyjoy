<%@page import="com.jj.dto.Purchase"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.jj.dto.Community"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Package_schedule"%>
<%@page import="java.util.List"%>
<%@page import="com.jj.dto.Package_like"%>
<%@page import="com.jj.dto.Package"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="css/package_detail.css">
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<script>
	$(function(){
		/* 인원선택 */
		var result = document.getElementById("total");
		result.innerHTML = $("input[name='adultFee']").val()+"원";
		
		$("aside input[type='button']").click(function(){
			var adultNum = parseInt($("#adult>input[name='adultCount']").val());
			var stdNum = parseInt($("#std>input[name='stdCount']").val()) ;
			var childNum = parseInt($("#child>input[name='childCount']").val());
			
			var adultFee = $("input[name='adultFee']").val();
			var stdFee = $("input[name='stdFee']").val();
			var childFee = $("input[name='childFee']").val();

			if($(this).parent().attr('id') == 'adult'){
				if($(this).val()=='+'){ 
					$("#adult>input[name='adultCount']").attr("value", adultNum+1);
					adultNum = parseInt($("#adult>input[name='adultCount']").val());
				}else if($(this).val()=='-'){
					if($("#adult>input[name='adultCount']").val()>0){
						$("#adult>input[name='adultCount']").attr("value", adultNum-1);
						adultNum = parseInt($("#adult>input[name='adultCount']").val());
					}
				}
			}else if($(this).parent().attr('id') == 'std'){
				if($(this).val()=='+'){ 
					$("#std>input[name='stdCount']").attr("value", stdNum+1);
					stdNum = parseInt($("#std>input[name='stdCount']").val());

				}else if($(this).val()=='-'){
					if($("#std>input[name='stdCount']").val()>0){
						$("#std>input[name='stdCount']").attr("value", stdNum-1);
						stdNum = parseInt($("#std>input[name='stdCount']").val());
					}
				}
			}else{
				if($(this).val()=='+'){ 
					$("#child>input[name='childCount']").attr("value", childNum+1);
					childNum = parseInt($("#child>input[name='childCount']").val());

				}else if($(this).val()=='-'){
					if($("#child>input[name='childCount']").val()>0){
						$("#child>input[name='childCount']").attr("value", childNum-1);
						childNum = parseInt($("#child>input[name='childCount']").val());
					}
				}
			}
			result.innerHTML = ((adultNum)*adultFee)+((stdNum)*stdFee)+((childNum)*childFee)+"원";
		});
		
		var p_no = $("input[name='no']").val();
		var u_id = $("input[name='id']").val();
		
		/* 일정안내 상세보기 */
		$('.day_detail').hide();
		$(".day_title>img").click(function(){
			if($(this).attr('src') == 'img/icon/arrow_up.png'){
        		$(this).attr('src','img/icon/arrow_down.png');
        		$('.day_detail').slideDown();
        	}else{
        		$(this).attr('src','img/icon/arrow_up.png');
        		$('.day_detail').slideUp();
        	}
		});
		
		/* 공유하기 링크복사 */
		$("#share").click(function(){
			var url = $("input[name='url']").val();
			alert("주소가 복사되었습니다.");
		});
		
		/* 찜하기 */
		$('#icon>div>img:first-of-type').click(function(){
			if($(this).attr('src') == 'img/icon/heart2.png'){ //좋아요
        		$(location).attr('href','likeInsert.jj?page=like_insert&p_no='+p_no+'&u_id='+u_id);
        	}else{//좋아요 취소
        		$(location).attr('href','likeDelete.jj?page=like_delete&p_no='+p_no+'&u_id='+u_id);
        	}
		});
		
		/* 참여마감 버튼 */
		$('input[name=end]').click(function(){
			alert("참여 마감된 여행입니다.");
			$('input[name=end]').prop("disabled");
		});
		
		/* 참여취소 버튼 */
		$('input[name=cancel]').click(function(){
			$(location).attr('href','purcahseDelete.jj?page=purchase_delete&p_no='+p_no+'&u_id='+u_id);
		});
		
	});
	
	function regist(){
		if(pForm.adultCount.value == "0" && pForm.stdCount.value == "0" && pForm.childCount.value == "0"){
			alert("인원수를 선택해주세요.");
			return false;
		}else{
			alert("패키지 여행에 참여하였습니다.");
		}
	}
	
	function commRegist(){
		if(commForm.comment_txt.value == ''){
			alert("댓글을 입력해주세요.");
			return false;
		}else{
			alert("댓글이 등록되었습니다.");
			document.commForm.submit();
		}
	}
</script>

<body>
	<jsp:include page="main_header.jsp" />
	<!-- top -->
	<section id="top_section">
		<!-- 메인이미지(왼쪽) -->
		<div id="mainImg">
			<%
				Package pk = (Package)request.getAttribute("pkDetail");
				out.println("<img src='"+pk.getP_file()+"'>");
				out.println("<input type='hidden' name='no' value='"+pk.getP_no()+"'>");
				out.println("<input type='hidden' name='id' value='"+(String) session.getAttribute("u_id")+"'>");
			%>
		</div>
		<!-- 메인정보(오른쪽) -->
		<div id="mainInfo">
			<div>
				<% out.println("<p class='title'>"+pk.getP_title()+"</p>");%>
			</div>
			<hr>
			<div>
				<div><% out.println(pk.getP_theme()); %></div>
			</div>
			<div>
				<div id="guide">
					<% 
						out.println("<img id='profile' src='"+pk.getU_profile()+"'>"); 
						out.println("<p>"+pk.getU_nickname()+"</p>");
					%>
					<div id="icon"> <!-- 좋아요한거 하트 값 가져오기 -->
					<%
						if((Package_like)request.getAttribute("likeDetail") != null){
							Package_like like = (Package_like)request.getAttribute("likeDetail");
							if(like.getU_id() != (String) session.getAttribute("u_id")){
								out.println("<div><img src='img/icon/heart.png'/></div>");
							}
						}else{
							out.println("<div><img src='img/icon/heart2.png'/></div>");
						}
						
						out.println("<img id='share' src='img/icon/share.png'>");
						out.println("<input type='hidden' name='url' value='packageDetail.jj?page=package_detail&p_no="+pk.getP_no()+"'>");
					%>
					</div>
				</div>
			</div>
			<div>
				<input type="button" name="requiry" value="문의하기">
			</div>
		</div>
	</section>
	<!-- 메인내용 -->
	<section id="main_section">
		<article>
			<!-- 여행주요일정 -->
			<div>
				<p>※여행 주요일정</p>
				<div>
					<div><p>일정</p></div>
					<div>
						<%
							out.println("<p>여행시작일 : "+pk.getP_start_date()+"</p>");
							out.println("<p>여행종료일 : "+pk.getP_end_date()+"</p>");
						%>
					</div>
				</div>
			</div>
			<hr>
			<!-- 상품가격 -->
			<div>
				<p>※상품가격</p>
				<div>
					<table>
						<tr>
							<td>구분</td>
							<td>성인<p>만 12세이상</p></td>
							<td>아동<p>만 12세미만</p></td>
							<td>유아<p>만 2세미만</p></td>
						</tr>
						<tr>
							<td>기본상품</td>
							<%
								DecimalFormat f = new DecimalFormat("###,###,###");
								out.println("<td>"+f.format(pk.getAdult_fee())+"원</td>");
								out.println("<td>"+f.format(pk.getStd_fee())+"원</td>");
								out.println("<td>"+f.format(pk.getChild_fee())+"원</td>");
							%>
						</tr>
					</table>
				</div>
			</div>
			<hr>
			<!-- 일정안내 -->
			<div>
				<p>※일정안내</p>

				<%
					List<Package_schedule> ps = (List<Package_schedule>)request.getAttribute("ps");
					
					for(Package_schedule psList : ps){
						out.println("<div>");
						out.println("<div class='day'>");
						out.println("<p>"+psList.getPs_day()+"일차</p></div>");
						out.println("<div class='day_title'>");
						out.println("<p>"+psList.getPs_title()+"</p>");
						out.println("<img src='img/icon/arrow_up.png'></div>");
						out.println("</div>");
					}
				%>

				<div class="day_detail">
				<% 
					
				%>
				</div>
			</div>
		</article>
		<aside>
			<div>
				<p>※인원선택</p>
				<form name='pForm' action='purchase.jj?page=purchase' method='post' onsubmit='return regist()'>
					<div>
						<div>
							<p>성인</p>
							<% 
								out.println("<input type='hidden' name='p_no' value='"+pk.getP_no()+"'>");
								out.println("<input type='hidden' name='u_id' value='"+pk.getU_id()+"'>");
								out.println("<p>"+f.format(pk.getAdult_fee())+"원</p>"); 
							%>
						</div>
						<div id="adult">
							<input type=button name="minus" value="-">
							<input type=text name="adultCount" value="1">
							<input type=button name="plus" value="+">
							<input type="hidden" name="adultFee" value="<%=pk.getAdult_fee() %>">
						</div>
					</div>
					<div>
						<div>
							<p>아동</p>
							<% out.println("<p>"+f.format(pk.getStd_fee())+"원</p>"); %>
						</div>
						<div id="std">
							<input type=button name="minus" value="-">
							<input type=text name="stdCount" value="0">
							<input type=button name="plus" value="+">
							<input type="hidden" name="stdFee" value="<%=pk.getStd_fee() %>">
						</div>
					</div>
					<div>
						<div>
							<p>유아</p>
							<% out.println("<p>"+f.format(pk.getChild_fee())+"원</p>"); %>
						</div>
						<div id="child">
							<input type=button name="minus" value="-">
							<input type=text name="childCount" value="0">
							<input type=button name="plus" value="+">
							<input type="hidden" name="childFee" value="<%=pk.getChild_fee() %>">
						</div>
					</div>
					<div>
						<p>총금액</p>
						<p id="total"></p>
					</div>
					
					<%
						/* 모집마감된 경우 참여버튼 안되게 */
						Date now = new Date();
						SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
						String today = sf.format(now);
						
						Purchase pc = (Purchase)request.getAttribute("purchase");
						
						int date = Integer.parseInt(today.replaceAll("-", ""));
						int getDate = Integer.parseInt(pk.getP_due_date().replaceAll("-", ""));

						if(getDate < date || getDate != date) {
							out.println("<input type='button' name='end' value='참여마감'>");
						} else {
							if(pc != null && pc.getU_id().equals((String)session.getAttribute("u_id"))){
								out.println("<input type='button' name='cancel' value='참여취소'>");
							}else{
								out.println("<input type='submit' name='join' value='참여하기'>");
							}
						}
					%>
					
				</form>
			</div>
		</aside>
		<article>
			<!-- 여행시 유의사항 -->
			<div>
				<p>※여행시 유의사항</p>
				<div>
					<b>[도쿄의 날씨]</b>
					11~04월 건기 : 북쪽 건조한 바람으로 일교차가 커서 점퍼, 긴팔, 가디건 등을 꼭 준비해야합니다.
					05`10월 우기 : 남서풍과 더불어 평균 기온 27도
					<br><br>
					<b>[열대 과일 호텔 반입 관련]</b>
					일부 호텔은 두리안, 망고스틴, 잭프룻 등의 과일 반입 및 섭취가 불가하오니 반드시 호텔 프론트에 문의바랍니다.
					<br><br>
					<b>일정 관련 안내</b>
					패키지 상품의 경우 진행 순서는 현지 사정에 따라 변경될 수 있습니다.
					패키지 일정 불참 시 여행 약관 제13조 4항에 따라 숙박/식사/관광 등 포함된 서비스가 제공되지 않습니다.
				</div>
			</div>
			<!-- 댓글 -->
			<hr>
			<div>
				<div id="reply">
				<%
					List<Community> comm = (List<Community>)request.getAttribute("comm");

					for(Community commList : comm){
						out.println("<div>");
						out.println("<img id='profile' src='"+commList.getU_profile()+"'>");
						out.println("<p>"+commList.getU_nickname()+"</p>");
						out.println("<div><p>"+commList.getComm_contents()+"</p></div>");
						out.println("<div><p>"+commList.getComm_date()+"</p></div>");
						out.println("</div>");
					}
					
				%>
				</div>
				<form name='commForm' action='commInsert.jj?page=commInsert' method='post'>
					<div id="comment">
						<%
							out.println("<input type='hidden' name='no' value='"+pk.getP_no()+"'>");
							out.println("<input type='hidden' name='id' value='"+pk.getU_id()+"'>");
						%>
						<input type="text" name="comment_txt" placeholder=" 댓글을 남겨주세요.">
						<input type="button" name="register" value="등록" onclick="commRegist()">
					</div>
				</form>
			</div>
		</article>
	</section>
	<jsp:include page="main_footer.jsp" />
</body>
</html>