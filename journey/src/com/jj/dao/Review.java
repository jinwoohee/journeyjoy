package com.jj.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.jj.dto.Location_review;

public class Review {
	Connection conn = null;
	Statement stmt = null;
	
	/* 생성자 */
	public Review() throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver"); //라이브러리 연결은 실행시 한번만 선언하면 되기때문에
	}
	
	/* DB연결 */
	public void dbConn() throws Exception {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/trip?characterEncoding=utf8&useSSL=false", "root", "1234");
		if(conn == null)
			throw new Exception("DB에 연결할 수 없습니다.<br>");
		stmt = conn.createStatement();
	}
	
	/* DB닫기 */
	public void dbClose() {
		try{
			stmt.close();
		}catch(Exception ignored){
		}try{
			conn.close();
		}catch(Exception ignored){
		}
	}
	
	/* 장소리뷰 insert */
	public void insert_placeReview(String u_id, String contents, String lr_file1, String lr_file2, String lr_file3, int lr_star) throws Exception {
		try{
			dbConn();
			
			int success = stmt.executeUpdate("insert into location_review values(default,'"+ u_id +"', null, '"+contents+"','"+lr_file1+"','"+lr_file2+"','"+lr_file3+"', curdate(),"+lr_star+");");
			if(success != 0) {
				System.out.println("insert location_review");
			}
		}finally{
			dbClose();
		}
	}
	
	
	/* 장소리뷰 select */
	public ArrayList<Location_review> select_placeReview(int lr_no) throws Exception {
		ArrayList<Location_review> lrList = new ArrayList<Location_review>();
		ResultSet rs = null;
		
		try{
			dbConn();
			if(lr_no == 0) {
				rs = stmt.executeQuery("select * , (select u_nickname from user u where l.u_id = u.u_id) as u_nickname from location_review l;");
			}else {
				rs = stmt.executeQuery("select * , (select u_nickname from user u where l.u_id = u.u_id) as u_nickname from location_review l where lr_no="+ lr_no+";");
			}
			
			//ResultSet rs = stmt.executeQuery("select * from location_review");
			while(rs.next()){
				Location_review lr = new Location_review();
				
				lr.setU_id(rs.getString("u_id"));
				lr.setU_nickname(rs.getString("u_nickname"));
				lr.setLr_no(Integer.parseInt(rs.getString("lr_no")));
				//lr.setPl_eat_no(Integer.parseInt(rs.getString("pl_eat_no")));
				lr.setLr_contents(rs.getString("lr_contents"));
				lr.setLr_file1(rs.getString("lr_file1"));
				lr.setLr_file2(rs.getString("lr_file2"));
				lr.setLr_file3(rs.getString("lr_file3"));
				lr.setLr_date(rs.getDate("lr_date"));
				lr.setLr_star(Integer.parseInt(rs.getString("lr_star")));
				
				lrList.add(lr);
				
			}
		}finally{
			dbClose();
		}
		return lrList;
		
	}
	
	/* 검색창 select*/
	public ArrayList<Location_review> search_placeReview(String search) throws Exception{
		ArrayList<Location_review> lrList = new ArrayList<Location_review>();
		ResultSet rs = null;
		
		try{
			dbConn();
			if(search != null) {
				rs = stmt.executeQuery("select * , (select u_nickname from user u where l.u_id = u.u_id) as u_nickname from location_review l where pl_eat_no like '%"+search+"%' or lr_contents like '%"+ search +"';");
			}else {
				rs = stmt.executeQuery("select * , (select u_nickname from user u where l.u_id = u.u_id) as u_nickname from location_review l;");
			}
			
			//ResultSet rs = stmt.executeQuery("select * from location_review");
			while(rs.next()){
				Location_review lr = new Location_review();
				
				lr.setU_id(rs.getString("u_id"));
				lr.setU_nickname(rs.getString("u_nickname"));
				lr.setLr_no(Integer.parseInt(rs.getString("lr_no")));
				//lr.setPl_eat_no(Integer.parseInt(rs.getString("pl_eat_no")));
				lr.setLr_contents(rs.getString("lr_contents"));
				lr.setLr_file1(rs.getString("lr_file1"));
				lr.setLr_file2(rs.getString("lr_file2"));
				lr.setLr_file3(rs.getString("lr_file3"));
				lr.setLr_date(rs.getDate("lr_date"));
				lr.setLr_star(Integer.parseInt(rs.getString("lr_star")));
				
				lrList.add(lr);
				
			}
		}finally{
			dbClose();
		}
		return lrList;
	}
	
	
	
	/* 장소리뷰 update */
	public void update_placeReview(String u_id, int lr_no,String contents, String lr_file1, String lr_file2, String lr_file3, int lr_star) throws Exception {
		try{
			dbConn();
			int success = stmt.executeUpdate("update location_review set lr_contents='"+ contents +"', lr_file1='"+ lr_file1+"', lr_file2='"+lr_file2+"', lr_file3='"+lr_file3+"', lr_star="+lr_star+", lr_date=curdate() where u_id='"+u_id+"' and lr_no="+lr_no+";");
			
			if(success != 0) {
				System.out.println("update location_review");
			}
		}finally{
			dbClose();
		}
	}
	
	
	
	/* 장소리뷰 delete */
	public void delete_placeReview(String u_id, int lr_no) throws Exception{
		try{
			dbConn();
			int success = stmt.executeUpdate("delete from location_review where u_id='"+u_id+"' and lr_no='"+ lr_no +"' ;");
			
			if(success != 0) {
				System.out.println("delete location_review");
			}
		}finally{
			dbClose();
		}
	}
}
