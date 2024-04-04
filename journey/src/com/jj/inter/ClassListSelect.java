package com.jj.inter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ClassListSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Class_list;

public class ClassListSelect implements JourneyInterface {
	static ClassListSelect clist = new ClassListSelect();
	
	public static ClassListSelect classlistselect() {
		return clist;
		
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ClassListSelectDB clistdb = new ClassListSelectDB();
		List<Class_list> clist = clistdb.select();
		request.setAttribute("clist", clist);
		
		return "classList.jsp";
	}
	
	
}
