<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dto.Package" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<style type="text/css">
		.package_attending ul { /* 패키지-패키지 참여내역 */
			list-style: none;
			padding-inline-start: 0px;
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.package_attending li {
			padding-top: 25px;
    		padding-bottom: 25px;
		    border-bottom: 1px solid #ddd;
		}
		
		.package_attending > p {
			margin-bottom: 0px;
		}
		
		.pk_alist { /* 패키지 참여내역 전체div */
			width: 1200px;
			display: -webkit-box;
		}
		
		.pk_aimg { /* 패키지 참여내역 img div */
			width: 200px;
			height: 200px;
			margin-right: 40px;
		}
		
		.pk_aimg img { 
			width: 100%;
			height: 100%;
			object-fit: cover
		}
		
		.pk_acont { /* 패키지 참여내역 contents */
			width: 850px;
			margin-bottom: 20px;
		}
		
		.pk_acont div {
			display: flow-root;
			margin-bottom: 15px;
		}
		
		.pk_acont p {
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.pk_atag {
			float: left;
		    border: 1px solid #6C94B8;
		    /* border-radius: 20px; */
		    width: fit-content;
		    height: fit-content;
		    color: #6C94B8;
		    font-weight: 600;
		    text-align: center;
		    margin-right: 10px;
		    padding: 1px 7px;
		    background-color: white;
		}
		
		.pk_atitle { /* 제목 */
			font-size: 18px;
		}
		
		.pk_abtn { /* 패키지 참여내역 버튼 div */
			height: 200px;
			display: flex;
		    align-items: center;
		}
		
		.pk_abtn button {
			width: 110px;
		    height: 46px;
			color: #6C94B8;
			font-size: 15px;
			font-weight: 600;
		    font-family: "Noto Sans KR", sans-serif;
		    background-color: white;
			border: 1px solid #6C94B8;
			border-radius: 4px;
		}
		
		.pk_abtn button:last-of-type {
			margin-top: 5px;
		}
		
		.pk_abtn button:last-of-type:hover { /* 참여취소 버튼 */
		    color: red;
			border: 1px solid red;
		}
		
		.pk_abtn_detail {
			display: grid;
		}
		
		
		
		.pk_ablank { /* 패키지 참여내역 없을 때 div */
			text-align: center;
		    font-size: 18px;
		    font-weight: 600;
		}
	</style>
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
	<%
	ArrayList<Package> plist = (ArrayList<Package>)request.getAttribute("plist");
	
	if (plist.size() != 0) {
	%>
	<p>패키지 참여내역 <strong><%= plist.size() %></strong>개</p>
	<ul>
	<% for (Package p : plist) { %>
		<li>
			<div class="pk_alist">
				<div class="pk_aimg"><img src="<%= p.getP_file() %>" /></div>
				<div class="pk_acont">
					<div>
						<p class="pk_atag"><%= p.getP_nation() %></p>
						<p class="pk_atag"><%= p.getP_city() %></p>
					</div>
					<div>
						<p class="pk_atitle"><strong><%= p.getP_title() %></strong></p>
					</div>
					<div>
						<p><strong>▶ 여행일정</strong></p>
						<p><%= p.getP_start_date() %> ~ <%= p.getP_end_date() %></p>
					</div>
				</div>
				<div class="pk_abtn">
					<div class="pk_abtn_detail">
						<button>상세내역</button>
						<button>참여 취소</button>
					</div>
				</div>
			</div>
		</li>
	<% } %>
	</ul>
	<% } else { %>
	<div class="pk_ablank">
		패키지가 존재하지 않습니다.
	</div>
	<%
	} 
	%>
</body>
</html>