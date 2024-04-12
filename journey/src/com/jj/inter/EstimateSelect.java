package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jj.conn.EstimateSelectDB;
import com.jj.conn.PlanSelectDB;
import com.jj.conn.ProductSelectDB;
import com.jj.conn.ScheduleSelectDB;
import com.jj.conn.TicketSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Estimate;
import com.jj.dto.Plan;
import com.jj.dto.Product;
import com.jj.dto.Schedule;
import com.jj.dto.Ticket;
import com.mysql.cj.Session;

public class EstimateSelect implements JourneyInterface{
	static EstimateSelect esti_sel = new EstimateSelect();
	
	public static EstimateSelect selectEstimate() {
		return esti_sel;
	}
	
	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub	
		HttpSession session = request.getSession(false);
		String u_id = (String) session.getAttribute("u_id");

		Cookie[] ck = request.getCookies();
		String num = getCookieValue(ck, "e_no");
		String product = getCookieValue(ck,"e_destination");
		String ticket = getCookieValue(ck, "e_detail_thema");
		String wh = getCookieValue(ck, "where");

		EstimateSelectDB estidb = EstimateSelectDB.seldb();
		
		System.out.println(wh);
		if(wh != null) { //list불러올때
			if(wh.equals("list")) {		
				System.out.println("");
				List<Estimate> estiList = estidb.selectMth(u_id);
				request.setAttribute("estimate", estiList);
				return "plan.jj?page=plan_select";
			}
			else if(wh.equals("detail")){ // detail 불러올때
				System.out.println("notlist");
				int e_no = Integer.parseInt(num);
				List<Estimate> estiList = estidb.selmtd(e_no); // 견적 select
				request.setAttribute("estimate", estiList);
				
				ScheduleSelectDB schedb = ScheduleSelectDB.seldb(); // 일정 select
				List<Schedule> scheList = schedb.selmtd(e_no);
				request.setAttribute("schedule", scheList);
				
				ProductSelectDB proddb = ProductSelectDB.seldb(); // 상품 select
				List<Product> prodList = proddb.selectMth(product);
				request.setAttribute("product", prodList);
				
				TicketSelectDB tickdb = TicketSelectDB.seldb(); // 티켓 select
				List<Ticket> tickList = tickdb.selectMth(ticket);
				request.setAttribute("ticket", tickList);
			
				return "plan.jsp"; // 가지고 온 데이터를 가지고 원래는 plan_select로 가서 list출력인지 detail출력인지 정한다. 가 위의 if num == null
			}else if(wh.equals("detail_my")) {
				System.out.println("my");
				int e_no = Integer.parseInt(num);
				List<Estimate> estiList = estidb.selmtd(e_no); // 견적 select
				request.setAttribute("estimate", estiList);
				
				ScheduleSelectDB schedb = ScheduleSelectDB.seldb(); // 일정 select
				List<Schedule> scheList = schedb.selmtd(e_no);
				request.setAttribute("schedule", scheList);
				
				PlanSelectDB plandb = PlanSelectDB.seldb();
				List<Plan> planList = plandb.select_e_no(e_no);
				request.setAttribute("plan", planList);
				
				ticket = estiList.get(0).gete_detail_thema();
				product = estiList.get(0).gete_destination();
				
				ProductSelectDB proddb = ProductSelectDB.seldb(); // 상품 select
				List<Product> prodList = proddb.selectMth(product);
				request.setAttribute("product", prodList);
				
				TicketSelectDB tickdb = TicketSelectDB.seldb(); // 티켓 select
				List<Ticket> tickList = tickdb.select_myMth(ticket);
				request.setAttribute("ticket", tickList);
				System.out.println("my끝");
				
				request.setAttribute("paging", "my_detail");
				return "plan.jsp";
			}
			else {
				return "";
			}
		}else {
			return "";
		}
	}
	
	private String getCookieValue(Cookie[] cookies, String name) {
		String value = null;
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals(name)) {
					return cookie.getValue();
				}
			}return null;
		}else {
			return null;
		}
	}
}
