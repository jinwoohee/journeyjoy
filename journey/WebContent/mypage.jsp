<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dto.Package" %>
<%@page import="com.jj.dto.Package_schedule"%>
<%@page import="com.jj.dto.User"%>
<%@page import="com.jj.dto.Plan_review"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map.Entry"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String u_id = (String) session.getAttribute("u_id");
	String mpg = request.getParameter("tab");	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
	<link rel="stylesheet" type="text/css" href="css/mypage.css">
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
	<!-- 주소찾기 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script>
	function sample4_execDaumPostcode() { //주소창
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수

	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample4_postcode').value = data.zonecode;
	            document.getElementById("sample4_roadAddress").value = roadAddr;
	            
	            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	            if(roadAddr !== ''){
	                document.getElementById("sample4_roadAddress").value = roadAddr + extraRoadAddr;
	            } else {
	                document.getElementById("sample4_roadAddress").value = '';
	            }

	            var guideTextBox = document.getElementById("guide");
	            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	            if(data.autoRoadAddress) {
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                guideTextBox.style.display = 'block';

	            } else if(data.autoJibunAddress) {
	                var expJibunAddr = data.autoJibunAddress;
	                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                guideTextBox.style.display = 'block';
	            }
	        }
	    }).open();
	}
	
	$(function() {
		$('.pk_update_btn').hide(); //패키지
		//$('.user_wrap').hide(); //회원수정
		
		$('.tab li').click(function() {
			var txt = $(this).text();

			$(this).css({'color' : 'black', 'border-bottom' : '3px solid black'});
			$(this).siblings('li').css({'color' : '#646464', 'border-bottom' : 'none'});
			
			if (txt == "패키지") {
				$('.package').show();
				$('.package').siblings('div').hide();
				$('.package_making').show();
				$('.package_making').siblings('div').hide();
			} else if (txt == "나의 리뷰") {
				$('.review').show();
				$('.review').siblings('div').hide();
				$('.plan_review').show();
				$('.plan_review').siblings('div').hide();
			} else if (txt == "회원정보") {
				$('.userInfo').show();
				$('.userInfo').siblings('div').hide();
				$('.user_wrap').show();
				$('.user_wrap').siblings('div').hide();
			} else {
				$('.plan_wrap').show();
				$('.cards').children('div').hide();
				$('.plan_wrap').siblings('div').hide();
			}
		});
		
		
		
		/* 패키지 */
		$('.package li').click(function() { //패키지 메뉴바 세부레이어 클릭시
			var txt = $(this).text();
			var uid = $('input[name=uid]').val();
			
			if (txt == '패키지 기획내역') {
				/*$.ajax({
					type : 'post',
					data : {'u_id' : uid},
					url : 'mypage.jj?page=mypagePackageMaking',
					success : function(data) {
						$('.package_making').html(data);
					}
				});*/
				
				$('.package_making').show();
				$('.package_making').siblings('div').hide();
			} else if (txt == '패키지 참여내역') {
				$.ajax({
					type : 'post',
					data : {'u_id' : uid},
					url : 'mypage.jj?page=mypagePackageAttending',
					success : function(data) {
						$('.package_attending').html(data);
					}
				});
				
				$('.package_attending').show();
				$('.package_attending').siblings('div').hide();
			} else if (txt == '찜한 패키지') {
				$.ajax({
					type : 'post',
					data : {'u_id' : uid},
					url : 'mypage.jj?page=mypagePackageLike',
					success : function(data) {
						$('.package_like').html(data);
					}
				});
				
				$('.package_like').show();
				$('.package_like').siblings('div').hide();
			}
		});
		
		$('.pk_btn button').click(function() { //수정하기 버튼 클릭시
			if ($(this).parent().siblings('.pk_update_btn').css('display') == 'none') {
				$(this).parent().siblings('.pk_update_btn').show();
			} else {
				$(this).parent().siblings('.pk_update_btn').hide();
			}
		});
		
		$('.pk_btn button').blur(function() { //수정하기 버튼 blur
			$('.pk_update_btn').hide();
		});
		
		
		/* 나의리뷰 */
		$('.review li').click(function() { //나의 리뷰 메뉴바 세부레이어 클릭시
			var txt = $(this).text();
			var uid = $('input[name=uid]').val();
		
			if (txt == '일정리뷰') {
				/*$.ajax({
					type : 'post',
					data : {'u_id' : uid},
					url : 'mypage.jj?page=mypagePlanReview',
					success : function(data) {
						//$('.plan_review').html(data);
					}
				});*/
				$('.plan_review').show();
				$('.plan_review').siblings('div').hide();
			} else if (txt == '장소리뷰') {
				$.ajax({
					type : 'post',
					data : {'u_id' : uid},
					url : 'mypage.jj?page=mypagePlaceReview',
					success : function(data) {
						$('.place_review').html(data);
					}
				});
				$('.place_review').show();
				$('.place_review').siblings('div').hide();
			}
		});
		
		
		
		/* 회원정보수정 */
		$('.userInfo li').click(function() { //회원정보 메뉴바 세부레이어 클릭시
			var txt = $(this).text();
			//var uid = $('input[name=uid]').val();
			
			if (txt == '회원정보 수정') {
				$('.user_wrap').show();
				$('.user_wrap').siblings('div').hide();
			} else {
				//$('.user_wrap').hide();
				$('.user_wrap').siblings('div').hide();
				
				if (!confirm("탈퇴하시겠습니까?")) {
					console.log("취소");
				} else {
					if (confirm("탈퇴되었습니다")) {
						//$('form[name=boardForm]').attr('action', 'board_deleteDB.jsp?no=' + delete_no);
					}
					
				}
			}
		});
		
		$('input[name=phone]').keyup(function () { //회원정보수정-휴대폰번호
			var num = $(this).val($(this).val().replace(/[^0-9]/g, ''));
			var tmp = '';
						
			if (num.val().length < 4) {
				
			} else if (num.val().length < 7) {
				tmp += num.val().substr(0, 3);
                tmp += '-';
                tmp += num.val().substr(3);
                $(this).val(tmp);
			} else if (num.val().length < 11) {
				tmp += num.val().substr(0, 3);
                tmp += '-';
                tmp += num.val().substr(3, 3);
                tmp += '-';
                tmp += num.val().substr(6);
                $(this).val(tmp);
			} else {
				tmp += num.val().substr(0, 3);
                tmp += '-';
                tmp += num.val().substr(3, 4);
                tmp += '-';
                tmp += num.val().substr(7);
                $(this).val(tmp);
                $(this).css({'border' : '1px solid #2C609C'});
			}
		});
		
		$('input[name=pw]').blur(function () { //회원정보수정-비밀번호
			const regPw = /^(?=.*[a-zA-Z0-9])(?=.*[!@#$%^*+=-]).{8,30}$/;
			
			if ($(this).val() != '') {
				if ($(this).val().match(regPw)) { //유효성검사 일치하면
					$(this).css({'border' : '1px solid #2C609C'});
				} else {
					$(this).css({'border' : '1px solid red'});
				}
			} else {
				$(this).css({'border' : '1px solid #646464'});
			}
		});
		
		$('input[name=pwChk]').blur(function () { //회원정보수정-비밀번호 확인
			var pwChk = $(this).val();
			var pw = $('input[name=pw]').val();
			
			if ($(this).val() != '') {
				if (pw == pwChk) {
					$(this).css({'border' : '1px solid #2C609C'});
				} else {
					alert('비밀번호가 일치하지 않습니다');
					$(this).css({'border' : '1px solid red'});
				}
			} else {
				$(this).css({'border' : '1px solid #646464'});
			}
		});
		
		$('input[name=nickname]').blur(function() { //회원정보수정-닉네임 중복체크	
			$(this).off().on('change', function() {
				$.ajax({
					type : 'post',
					data : {'nickname' : $(this).val()},
					url : 'selectNickname.jsp',
					success : function(data) {
						if (data == 1) {
							alert('이미 존재하는 닉네임 입니다');
							$('input[name=nickname]').css({'border' : '1px solid red'});
						} else {
							$('input[name=nickname]').css({'border' : '1px solid #2C609C'});
						}
					}
				});
			});
		});
		
		
		
		
		
		$('.save_btn').click(function () {
			//$('input[name=nickname]').val($('input[name=nickname]').val().replace(/^[가-힣]{2,10}$/, ''));
			
		});
		
		
		
		
	});
	</script>
</head>
<body>
	<jsp:include page="main_header.jsp" />
	
	<div class="all_wrap">
		<div class="sub_wrap">
			<input type="hidden" name="uid" value="<%= u_id %>" />
			<div class="notification_wrap">
				<%
				ArrayList<User> ulist = (ArrayList<User>)request.getAttribute("ulist");
				
				for (User u : ulist) {
				%>
				<h1><%= u.getU_name() %>님</h1>
				<% } %>
				<div class="tab">
					<ul>
						<% if (mpg.equals("myplan")) { %>
						<li class="click_li">나의 여행계획서</li>
						<% } else { %>
						<li>나의 여행계획서</li>
						<% } %>
						<% if (mpg.equals("mypackage")) { %>
						<li class="click_li">패키지</li>
						<% } else { %>
						<li>패키지</li>
						<% } %>
						<% if (mpg.equals("myreview")) { %>
						<li class="click_li">나의 리뷰</li>
						<% } else { %>
						<li>나의 리뷰</li>
						<% } %>
						<% if (mpg.equals("myinfo")) { %>
						<li class="click_li">회원정보</li>
						<% } else { %>
						<li>회원정보</li>
						<% } %>
					</ul>
				</div>
				<div class="cards">
					<!-- 패키지 -->
					<% if (mpg.equals("mypackage")) { %>
					<div class="package">
						<ul>
							<li>패키지 기획내역</li>
							<li>패키지 참여내역</li>
							<li>찜한 패키지</li>
						</ul>
					</div>
					<% } else { %>
					<div class="package no_active">
						<ul>
							<li>패키지 기획내역</li>
							<li>패키지 참여내역</li>
							<li>찜한 패키지</li>
						</ul>
					</div>
					<% } %>
					<!-- 리뷰 -->
					<% if (mpg.equals("myreview")) { %>
					<div class="review">
						<ul>
							<li>일정리뷰</li>
							<li>장소리뷰</li>
						</ul>
					</div>
					<% } else { %>
					<div class="review no_active">
						<ul>
							<li>일정리뷰</li>
							<li>장소리뷰</li>
						</ul>
					</div>
					<% } %>
					<!-- 회원정보 -->
					<% if (mpg.equals("myinfo")) { %>
					<div class="userInfo">
						<ul>
							<li>회원정보 수정</li>
							<li>회원정보 탈퇴</li>
						</ul>
					</div>
					<% } else { %>
					<div class="userInfo no_active">
						<ul>
							<li>회원정보 수정</li>
							<li>회원정보 탈퇴</li>
						</ul>
					</div>
					<% } %>
				</div>
			</div>
			
			<div class="content_wrap">
				<!-- 여행계획서 -->
				<% if (mpg.equals("myplan")) { %>
				<div class="plan_wrap">
					나의 여행계획서
				</div>
				<% } else { %>
				<div class="plan_wrap no_active">
					나의 여행계획서
				</div>
				<% } %>
				
				<!-- 패키지(기획내역) -->
				<% if (mpg.equals("mypackage")) { %>
				<div class="package_making">
					<%
					ArrayList<Package> plist = (ArrayList<Package>)request.getAttribute("package");
					HashMap<String, ArrayList<Package_schedule>> map = (HashMap<String, ArrayList<Package_schedule>>)request.getAttribute("packagesche"); //패키지 일정
					HashMap<String, ArrayList<Package_schedule>> map3 = (HashMap<String, ArrayList<Package_schedule>>)request.getAttribute("place"); //패키지 일정-장소
					HashMap<String, ArrayList<Package>> map2 = (HashMap<String, ArrayList<Package>>)request.getAttribute("reward");
					
					if (plist.size() != 0) {
					%>
					<div class="pk_size">
						<p>패키지 기획내역 <strong><%= plist.size() %></strong>개</p>
					</div>
					<ul>
					<% for (Package p : plist) { %>
						<li>
							<div class="pk_list">
								<div class="pk_img"><img src="<%= p.getP_file() %>" /></div>
								<div class="pk_cont">
									<div>
										<p class="pk_tag"><%= p.getP_nation() %></p>
										<p class="pk_tag"><%= p.getP_city() %></p>
									</div>
									<div class="pk_line">
										<p class="pk_title"><strong><%= p.getP_title() %></strong></p>
									</div>
								</div>
								<div class="pk_cont">
									<div class="pk_line">
										<p>※ 여행일정</p>
										<div class="pk_days">
										<% 
										for (Entry<String, ArrayList<Package_schedule>> e : map.entrySet()) {
											if (p.getP_no() == Integer.parseInt(e.getKey())) {
												ArrayList<Package_schedule> alist = e.getValue();
												for (Package_schedule ps : alist) {
										%>
										<p class="pk_plan">
											<%= ps.getPs_day() %>일차 > 
											<%
											for (Entry<String, ArrayList<Package_schedule>> e3 : map3.entrySet()) {
												if (p.getP_no() == Integer.parseInt(e3.getKey())) {
													ArrayList<Package_schedule> pclist = e3.getValue();
													String str = "";
													String schedule = ps.getPs_schedule().replaceAll(" ", ""); //공백제거
													String[] arr = schedule.split(",");
													//System.out.println(Arrays.toString(arr));
													for (Package_schedule pc : pclist) {
														for (int i = 0; i < arr.length; i++) {
															if (arr[i].equals(Integer.toString(pc.getPlac_no()))) {
																str += pc.getPlac_name() + ", ";
															}
														}
													}
													if (str != "") {
														str = str.substring(0, str.length() - 2);
														out.println(str);
													}
												}
											}
											%>
										</p>
										<% 
												}
											} 
										}
										%>
										</div>
									</div>
									<div>
										<p>※ 요금</p>
										<%
										for (Entry<String, ArrayList<Package>> e2 : map2.entrySet()) {
											if (p.getP_no() == Integer.parseInt(e2.getKey())) {
												ArrayList<Package> rlist = e2.getValue();
												for (Package r : rlist) {
										%>
										<c:set var="f1" value="<%= r.getAdult_fee() %>" />
										<c:set var="f2" value="<%= r.getStd_fee() %>" />
										<c:set var="f3" value="<%= r.getChild_fee() %>" />
										<fmt:formatNumber var="adult" value="${ f1 }" />
										<fmt:formatNumber var="std" value="${ f2 }" />
										<fmt:formatNumber var="child" value="${ f3 }" />
										
										<table cellpadding="5px">
											<tr>
												<td>구분</td>
												<td>성인<p>만 12세이상</p></td>
												<td>아동<p>만 12세미만</p></td>
												<td>유아<p>만 2세미만</p></td>
											</tr>
											<tr>
												<td>기본상품</td>
												<td>${ adult }원</td>
												<td>${ std }원</td>
												<td>${ child }원</td>
											</tr>
										</table>
										<%
												}
											} 
										}
										%>
									</div>
								</div>
								<div class="pk_btn">
									<button>수정하기</button>
								</div>
								<div tabindex='0' class="pk_update_btn">
									<button class="pk_update_cont">패키지 상세내용</button>
									<button class="pk_update_plan">패키지 일정</button>
									<button class="pk_update_reward">패키지 리워드</button>
								</div>
							</div>
						</li>
					<% } %>
					</ul>
					<% } else { %>
					<div class="pk_blank">
						패키지가 존재하지 않습니다.
					</div>
					<% } %>
				</div>
				<% } else { %>
				<div class="package_making no_active">
					<%
					ArrayList<Package> plist = (ArrayList<Package>)request.getAttribute("package");
					HashMap<String, ArrayList<Package_schedule>> map = (HashMap<String, ArrayList<Package_schedule>>)request.getAttribute("packagesche"); //패키지 일정
					HashMap<String, ArrayList<Package_schedule>> map3 = (HashMap<String, ArrayList<Package_schedule>>)request.getAttribute("place"); //패키지 일정-장소
					HashMap<String, ArrayList<Package>> map2 = (HashMap<String, ArrayList<Package>>)request.getAttribute("reward");
					
					if (plist.size() != 0) {
					%>
					<div class="pk_size">
						<p>패키지 기획내역 <strong><%= plist.size() %></strong>개</p>
					</div>
					<ul>
					<% for (Package p : plist) { %>
						<li>
							<div class="pk_list">
								<div class="pk_img"><img src="<%= p.getP_file() %>" /></div>
								<div class="pk_cont">
									<div>
										<p class="pk_tag"><%= p.getP_nation() %></p>
										<p class="pk_tag"><%= p.getP_city() %></p>
									</div>
									<div class="pk_line">
										<p class="pk_title"><strong><%= p.getP_title() %></strong></p>
									</div>
								</div>
								<div class="pk_cont">
									<div class="pk_line">
										<p>※ 여행일정</p>
										<div class="pk_days">
										<% 
										for (Entry<String, ArrayList<Package_schedule>> e : map.entrySet()) {
											if (p.getP_no() == Integer.parseInt(e.getKey())) {
												ArrayList<Package_schedule> alist = e.getValue();
												for (Package_schedule ps : alist) {
										%>
										<p class="pk_plan">
											<%= ps.getPs_day() %>일차 > 
											<%
											for (Entry<String, ArrayList<Package_schedule>> e3 : map3.entrySet()) {
												if (p.getP_no() == Integer.parseInt(e3.getKey())) {
													ArrayList<Package_schedule> pclist = e3.getValue();
													String str = "";
													String schedule = ps.getPs_schedule().replaceAll(" ", ""); //공백제거
													String[] arr = schedule.split(",");
													//System.out.println(Arrays.toString(arr));
													for (Package_schedule pc : pclist) {
														for (int i = 0; i < arr.length; i++) {
															if (arr[i].equals(Integer.toString(pc.getPlac_no()))) {
																str += pc.getPlac_name() + ", ";
															}
														}
													}
													if (str != "") {
														str = str.substring(0, str.length() - 2);
														out.println(str);
													}
												}
											}
											%>
										</p>
										<% 
												}
											} 
										}
										%>
										</div>
									</div>
									<div>
										<p>※ 요금</p>
										<%
										for (Entry<String, ArrayList<Package>> e2 : map2.entrySet()) {
											if (p.getP_no() == Integer.parseInt(e2.getKey())) {
												ArrayList<Package> rlist = e2.getValue();
												for (Package r : rlist) {
										%>
										<c:set var="f1" value="<%= r.getAdult_fee() %>" />
										<c:set var="f2" value="<%= r.getStd_fee() %>" />
										<c:set var="f3" value="<%= r.getChild_fee() %>" />
										<fmt:formatNumber var="adult" value="${ f1 }" />
										<fmt:formatNumber var="std" value="${ f2 }" />
										<fmt:formatNumber var="child" value="${ f3 }" />
										
										<table cellpadding="5px">
											<tr>
												<td>구분</td>
												<td>성인<p>만 12세이상</p></td>
												<td>아동<p>만 12세미만</p></td>
												<td>유아<p>만 2세미만</p></td>
											</tr>
											<tr>
												<td>기본상품</td>
												<td>${ adult }원</td>
												<td>${ std }원</td>
												<td>${ child }원</td>
											</tr>
										</table>
										<%
												}
											} 
										}
										%>
									</div>
								</div>
								<div class="pk_btn">
									<button>수정하기</button>
								</div>
								<div tabindex='0' class="pk_update_btn">
									<button class="pk_update_cont">패키지 상세내용</button>
									<button class="pk_update_plan">패키지 일정</button>
									<button class="pk_update_reward">패키지 리워드</button>
								</div>
							</div>
						</li>
					<% } %>
					</ul>
					<% } else { %>
					<div class="pk_blank">
						패키지가 존재하지 않습니다.
					</div>
					<% } %>
				</div>
				<% } %>
	
				<!-- 패키지(참여내역) -->
				<div class="package_attending no_active">
				</div>
				
				<!-- 찜한 패키지  -->
				<div class="package_like no_active">
				</div>
				
				<!-- 일정리뷰 -->
				<% if (mpg.equals("myreview")) { %>
				<div class="plan_review">
					<%
					ArrayList<Plan_review> prList = (ArrayList<Plan_review>)request.getAttribute("prList");
					
					if (prList.size() != 0) {
					%>
					<div class="plan_size">
						<p>일정리뷰 <strong><%= prList.size() %></strong>개</p>
					</div>
					<ul>
						<div class="plan_li">
							<% for (Plan_review pr : prList) { %>
							<li>
								<div class="plan_list">
									<div class="plan_img">
										<% if (pr.getPr_file() != null) { %>
										<img src="<%= pr.getPr_file() %>" />
										<% } else { %>
										<img src="img/travel/travel1.jpg" />
										<% } %>
									</div>
									<div class="plan_cont">
										<div class="plan_date">
											<p><%= pr.getPr_date() %></p>
										</div>
										<div class="plan_ctitle">
											<p class="plan_title"><strong><%= pr.getPr_title() %></strong></p>
											<p class="plan_word"><%= pr.getPr_contents() %></p>
										</div>
										<div class="plan_btn"> 
											<button>상세내역</button>
											<button>리뷰삭제</button>
										</div>
									</div>
								</div>
							</li>
							<% } %>
						</div>
					</ul>
					<% } else { %>
					<div class="plan_blank">
						일정리뷰가 존재하지 않습니다.
					</div>
					<% } %>
				</div>
				<% } else { %>
				<div class="plan_review no_active">
					<%
					ArrayList<Plan_review> prList = (ArrayList<Plan_review>)request.getAttribute("prList");
					
					if (prList.size() != 0) {
					%>
					<div class="plan_size">
						<p>일정리뷰 <strong><%= prList.size() %></strong>개</p>
					</div>
					<ul>
						<% for (Plan_review pr : prList) { %>
						<li>
							<div class="plan_list">
								<div class="plan_img">
									<% if (pr.getPr_file() != null) { %>
									<img src="<%= pr.getPr_file() %>" />
									<% } else { %>
									<img src="img/travel/travel1.jpg" />
									<% } %>
								</div>
								<div class="plan_cont">
									<div>
										<p>작성날짜 : <%= pr.getPr_date() %></p>
									</div>
									<div>
										<p class="plan_title"><strong><%= pr.getPr_title() %></strong></p>
										<p><%= pr.getPr_contents() %></p>
									</div>
									<div class="plan_btn">
										<button>상세내역</button>
										<button>리뷰삭제</button>
									</div>
								</div>
							</div>
						</li>
						<% } %>
					</ul>
					<% } else { %>
					<div class="plan_blank">
						일정리뷰가 존재하지 않습니다.
					</div>
					<% } %>
				</div>
				<% } %>
				
				<!-- 장소리뷰 -->
				<div class="place_review no_active">
				</div>
				
				<!-- 회원정보 수정 -->
				<% if (mpg.equals("myinfo")) { %>
				<div class="user_wrap">
					<% 
						for (User u : ulist) { 
						String[] addr = u.getU_addr().split("/");
					%>
					<form name="userInfoForm" method="post">
						<div class="profile">
							<div class="pf_wrap">
								<p class="pf_img">
								<% if (u.getU_profile() != null) { %>
									<img src="<%= u.getU_profile() %>" alt="1" />
								<% } else { %>
									<img src="img/profile/profile.png" alt="2" />
								<% } %>
								</p>
								<button type="button" class="pf_edit">프로필 편집</button>
								<button type="button">프로필 삭제</button>
							</div>
						</div>
						<div class="user_field">
								<table class="tbl" border="0" cellspacing="0" cellpadding="10px">
									<tr>
										<td>아이디</td>
										<td><input type="text" name="id" class="txt" maxlength="20" value="<%= u.getU_id() %>" readonly /></td>
									</tr>
									<tr>
										<td>비밀번호</td>
										<td>
											<input type="password" name="pw" class="txt" maxlength="30" placeholder="변경할 비밀번호를 입력해주세요" />
											<label class="lb">(문자, 숫자, 특수문자 포함 8~30자)</label>
										</td>
									</tr>
									<tr>
										<td>비밀번호 확인</td>
										<td>
											<input type="password" name="pwChk" class="txt" maxlength="30" placeholder="변경할 비밀번호를 입력해주세요" />
											<label class="lb">(문자, 숫자, 특수문자 포함 8~30자)</label>
										</td>
									</tr>
									<tr>
										<td>닉네임</td>
										<td>
											<input type="text" name="nickname" class="txt" maxlength="10" value="<%= u.getU_nickname() %>" />
											<label class="lb"></label>
										</td>
									</tr>
									<tr>
										<td>휴대폰 번호</td>
										<td><input type="text" name="phone" class="txt" maxlength="13" placeholder="010-0000-0000" value="<%= u.getU_phone() %>" /></td>
									</tr>
									<tr>
										<td class="addr">주소</td>
										<td>
											<input type="text" id="sample4_postcode" name="addr1" size="5" placeholder="가져올 우편번호" value="<%= addr[0] %>" readonly />
											<input type="button" value="우편번호 검색" onclick="sample4_execDaumPostcode()" /><br>
											<input type="text" id="sample4_roadAddress" name="addr2" class="txt" maxlength="50" placeholder="주소 입력" value="<%= addr[1] %>" readonly /><br>
											<% if (addr.length > 2) { %>
											<input type="text" name="addr3" class="txt" maxlength="50" placeholder="상세주소 입력" value="<%= addr[2] %>" />
											<% } else { %>
											<input type="text" name="addr3" class="txt" maxlength="50" placeholder="상세주소 입력" />
											<% } %>
										</td>
									</tr>
								</table>
						</div>
						<div class="btn_wrap">
							<button type="button" class="save_btn">저장하기</button>
						</div>
					</form>
					<% } %>
				</div>
				<% } else { %>
				<div class="user_wrap no_active">
					<% 
						for (User u : ulist) { 
						String[] addr = u.getU_addr().split("/");
					%>
					<form name="userInfoForm" method="post">
						<div class="profile">
							<div class="pf_wrap">
								<p class="pf_img">
								<% if (u.getU_profile() != null) { %>
									<img src="<%= u.getU_profile() %>" alt="1" />
								<% } else { %>
									<img src="img/profile/profile.png" alt="2" />
								<% } %>
								</p>
								<button type="button" class="pf_edit">프로필 편집</button>
								<button type="button">프로필 삭제</button>
							</div>
						</div>
						<div class="user_field">
								<table class="tbl" border="0" cellspacing="0" cellpadding="10px">
									<tr>
										<td>아이디</td>
										<td><input type="text" name="id" class="txt" maxlength="20" value="<%= u.getU_id() %>" readonly /></td>
									</tr>
									<tr>
										<td>비밀번호</td>
										<td>
											<input type="password" name="pw" class="txt" maxlength="30" placeholder="변경할 비밀번호를 입력해주세요" />
											<label class="lb">(문자, 숫자, 특수문자 포함 8~30자)</label>
										</td>
									</tr>
									<tr>
										<td>비밀번호 확인</td>
										<td>
											<input type="password" name="pwChk" class="txt" maxlength="30" placeholder="변경할 비밀번호를 입력해주세요" />
											<label class="lb">(문자, 숫자, 특수문자 포함 8~30자)</label>
										</td>
									</tr>
									<tr>
										<td>닉네임</td>
										<td>
											<input type="text" name="nickname" class="txt" maxlength="10" value="<%= u.getU_nickname() %>" />
											<label class="lb"></label>
										</td>
									</tr>
									<tr>
										<td>휴대폰 번호</td>
										<td><input type="text" name="phone" class="txt" maxlength="13" placeholder="010-0000-0000" value="<%= u.getU_phone() %>" /></td>
									</tr>
									<tr>
										<td class="addr">주소</td>
										<td>
											<input type="text" id="sample4_postcode" name="addr1" size="5" placeholder="가져올 우편번호" value="<%= addr[0] %>" readonly />
											<input type="button" value="우편번호 검색" onclick="sample4_execDaumPostcode()" /><br>
											<input type="text" id="sample4_roadAddress" name="addr2" class="txt" maxlength="50" placeholder="주소 입력" value="<%= addr[1] %>" readonly /><br>
											<% if (addr.length > 2) { %>
											<input type="text" name="addr3" class="txt" maxlength="50" placeholder="상세주소 입력" value="<%= addr[2] %>" />
											<% } else { %>
											<input type="text" name="addr3" class="txt" maxlength="50" placeholder="상세주소 입력" />
											<% } %>
										</td>
									</tr>
								</table>
						</div>
						<div class="btn_wrap">
							<button type="button" class="save_btn">저장하기</button>
						</div>
					</form>
					<% } %>
				</div>
				<% } %>
			</div>
		</div>
	</div>
</body>
</html>