package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassTabSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Class_list;

public class ClassTabSelect implements JourneyInterface{
	
	static ClassTabSelect tabSelect = new ClassTabSelect();
	
	public static ClassTabSelect classTabSelect() {
		return tabSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/classTabSelect ---");
		
		String tab = request.getParameter("tab");
		String u_id = request.getParameter("u_id");
		
		ClassTabSelectDB selectDB = new ClassTabSelectDB();
		
		ArrayList<Class_list> clist = selectDB.selectTabClass(tab, u_id);
		request.setAttribute("clist", clist);
		
		return "classTabAjax.jsp";
	}
}
