package com.jj.inter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PlaceReviewSearchDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Location_review;

public class PlaceReviewSearch implements JourneyInterface{
	
	static PlaceReviewSearch pSelect = new PlaceReviewSearch();
	
	public static PlaceReviewSearch placeReviewSearchInter() {
		return pSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String param = request.getParameter("param");

		PlaceReviewSearchDB searchReview = PlaceReviewSearchDB.select();
		List<Location_review> lrList = searchReview.selectPlaceReview(param);
		request.setAttribute("review", lrList);
		
		return "reviewAjax.jsp";
	}

}
