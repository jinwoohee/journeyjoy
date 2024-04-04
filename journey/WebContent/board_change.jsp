<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jj.dao.BoardDB"%>
<%@page import="com.jj.dto.Board"%>
<%
	String u_id = (String)session.getAttribute("u_id");
	int no = Integer.parseInt(request.getParameter("no")); //board_cont에서 넘어온 게시글번호
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판-수정페이지</title>
	
	<link href="css/board_insert.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {
			$('.del_btn').click(function () { //취소버튼
				if (confirm("취소하시겠습니까?")) {
					console.log("취소완료");
					$('form[name="boardForm"]').attr('action', 'board.jsp');
				} else {
					console.log("그대로");
					return false;
				}
			});
			
			$('.chg_btn').click(function () {
				if($('input[name=title]').val() == "") {
					alert("제목을 입력해주세요");
					return false;
				} else if ($('select[name=nation] option:selected').text() == "국가") {
					alert("국가를 선택해주세요");
					return false;
				} else if ($('select[name=city] option:selected').text() == "도시") {
					alert("도시를 선택해주세요");
					return false;
				} else if ($('select[name=month] option:selected').text() == "여행시기") {
					alert("여행시기를 선택해주세요");
					return false;
				} else if ($('select[name=category] option:selected').text() == "카테고리") {
					alert("카테고리를 선택해주세요");
					return false;
				} else if ($('textarea[name=content]').val() == "") {
					alert("내용을 입력해주세요");
					return false;
				} else {
					alert("수정되었습니다.");
					$('form[name="boardForm"]').attr('action', 'board_updateDB.jsp?no=<%=no%>');
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="main_header.jsp" />

	<jsp:useBean id="board" class="com.jj.dao.BoardDB">
	<%
		ArrayList<Board> alist = board.selectRow(no);
		
			for (Board b : alist) {
	%>
	<div class="board_wrap">
		<div class="board">
			<p>자유게시판 > 글 수정하기</p>
			<form name="boardForm" method="post">
		       	<div class="board_write">
		       		<!-- 제목 -->
					<div class="title">
						<div>
							<label>제목</label>
						</div>
						<input type="text" name="title" value="<%= b.getB_title() %>">
					</div>
					<!-- 국가 및 도시 -->
					<div class="info">
						<div>
							<label>국가 및 도시</label>
						</div>
						<div class="slt">
							<select name="nation">
								<option>국가</option>	
								<%
									if (b.getB_nation().equals("일본")) {
										out.println("<option selected='selected'>일본</option>");
										out.println("<option>캐나다</option>");
									} else if (b.getB_nation().equals("캐나다")) {
										out.println("<option>일본</option>");
										out.println("<option selected='selected'>캐나다</option>");
									}
								%>
							</select>
							<select name="city">
								<option>도시</option>
								<%
									if (b.getB_city().equals("도쿄")) {
										out.println("<option selected='selected'>도쿄</option>");
										out.println("<option>오사카</option>");
									} else if (b.getB_city().equals("오사카")) {
										out.println("<option>도쿄</option>");
										out.println("<option selected='selected'>오사카</option>");
									}
								%>
							</select>
						</div>
					</div>
					<!-- 여행시기 -->
					<div class="info">
						<div>
							<label>여행시기</label>
						</div>
						<div class="slt">
							<select name="month">
								<option>여행시기</option>
								<%
									for (int i=1; i<13; i++) {
										if (b.getB_month().equals(i + "월")) {
											out.println("<option selected='selected'>" + i + "월</option>");
										} else {
											out.println("<option>" + i + "월</option>");
										}
									}
								%>
							</select>
						</div>
					</div>
					<!-- 카테고리 -->
					<div class="info">
						<div>
							<label>카테고리</label>
						</div>
						<div class="slt">
							<select name="category">
								<option>카테고리</option>
								<%
									if (b.getB_category().equals("날씨")) {
										out.println("<option selected='selected'>날씨</option>");
										out.println("<option>휴업</option>");
										out.println("<option>폐업</option>");
										out.println("<option>이전</option>");
									} else if (b.getB_category().equals("휴업")) {
										out.println("<option>날씨</option>");
										out.println("<option selected='selected'>휴업</option>");
										out.println("<option>폐업</option>");
										out.println("<option>이전</option>");
									} else if (b.getB_category().equals("폐업")) {
										out.println("<option>날씨</option>");
										out.println("<option>휴업</option>");
										out.println("<option selected='selected'>폐업</option>");
										out.println("<option>이전</option>");
									} else if (b.getB_category().equals("이전")) {
										out.println("<option>날씨</option>");
										out.println("<option>휴업</option>");
										out.println("<option>폐업</option>");
										out.println("<option selected='selected'>이전</option>");
									}
								%>
							</select>
						</div>
					</div>
					<!-- 내용 -->
					<div class="cont">
						<textarea name="content"><%= b.getB_contents() %></textarea>
					</div>
				</div>
				<!-- 버튼 -->
				<div class="btn_wrap">
					<button class="del_btn">취소</button>
					<button class="chg_btn">등록</button>
				</div>
			</form>
		</div>	
	</div>
	<% } %>
	</jsp:useBean>
</body>
</html>