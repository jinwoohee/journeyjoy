<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dto.Package" %>
<%@page import="com.jj.dto.Package_schedule"%>
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
		$('.package_making, .pk_update_btn').hide(); //패키지, 수정버튼 상세
		$('.user_wrap').hide(); //회원수정
		
		$('.tab li').click(function() {
			var txt = $(this).text();

			$(this).css({'color' : 'black', 'border-bottom' : '3px solid black'});
			$(this).siblings('li').css({'color' : '#646464', 'border-bottom' : 'none'});
			
			if (txt == "패키지") {
				$('.plan_wrap').hide();
				$('.package').show();
				$('.review').hide();
				$('.userInfo').hide();
				$('.user_wrap, .package_making').hide();
			} else if (txt == "나의 리뷰") {
				$('.plan_wrap').hide();
				$('.package').hide();
				$('.review').show();
				$('.userInfo').hide();
				$('.user_wrap, .package_making').hide();
			} else if (txt == "회원정보") {
				$('.plan_wrap').hide();
				$('.package').hide();
				$('.review').hide();
				$('.userInfo').show();
				$('.user_wrap, .package_making').hide();
			} else {
				$('.plan_wrap').show();
				$('.package').hide();
				$('.review').hide();
				$('.userInfo').hide();
				$('.user_wrap, .package_making').hide();
			}
		});
		
		$('.package li').click(function() { //패키지 메뉴바 세부레이어 클릭시
			var txt = $(this).text();
			
			if (txt == '패키지 기획내역') {
				$('.package_making').show();
			} else if (txt == '') {
				$('.package_making').hide();
			} else {
				$('.package_making').hide();
			}
		});
		
		$('.userInfo li').click(function() { //회원정보 메뉴바 세부레이어 클릭시
			var txt = $(this).text();
			
			if (txt == '회원정보 수정') {
				$('.user_wrap').show();
			} else {
				$('.user_wrap').hide();
			}
		});
		
		$('.pk_btn button').click(function() { //수정하기 버튼 클릭시
			if ($('.pk_update_btn').css('display') == 'none') {
				$('.pk_update_btn').show();
			} else {
				$('.pk_update_btn').hide();
			}
		});
		
		$('.pk_btn button').blur(function() { //수정하기 버튼 blur
			$('.pk_update_btn').hide();
		});
		
		$('.pk_update_cont').click(function() { //수정하기 버튼 세부-패키지 상세내용
			/*$.ajax({
				type : 'post',
				data : {'' : },
				url : '',
				success : function(data) {
					
				}
			});*/
		});
		
		$('.pk_update_plan').click(function() { //수정하기 버튼 세부-패키지 일정
			
		});
		
		$('.pk_update_reward').click(function() { //수정하기 버튼 세부-패키지 리워드
			
		});
		
	});
	</script>
</head>
<body>
	<jsp:include page="main_header.jsp" />
	
	<div class="all_wrap">
		<div class="notification_wrap">
			<h1>홍길동님</h1>
			<% if (mpg.equals("myplan")) { %>
			<div class="tab">
				<ul>
					<li class="click_li">나의 여행계획서</li>
					<li>패키지</li>
					<li>나의 리뷰</li>
					<li>회원정보</li>
				</ul>
			</div>
			<div class="cards">
				<!-- 패키지 -->
				<div class="package no_active">
					<ul>
						<li>패키지 기획내역</li>
						<li>패키지 참여내역</li>
						<li>찜한 패키지</li>
					</ul>
				</div>
				<!-- 리뷰 -->
				<div class="review no_active">
					<ul>
						<li>일정리뷰</li>
						<li>장소리뷰</li>
					</ul>
				</div>
				<!-- 회원정보 -->
				<div class="userInfo no_active">
					<ul>
						<li>회원정보 수정</li>
						<li>회원정보 탈퇴</li>
					</ul>
				</div>
			</div>
			<% } else if (mpg.equals("mypackage")) { %>
			<div class="tab">
				<ul>
					<li>나의 여행계획서</li>
					<li class="click_li">패키지</li>
					<li>나의 리뷰</li>
					<li>회원정보</li>
				</ul>
			</div>
			<div class="cards">
				<!-- 패키지 -->
				<div class="package">
					<ul>
						<li>패키지 기획내역</li>
						<li>패키지 참여내역</li>
						<li>찜한 패키지</li>
					</ul>
				</div>
				<!-- 리뷰 -->
				<div class="review no_active">
					<ul>
						<li>일정리뷰</li>
						<li>장소리뷰</li>
					</ul>
				</div>
				<!-- 회원정보 -->
				<div class="userInfo no_active">
					<ul>
						<li>회원정보 수정</li>
						<li>회원정보 탈퇴</li>
					</ul>
				</div>
			</div>
			<% } else if (mpg.equals("myreview")) { %>
			<div class="tab">
				<ul>
					<li>나의 여행계획서</li>
					<li>패키지</li>
					<li class="click_li">나의 리뷰</li>
					<li>회원정보</li>
				</ul>
			</div>
			<div class="cards">
				<!-- 패키지 -->
				<div class="package no_active">
					<ul>
						<li>패키지 기획내역</li>
						<li>패키지 참여내역</li>
						<li>찜한 패키지</li>
					</ul>
				</div>
				<!-- 리뷰 -->
				<div class="review">
					<ul>
						<li>일정리뷰</li>
						<li>장소리뷰</li>
					</ul>
				</div>
				<!-- 회원정보 -->
				<div class="userInfo no_active">
					<ul>
						<li>회원정보 수정</li>
						<li>회원정보 탈퇴</li>
					</ul>
				</div>
			</div>
			<% } else if (mpg.equals("myinfo")) { %>
			<div class="tab">
				<ul>
					<li>나의 여행계획서</li>
					<li>패키지</li>
					<li>나의 리뷰</li>
					<li class="click_li">회원정보</li>
				</ul>
			</div>
			<div class="cards">
				<!-- 패키지 -->
				<div class="package no_active">
					<ul>
						<li>패키지 기획내역</li>
						<li>패키지 참여내역</li>
						<li>찜한 패키지</li>
					</ul>
				</div>
				<!-- 리뷰 -->
				<div class="review no_active">
					<ul>
						<li>일정리뷰</li>
						<li>장소리뷰</li>
					</ul>
				</div>
				<!-- 회원정보 -->
				<div class="userInfo">
					<ul>
						<li>회원정보 수정</li>
						<li>회원정보 탈퇴</li>
					</ul>
				</div>
			</div>
			<% } %>
		</div>
		
		
		<div class="content_wrap">
			<% if (mpg.equals("myplan")) { %>
			<!-- 여행계획서 -->
			<div class="plan_wrap">
				나의 여행계획서
			</div>
			<% } else { %>
			<div class="plan_wrap no_active">
				나의 여행계획서
			</div>
			<% } %>
			
			<!-- 패키지(기획내역) -->
			<div class="package_making">
				<%
				ArrayList<Package> plist = (ArrayList<Package>)request.getAttribute("package");
				HashMap<String, ArrayList<Package_schedule>> map = (HashMap<String, ArrayList<Package_schedule>>)request.getAttribute("packagesche"); //패키지 일정
				HashMap<String, ArrayList<Package_schedule>> map3 = (HashMap<String, ArrayList<Package_schedule>>)request.getAttribute("place"); //패키지 일정-장소
				HashMap<String, ArrayList<Package>> map2 = (HashMap<String, ArrayList<Package>>)request.getAttribute("reward");
				
				if (plist.size() != 0) {
				%>
				<p>패키지 기획내역 <strong><%= plist.size() %></strong>개</p>
				<% for (Package p : plist) { %>
				<ul>
					<li>
						<div class="pk_list">
							<div class="pk_img"><img src="<%= p.getP_file() %>" /></div>
							<div class="pk_cont">
								<div>
									<p class="pk_tag"><%= p.getP_nation() %></p>
									<p class="pk_tag"><%= p.getP_city() %></p>
								</div>
								<div>
									<p class="pk_title"><strong><%= p.getP_title() %></strong></p>
								</div>
								<div>
									<p>▶ 요금</p>
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
									
									<table cellpadding="10px">
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
								<div>
									<p>▶ 여행일정</p>
								<% 
								for (Entry<String, ArrayList<Package_schedule>> e : map.entrySet()) {
									if (p.getP_no() == Integer.parseInt(e.getKey())) {
										ArrayList<Package_schedule> alist = e.getValue();
										for (Package_schedule ps : alist) {
								%>
									<p class="pk_plan">
										<%= ps.getPs_day() %>일차 - 
										<%
										for (Entry<String, ArrayList<Package_schedule>> e3 : map3.entrySet()) {
											if (p.getP_no() == Integer.parseInt(e3.getKey())) {
												ArrayList<Package_schedule> pclist = e3.getValue();
												String str = "";
												String schedule = ps.getPs_schedule().replaceAll(" ", ""); //공백제거
												String[] arr = schedule.split(",");
												for (Package_schedule pc : pclist) {
													if (Arrays.asList(arr).contains(Integer.toString(pc.getPlac_no())))
														str += pc.getPlac_name() + ", ";
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
							<div class="pk_btn">
								<button>수정하기</button>
							</div>
						</div>
					</li>
				</ul>
				<% } %>
				<div tabindex='0' class="pk_update_btn">
					<button class="pk_update_cont">패키지 상세내용</button>
					<button class="pk_update_plan">패키지 일정</button>
					<button class="pk_update_reward">패키지 리워드</button>
				</div>
				<% } else { %>
				<div class="pk_blank">
					패키지가 존재하지 않습니다.
				</div>
				<% } %>
			</div>

			<!-- 패키지(참여내역) -->
			<div class="package_attending">
				<%
				if (plist.size() != 0) {
					for (Package p : plist) {
				%>
				<p>패키지 참여내역 <strong><%= plist.size() %></strong>개</p>
				<ul>
					<li>
						<div class="pk_list">
							<div class="pk_img"><img src="<%= p.getP_file() %>" /></div>
							<div class="pk_cont">
								<div>
									<p class="pk_tag"><%= p.getP_nation() %></p>
									<p class="pk_tag"><%= p.getP_city() %></p>
								</div>
								<div>
									<p class="pk_title"><strong><%= p.getP_title() %></strong></p>
								</div>
							</div>
							
						</div>
					</li>
				</ul>
				<%
					}
				}
				%>
			</div>
			
			<!-- 찜한 패키지  -->
			<div>
				
			</div>
			
			<!-- 회원정보 수정 -->
			<div class="user_wrap">
				<div class="profile">
					<p class="pf_img"><img src="img/profile/profile.png" /></p>
					<button type="button" class="pf_edit">프로필 편집</button><br>
					<button type="button">프로필 삭제</button>
				</div>
				<div class="user_field">
					<form name="userInfoForm" method="post">
						<table class="tbl" border="0" cellspacing="0" cellpadding="10px">
							<tr>
								<td>아이디</td>
								<td><input type="text" name="id" class="txt" readonly /></td>
							</tr>
							<tr>
								<td>비밀번호</td>
								<td><input type="password" name="pw" class="txt" placeholder="변경할 비밀번호를 입력해주세요" /></td>
							</tr>
							<tr>
								<td>비밀번호 확인</td>
								<td><input type="password" class="txt" placeholder="변경할 비밀번호를 다시 입력해주세요" /></td>
							</tr>
							<tr>
								<td>닉네임</td>
								<td><input type="text" name="nickname" class="txt" value="가져올 닉네임" /></td>
							</tr>
							<tr>
								<td>휴대폰 번호</td>
								<td><input type="text" name="phone" class="txt" value="가져올 휴대폰번호" /></td>
							</tr>
							<tr>
								<td class="addr">주소</td>
								<td>
									<input type="text" id="sample4_postcode" name="addr1" size="5" placeholder="가져올 우편번호" readonly />
									<input type="button" value="우편번호 검색" onclick="sample4_execDaumPostcode()" /><br>
									<input type="text" id="sample4_roadAddress" name="addr2" class="txt" maxlength="50" placeholder="주소 입력" readonly /><br>
									<input type="text" name="addr3" class="txt" maxlength="50" placeholder="상세주소 입력" />
								</td>
							</tr>
						</table>
						<div class="btn_wrap">
							<button type="button" class="save_btn">저장하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>