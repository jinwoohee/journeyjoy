package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.EstimateSelectDB;
import com.jj.conn.ProductSelectDB;
import com.jj.conn.ScheduleSelectDB;
import com.jj.conn.TicketSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Estimate;
import com.jj.dto.Product;
import com.jj.dto.Schedule;
import com.jj.dto.Ticket;

public class EstimateSelect implements JourneyInterface{
	static EstimateSelect esti_sel = new EstimateSelect();
	
	public static EstimateSelect selectEstimate() {
		return esti_sel;
	}
	
	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Cookie[] ck = request.getCookies();
		String num = getCookieValue(ck, "e_no");
		String u_id = getCookieValue(ck, "u_id");
		EstimateSelectDB estidb = EstimateSelectDB.seldb();
		int e_no = Integer.parseInt(num);
		String product = getCookieValue(ck,"e_destination");
		String ticket = getCookieValue(ck, "e_detail_thema");
		
		if(num == null) { //list불러올때
			List<Estimate> estiList = estidb.selectMth(u_id);
			request.setAttribute("estimate", estiList);
			System.out.println("인터 널");
			return "";
		}else { // detail 불러올때
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
