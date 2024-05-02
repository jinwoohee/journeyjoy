package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.dao.JourneyInterface;

public class NaverLogin implements JourneyInterface {
	static NaverLogin nLogin = new NaverLogin();
	
	public static NaverLogin naverLogin() {
		return nLogin;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String code = request.getParameter("code");
		System.out.println(code);
		
		return null;
	}

}
