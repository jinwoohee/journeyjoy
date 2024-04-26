package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypagePlaceReviewSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Location_review;

public class MypagePlaceReviewSelect implements JourneyInterface {
	static MypagePlaceReviewSelect mpcSelect = new MypagePlaceReviewSelect();
	
	public static MypagePlaceReviewSelect mypagePlaceReviewSelect() {
		return mpcSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		
		MypagePlaceReviewSelectDB mpcSelectDB = new MypagePlaceReviewSelectDB();
		ArrayList<Location_review> lrList = mpcSelectDB.mypagePlaceReviewSelectDB(u_id);
		
		request.setAttribute("lrList", lrList);
		
		return "mypage_placeReview.jsp";
	}

}
