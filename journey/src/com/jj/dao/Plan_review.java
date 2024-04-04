package com.jj.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

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

	public void insert_plan_review(String u_id, String pr_title, String pr_contents) throws Exception{ 
		connDb();
		String command = String.format("insert into plan_review values(%s,'%s', %s, '%s', '%s','%s', %s);", "default", u_id, "null", pr_title, pr_contents, "tokyo8.jpg", "curdate()");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
		}
	public void insert_day_review( int day, String dr_contents) throws Exception{ 
		connDb();
		String command = String.format("insert into day_review values(%s, %s, '%s');", "null", day, dr_contents);
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
		}
	
	public ArrayList<com.jj.dto.Plan_review> select_plan_review(String num) throws Exception{
		ArrayList<com.jj.dto.Plan_review> reviewList = new ArrayList<com.jj.dto.Plan_review>();
		connDb();
		if(num.equals("a")) {
			ResultSet rs = stmt.executeQuery("select*from plan_review;");
			while(rs.next()) {
				com.jj.dto.Plan_review review = new com.jj.dto.Plan_review();
				review.setpr_no(rs.getInt("pr_no"));
				review.setu_id(rs.getString("u_id"));
				review.setplan_no(rs.getInt("plan_no"));
				review.setpr_title(rs.getString("pr_title"));
				review.setpr_contents(rs.getString("pr_contents"));
				review.setpr_file(rs.getString("pr_file"));
				review.setpr_date(rs.getDate("pr_date"));
				
				reviewList.add(review);
			}
		}else{
			ResultSet rs = stmt.executeQuery("select*from plan_review where pr_no= "+num+";");
			if(rs.next()) {
				com.jj.dto.Plan_review review = new com.jj.dto.Plan_review();
				review.setpr_no(rs.getInt("pr_no"));
				review.setu_id(rs.getString("u_id"));
				review.setplan_no(rs.getInt("plan_no"));
				review.setpr_title(rs.getString("pr_title"));
				review.setpr_contents(rs.getString("pr_contents"));
				review.setpr_file(rs.getString("pr_file"));
				review.setpr_date(rs.getDate("pr_date"));
				
				reviewList.add(review);
			}
		}
		closeDb();
		return reviewList;
	}

	public void update_plan_review(String pr_title, String pr_contents, String pr_file, String pr_no) throws Exception{
		connDb();
		String command = String.format("update plan_review set pr_title ='"+pr_title+"', pr_contents ='"+pr_contents+"', pr_file ='"+pr_file+".jpg' where pr_no = "+pr_no+";");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
		}
	public void delete_plan_review(String pr_no) throws Exception{
		connDb();
		String command = String.format("delete from plan_review where pr_no ="+pr_no+";");
		int rowNum = stmt.executeUpdate(command);
		if(rowNum < 1)
		throw new Exception("데이터 입력 실패");
		
		closeDb();
	}
}

