package com.jj.inter;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.EstimateInsertDB;
import com.jj.conn.ScheduleInsertDB;
import com.jj.dao.JourneyInterface;

public class ScheduleInsert implements JourneyInterface{
	static ScheduleInsert schin = new ScheduleInsert();
	
	public static ScheduleInsert insertSchedule() {
		return schin;
	}

	public String journeyinter(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Cookie[] ck = request.getCookies();
		
		int e_no = (int) request.getAttribute("e_no"); 
		int day = Integer.parseInt(getCookieValue(ck, "datecnt"));
		
		for(int a = 1 ; a <= day ; a++) {		
			String place = getCookieValue(ck, "pla"+a);
			ScheduleInsertDB isc = ScheduleInsertDB.insertdb();
			int i = isc.insertMtd(e_no, a, place);

		}
		return "plan.jsp";
		
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
