package com.jj.inter;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.InquiryInsertDB;
import com.jj.dao.JourneyInterface;

public class InquiryInsert implements JourneyInterface {
	static InquiryInsert qInsert = new InquiryInsert();
	
	public static InquiryInsert inquiryInsert() {
		return qInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String i_contents = new String(request.getParameter("inquiryContent").getBytes("8859_1"),"UTF-8");
		int p_no = Integer.parseInt(request.getParameter("no"));
		String u_id = request.getParameter("id");
		//System.out.println("InquiryInsert----->"+p_no+"/"+u_id+"/"+i_contents);
		
		InquiryInsertDB qInsertDB = new InquiryInsertDB();
		int row = qInsertDB.inquiryInsertDB(i_contents, p_no, u_id);
		
		return "packageDetail.jj?page=package_detail&p_no="+p_no;
	}

}
