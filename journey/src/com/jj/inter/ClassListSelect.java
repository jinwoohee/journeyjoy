package com.jj.inter;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassListSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Class_list;
import com.jj.dto.Estimate;

public class ClassListSelect implements JourneyInterface {
	static ClassListSelect cSelect = new ClassListSelect();
	
	public static ClassListSelect classlistselect() {
		return cSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("--- inter/classSelect ---");

		ClassListSelectDB selectDB = new ClassListSelectDB();
		
		ArrayList<Class_list> clist = selectDB.selectClass();
		request.setAttribute("clist", clist);
		
		ArrayList<Estimate> elist = selectDB.selectEstimate(request.getParameter("u_id"));
		request.setAttribute("elist", elist);
		
		return "classList.jsp";
	}
	
	
}
