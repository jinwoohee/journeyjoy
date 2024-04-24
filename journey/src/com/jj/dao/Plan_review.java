package com.jj.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.jj.dto.Schedule;

public class Plan_review {
	Connection conn = null;
	Statement stmt = null;
	public void connDb() throws Exception{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip","root","1234");
		if(conn == null) 
			throw new Exception("db연결실패<br>");
		stmt = conn.createStatement();
	}
	
	public void closeDb() throws Exception{
		try{
			stmt.close();
		}catch(Exception e){	
		}try{
			conn.close();			
		}catch(Exception ex){
		}		
	}	

	/* 일정리뷰 insert */
	public void insert_plan_review(String u_id, int e_no, String pr_title, String pr_contents, String pr_file, String pr_file2, String pr_file3) throws Exception{ 
		connDb();
		String command = String.format("insert into plan_review values(%s, '%s', %s, '%s', '%s', '%s', '%s', '%s', %s);", "default", u_id, e_no, pr_title, pr_contents, pr_file, pr_file2, pr_file3, "curdate()");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
		}
	
	/* 데이리뷰 insert */
	public void insert_day_review(int pr_no, int day, String dr_contents) throws Exception{ 
		connDb();
		String command = String.format("insert into day_review values(%s, %s, '%s');", pr_no, day, dr_contents);
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
		}
	
	public ArrayList<com.jj.dto.Plan_review> select_plan_review(String num) throws Exception{
		ArrayList<com.jj.dto.Plan_review> reviewList = new ArrayList<com.jj.dto.Plan_review>();
		connDb();
		
		if(num.equals("a")) {
			ResultSet rs = stmt.executeQuery("SELECT DISTINCT *,\r\n" + 
					"(SELECT u_nickname FROM user u WHERE p.u_id = u.u_id) AS u_nickname\r\n" + 
					"FROM plan_review p;");
			while(rs.next()) {
				com.jj.dto.Plan_review review = new com.jj.dto.Plan_review();
				review.setPr_no(rs.getInt("pr_no"));
				review.setU_id(rs.getString("u_id"));
				review.setU_nickname(rs.getString("u_nickname"));
				review.setE_no(rs.getInt("e_no"));
				review.setPr_title(rs.getString("pr_title"));
				review.setPr_contents(rs.getString("pr_contents"));
				review.setPr_file(rs.getString("pr_file1"));
				review.setPr_file2(rs.getString("pr_file2"));
				review.setPr_file3(rs.getString("pr_file3"));
				review.setPr_date(rs.getDate("pr_date"));
				
				reviewList.add(review);
			}
		}else{
			ResultSet rs = stmt.executeQuery("select*from plan_review where pr_no="+num+";");
			if(rs.next()) {
				com.jj.dto.Plan_review review = new com.jj.dto.Plan_review();
				review.setPr_no(rs.getInt("pr_no"));
				review.setU_id(rs.getString("u_id"));
				review.setE_no(rs.getInt("e_no"));
				review.setPr_title(rs.getString("pr_title"));
				review.setPr_contents(rs.getString("pr_contents"));
				review.setPr_file(rs.getString("pr_file1"));
				review.setPr_file2(rs.getString("pr_file2"));
				review.setPr_file3(rs.getString("pr_file3"));
				review.setPr_date(rs.getDate("pr_date"));
				
				reviewList.add(review);
			}
		}
		closeDb();
		return reviewList;
	}
	
	/*일정리뷰 수정*/
	public void update_plan_review(int pr_no, String pr_title, String pr_contents, String pr_file, String pr_file2, String pr_file3) throws Exception{
		connDb();
		String command = String.format("update plan_review set pr_title ='"+pr_title+"', pr_contents ='"+pr_contents+"', pr_file1 ='"+pr_file+"',pr_file2 ='"+pr_file2+"' ,pr_file3 ='"+pr_file3+"'  where pr_no = "+pr_no+";");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
		}
	
	/*일정리뷰 삭제*/
	public void delete_plan_review(int pr_no) throws Exception{
		connDb();
		String command = String.format("delete from plan_review where pr_no ="+pr_no+";");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
	}
	
	/*데이리뷰 삭제*/
	public void delete_day_review(int pr_no) throws Exception{
		connDb();
		String command = String.format("delete from day_review where pr_no ="+pr_no+";");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
	}
	
	/* 일정 select */
	public ArrayList<Schedule> select_planReview_pick(int e_no) throws Exception{
		ArrayList<Schedule> scList = new ArrayList<Schedule>();
		ResultSet rs = null;
		
		try {
			connDb();
			rs = stmt.executeQuery("SELECT * FROM schedule WHERE e_no="+e_no+";");
			
			while(rs.next()) {
				Schedule schedule = new Schedule();
				
				schedule.setE_no(rs.getInt("e_no"));
				schedule.setSche_day(rs.getInt("sche_day"));
				schedule.setPlace(rs.getString("place"));
				
				scList.add(schedule);
			}
		} finally {
			closeDb();
		}
		return scList;
	}
}

