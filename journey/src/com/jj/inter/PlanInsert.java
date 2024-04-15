package com.jj.inter;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.EstimateInsertDB;
import com.jj.conn.PlanInsertDB;
import com.jj.dao.JourneyInterface;

public class PlanInsert implements JourneyInterface{
	static PlanInsert plan_ins = new PlanInsert();
	
	public static PlanInsert insertPlan() { 
		return plan_ins;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int e_no = Integer.parseInt(request.getParameter("e_no"));
		String plan_title = new String(request.getParameter("plan_subject").getBytes("8859_1"),"UTF-8");
		String plan_product = request.getParameter("selected_prod");
		
		PlanInsertDB idb = PlanInsertDB.indb();
		idb.insertMth(e_no, plan_title, plan_product);	
		request.setAttribute("paging", "list");
		System.out.println("plan인설트 마지막");
		
		return "plan_page.jsp";
	}

}
