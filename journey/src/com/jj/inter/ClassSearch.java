package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassSearchDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Class_list;

public class ClassSearch implements JourneyInterface{
	
	static ClassSearch classSelect = new ClassSearch();
	
	public static ClassSearch classSearchSelect() {
		return classSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String param = request.getParameter("param");
		
		ClassSearchDB selectDB = new ClassSearchDB();
		
		ArrayList<Class_list> clist = selectDB.searchClass(param);
		request.setAttribute("clist", clist);
		
		return "classTabAjax.jsp";
	}

}
