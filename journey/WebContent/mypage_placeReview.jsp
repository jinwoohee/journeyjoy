<%@page import="com.jj.dto.Place"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Location_review"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<style type="text/css">
		.place_review ul { /* 장소리뷰 */
			list-style: none;
			padding-inline-start: 0px;
			margin-top: 0px;
		    margin-bottom: 0px;
		    display: flex;
		}
		
		.place_review li {
			width: calc((100% - 115px) / 2);
		    border: 1px solid #666666;
		    border-radius: 10px;
		    padding: 20px;
		    float: left;
			margin-bottom: 25px;
		}
		
		.place_review li:nth-of-type(2n-1) {
			margin-right: 30px;
		}
		
		.pc_size {
			border-bottom: 1px solid #ddd;
			margin-bottom: 25px;
		}
		
		.pc_size p {
			margin-top: 0px;
			margin-bottom: 25px;
			width: fit-content;
		}
		
		.pc_size strong {
			color : #FA5252;
		}
		
		.pc_li {
			width: 100%;
		}
		
		.pc_list { /* 장소리뷰 전체div */
			width: 100%;
			height: 300px;
			display: -webkit-box;
		}
		
		.pc_title {
			width: 200px;
		    height: 100%;
		    margin-right: 40px;
		}
		
		.pc_img { /* 장소리뷰 img div */
			width: 200px;
			height: 200px;
			margin-right: 40px;
		}
		
		.pc_img img { 
			width: 100%;
			height: 100%;
			object-fit: cover
		}
		
		.pc_pname {
			width: 100%;
		    height: calc(100% - 210px);
		    margin-top: 10px;
		}
		
		.pc_pname p {
			margin-top: 0px;
		    margin-bottom: 0px;
		    overflow-y: auto;
		    /* width: 100%; */
		    height: 100%;
		    font-weight: 600;
		}
		
		.pc_cont { /* 장소리뷰 contents */
			width: calc(100% - 240px);
			height: 100%;
		}
		
		.pc_cont div {
			margin-bottom: 10px;
		}
		
		.pc_cont p {
			margin-top: 0px;
		    margin-bottom: 0px;
		}
		
		.pc_date {
			font-size: 12px;
		    color: #ccc;
			display: flex;
		    justify-content: space-between;
		}
		
		.pc_star {
			
		}
		
		.pc_star label{
			font-size: 22px;
			color: #fc0;
		}
		
		/* 별점 */
		.star {
			appearance: none;
			margin: 0;
		}
		
		.pc_cont_detail {
			height: calc(100% - 42px);
			display: grid;
		    align-content: space-between;
		}
		
		.pc_detail {
			overflow-y: auto;
    		margin-bottom: 5px;
		}
		
		.pc_btn { /* 장소리뷰 버튼 div */
			/*height: calc(100% - 114px); */
			display: flex;
		    justify-content: flex-end;
		}
		
		.pc_btn button {
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
		
		.pc_btn button:hover {
			color: red;
			border: 1px solid red;
		}
		
		.pc_blank { /* 장소리뷰 없을 때 div */
			/* text-align: center; */
		    font-size: 18px;
		    font-weight: 600;
			height: 200px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
	</style>
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
	<%
	ArrayList<Location_review> lrList = (ArrayList<Location_review>)request.getAttribute("lrList");
	ArrayList<Place> pclist = (ArrayList<Place>)request.getAttribute("pclist");
	
	if (lrList.size() != 0) {
	%>
	<div class="pc_size">
		<p>장소리뷰 <strong><%= lrList.size() %></strong>개</p>
	</div>
	<ul>
		<div class="pc_li">
			<% for (Location_review lr : lrList) { %>
			<li>
				<div class="pc_list">
					<div class="pc_title">
						<div class="pc_img">
							<% if (lr.getLr_file1() != null) { %>
							<img src="<%= lr.getLr_file1() %>" />
							<% } else { %>
							<img src="img/travel/travel1.jpg" />
							<% } %>
						</div>
						<div class="pc_pname">
							<p>
							<%
							for (Place p : pclist) {
								if (lr.getPl_eat_no() == p.getPlac_no())
							%>
							<%= p.getPlac_name() %>
							<%
							}
							%>
							</p>
						</div>
					</div>
					<div class="pc_cont">
						<div class="pc_date">
							<p class="pc_star">
								<%
								for (int i = 1; i < 6; i++) {
									if (i <= lr.getLr_star()) {
								%>
								<input type="radio" class="star" value="<%= i %>"><label>★</label>
								<% 	} else { %>
								<input type="radio" class="star" value="<%= i %>"><label>☆</label>
								<%
									}
								}
								%>
							</p>
							<p><%= lr.getLr_date() %></p>
						</div>
						<div class="pc_cont_detail">
							<p class="pc_detail"><%= lr.getLr_contents() %></p>
							<p class="pc_btn">
								<button>리뷰삭제</button>
							</p>
						</div>
					</div>
				</div>
			</li>
			<% } %>
		</div>
	</ul>
	<% } else { %>
	<div class="pc_blank">
		장소리뷰가 존재하지 않습니다.
	</div>
	<% } %>
</body>
</html>