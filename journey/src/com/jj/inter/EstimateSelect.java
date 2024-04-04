package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.EaterySelectDB;
import com.jj.conn.EstimateSelectDB;
import com.jj.conn.PlaceSelectDB;
import com.jj.conn.ScheduleSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Estimate;
import com.jj.dto.Schedule;

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
		
		
		if(num == null) {
			List<Estimate> estiList = estidb.selectMth(u_id);
			request.setAttribute("estimate", estiList);
			System.out.println("인터 널");
			return "";
		}else {
			List<Estimate> estiList = estidb.selmtd(e_no);
			request.setAttribute("estimate", estiList);
			
			ScheduleSelectDB schedb = ScheduleSelectDB.seldb();
			List<Schedule> scheList = schedb.selmtd(e_no);
			request.setAttribute("schedule", scheList);

		return "plan.jsp";
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
