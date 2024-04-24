package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypageUserInfoSelectDB;
import com.jj.dao.JourneyInterface;

public class MypageUserInfoSelect implements JourneyInterface {
	static MypageUserInfoSelect muSelect = new MypageUserInfoSelect();
	
	public static MypageUserInfoSelect mypageUserInfoSelect() {
		return muSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		String tab = request.getParameter("tab");
		
		MypageUserInfoSelectDB muSelectDB = new MypageUserInfoSelectDB();
		muSelectDB.mypageUserInfoSelectDB(u_id);
		
		
		
		return null;
	}
	

}
