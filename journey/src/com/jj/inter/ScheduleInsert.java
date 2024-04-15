package com.jj.inter;

import java.util.Arrays;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.ScheduleInsertDB;
import com.jj.dao.JourneyInterface;

public class ScheduleInsert implements JourneyInterface{
	static ScheduleInsert sche_in = new ScheduleInsert();
	
	public static ScheduleInsert insertSchedule() {
		return sche_in;
	}

	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Cookie[] ck = request.getCookies();
		int e_no = (int) request.getAttribute("e_no");	
		int day = Integer.parseInt(getCookieValue(ck, "datecnt"));
		
		for(int a = 1 ; a <= day ; a++) {		
			String place_arr= new String(request.getParameter("place_name"+a).getBytes("8859_1"),"UTF-8");
			System.out.println(place_arr);
			String place = place_arr.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(" ", "").replaceAll("empty", "");
			ScheduleInsertDB isc = ScheduleInsertDB.insertdb();
			int i = isc.insertMtd(e_no, a, place);
		}
		
		String num = e_no+"";
		request.setAttribute("e_no", num);
		request.setAttribute("paging", "detail_my");
		
		return "plan_page.jsp";
		
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
