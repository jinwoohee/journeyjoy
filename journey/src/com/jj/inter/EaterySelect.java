package com.jj.inter;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.EaterySelectDB;
import com.jj.conn.PlaceSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Eatery;
import com.jj.dto.Place;

public class EaterySelect implements JourneyInterface{
	static EaterySelect eat_sel = new EaterySelect();
	
	public static EaterySelect select_eat() {
		return eat_sel;
	}
	
	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		Cookie[] ck = request.getCookies();
		String e_food_taste = getCookieValue(ck, "e_food_taste");
		String thema = getCookieValue(ck, "e_thema");
		String d_thema = getCookieValue(ck, "e_detail_thema");
		String day = getCookieValue(ck, "datecnt");
		
		EaterySelectDB esdb = EaterySelectDB.seldb();
		List<Eatery> eatList = esdb.selectMth(e_food_taste,day);			
		request.setAttribute("eatery", eatList);	
		
		PlaceSelectDB psdb = PlaceSelectDB.seldb();
		List<Place> plaList = psdb.selectMth(thema, d_thema,day);		
		request.setAttribute("place", plaList);
		
		return "planner_select.jsp";
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
