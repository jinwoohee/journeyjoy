package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.SearchPlaceSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Place;

public class SearchPlaceSelect implements JourneyInterface{
	static SearchPlaceSelect sps = new SearchPlaceSelect();
	
	public static SearchPlaceSelect search_place() {
		return sps;
	}
	
	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Cookie[] ck = request.getCookies();
		
		String text = new String(request.getParameter("search_place").getBytes("8859_1"),"UTF-8");
		int day = Integer.parseInt(getCookieValue(ck, "datecnt"));
		for(int a = 1 ; a <= day ; a++) {
			String plan = new String(request.getParameter("edit_plan"+a).getBytes("8859_1"),"UTF-8");
			request.setAttribute("planList"+a, plan);
		}
		
		SearchPlaceSelectDB spsdb = SearchPlaceSelectDB.seldb();
		List<Place> plaList = spsdb.searchmtd(text);		
		request.setAttribute("search_place", plaList);
		System.out.println("sel"+plaList.size());
		
		return "planner_add_place.jsp";
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
