package com.jj.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.jj.dto.Class_list;

import static com.jj.db.JdbcUtil.*;

public class JourneySql {
	
	DataSource ds;
	Connection con;
	private static JourneySql journeySql;
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private JourneySql() {}
	
	public static JourneySql getInstance() {
		if(journeySql == null) {
			journeySql = new JourneySql();
		}
		return journeySql;
	}
	
	public void setConnection(Connection con) {
		this.con = con;
	}

	/* 모임 insert */
	public int insertClass(Class_list cl) {
		String sql = "";
		int insertCount=0;
		
		try {
			sql = "insert into class_list VALUES(default, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cl.getU_id());
			pstmt.setString(2, cl.getC_nation());
			pstmt.setString(3, cl.getC_city());
			pstmt.setString(4, cl.getC_title());
			pstmt.setString(5, cl.getC_contents());
			pstmt.setString(6, cl.getC_file1());
			pstmt.setString(7, cl.getC_file2());
			pstmt.setString(8, cl.getC_file3());
			pstmt.setInt(9, cl.getC_volume());
			pstmt.setInt(10, cl.getC_charge());
			pstmt.setString(11, cl.getC_end_date());
			pstmt.setString(12, cl.getC_url());
			
			insertCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("---JourneySql/insertClass---" + e);
		}finally {
			close(pstmt);
		}
		
		return insertCount;
		
	}

	/* 모임 select */
	public ArrayList<Class_list> selectClassList() {
		String sql = "SELECT c.*, u.u_nickname AS u_nickname \r\n" + 
						"FROM class_list c\r\n" + 
						"LEFT JOIN user u\r\n" + 
						"ON c.u_id = u.u_id \r\n" + 
						"order by c_date";
		ArrayList<Class_list> classList = new ArrayList<Class_list>();
		Class_list cl = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cl = new Class_list();
				cl.setC_no(rs.getInt("c_no"));
				cl.setU_id(rs.getString("u_id"));
				cl.setC_nation(rs.getString("c_nation"));
				cl.setC_city(rs.getString("c_city"));
				cl.setC_title(rs.getString("c_title"));
				cl.setC_contents(rs.getString("c_contents"));
				cl.setC_file1(rs.getString("c_file1"));
				cl.setC_file2(rs.getString("c_file2"));
				cl.setC_file3(rs.getString("c_file3"));
				cl.setC_volume(rs.getInt("c_volume"));
				cl.setC_charge(rs.getInt("c_charge"));
				cl.setC_end_date(rs.getString("c_end_date"));
				cl.setC_date(rs.getString("c_date"));
				cl.setC_url(rs.getString("c_url"));
				cl.setU_nickname(rs.getString("u_nickname"));
				
				classList.add(cl);
			}
		} catch (Exception e) {
			System.out.println("--- JourneySql/selectClassList---");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return classList;
	}
}
