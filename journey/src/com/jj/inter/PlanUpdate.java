package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PlanInsertDB;
import com.jj.conn.PlanUpdateDB;
import com.jj.dao.JourneyInterface;

public class PlanUpdate implements JourneyInterface{
	static PlanUpdate plan_upd = new PlanUpdate();
	
	public static PlanUpdate updatePlan() { 
		return plan_upd;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int e_no = Integer.parseInt(request.getParameter("e_no"));
		String plan_title = new String(request.getParameter("plan_subject").getBytes("8859_1"),"UTF-8");
		String plan_product = request.getParameter("selected_prod");
		
		PlanUpdateDB udb = PlanUpdateDB.updb();
		udb.updateMth(e_no, plan_title, plan_product);	
		request.setAttribute("paging", "list");
		
		return "plan_page.jsp";
	}

}
