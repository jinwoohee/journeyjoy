<%@page import="com.jj.dto.Location_review"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link href="css/place_review.css" rel="stylesheet" type="text/css">

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<%
		//select
		List<Location_review> lrList = (List<Location_review>)request.getAttribute("review");

		for(Location_review lr : lrList){
			out.println("<div class='review'>"); //전체
			out.println("<div>"); //프로필, 닉네임, 버튼
			out.println("<img class='profile' src='img/profile/profile.png'/>"); //select한 id의 프로필/닉네임 가져오기
			out.println("<p>"+lr.getU_nickname()+"</p>");
			if(u_id !=null && u_id.equals(lr.getU_id())){
				out.println("<button class='modify' value='"+ lr.getLr_no()+"'>수정</button>");
 						out.println("<button class='delete' value='"+ lr.getLr_no()+"'>삭제</button>");
			}
			out.println("</div><div>");
			out.println("<p>"+lr.getPl_eat_no()+"</p>"); //select한 pl_no의 관광지 이름 가져오기
			//out.println("<input type='hidden' name='star' value='"+lr.getLr_star()+"'>"); //별점
			for(int i=1; i<6; i++){
				if(i<=lr.getLr_star()){
					out.println("<input type='radio' class='star' value='"+ i +"'><label>★</label>");
				}else{
					out.println("<input type='radio' class='star' value='"+ i +"'><label>☆</label>");
				}
			}
			out.println("<textarea disabled>"+lr.getLr_contents()+"</textarea>");
			out.println("</div><div class='file'>");
			if(lr.getLr_file2() == null && lr.getLr_file3() == null){
				out.println("<img src='"+lr.getLr_file1()+"' width=520px height=300px />");
			}else if(lr.getLr_file3() == null){
				out.println("<img src='"+lr.getLr_file1()+"' width=255px height=300px />");
				out.println("<img src='"+lr.getLr_file2()+"' width=255px height=300px />");
			}else{
				out.println("<img src='"+lr.getLr_file1()+"' width=330px height=300px />");
				out.println("<img src='"+lr.getLr_file2()+"' width=180px height=145px />");
 						out.println("<img src='"+lr.getLr_file3()+"' width=180px height=145px/>");
			}
			out.println("</div><div>");
			out.println("<p>"+lr.getLr_date()+"</p>");
			out.println("</div></div>");
		}
	%>
</body>
</html>