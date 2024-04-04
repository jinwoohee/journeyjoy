package com.jj.inter;

import java.util.List;

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
	public String journeyinter(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		String text = new String(request.getParameter("search_place").getBytes("8859_1"),"UTF-8");
		
		
		SearchPlaceSelectDB spsdb = SearchPlaceSelectDB.seldb();
		List<Place> plaList = spsdb.searchmtd(text);		
		request.setAttribute("search_place", plaList);
		System.out.println("sel"+plaList.size());
		
		return "planner_add_place.jsp";
	}
}
