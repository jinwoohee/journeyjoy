package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassInsertDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Class_list;

public class ClassInsert implements JourneyInterface{
	
	static ClassInsert cInsert = new ClassInsert();
	
	public static ClassInsert classInsert() {
		return cInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/classInsert ---");
		
		ClassInsertDB insertDB = new ClassInsertDB();
		
		String title = new String(request.getParameter("title").getBytes("8859_1"),"UTF-8");
		String contents = new String(request.getParameter("contents").getBytes("8859_1"),"UTF-8");
		
		Class_list cl = new Class_list();
		cl.setU_id(request.getParameter("u_id"));
		cl.setC_nation("tokyo");
		//cl.setC_nation(request.getParameter("")); > plan에서 내가 여행중인 국가 값 가져오기
		cl.setC_city(request.getParameter("city"));
		cl.setC_title(title);
		cl.setC_contents(contents);
		cl.setC_file1("");
		cl.setC_file2("");
		cl.setC_file3("");
		cl.setC_volume(Integer.parseInt(request.getParameter("volumn")));
		cl.setC_charge(Integer.parseInt(request.getParameter("charge")));
		cl.setC_end_date(request.getParameter("endDt"));
		cl.setC_url(request.getRequestURI());
		
		insertDB.insertClass(cl);

		return "classList.jj?page=clist";
	}

}
