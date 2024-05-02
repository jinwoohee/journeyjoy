package com.jj.inter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jj.dao.JourneyInterface;
import com.jj.dto.NaverToken;
import com.jj.dto.NaverUser;

public class NaverLogin implements JourneyInterface {
	static NaverLogin nLogin = new NaverLogin();
	
	public static NaverLogin naverLogin() {
		return nLogin;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String session_state = (String) session.getAttribute("state");
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		
		if (!state.equals(session_state)) {
	        System.out.println("세션 불일치");
	        request.getSession().removeAttribute("state");
	        return "/error";
	    }
		
		String result = GetNaverToken.getNaverToken(code, state);
		NaverToken naverToken = GetNaverUserInfo.getNaverUserInfo(result);
		String access_token = naverToken.getAccess_token();
		
		String user = "", line = "";
		try {
			URL url = new URL("https://openapi.naver.com/v1/nid/me");
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	        conn.setRequestProperty("Authorization", "Bearer "+access_token);
	        
	        try {
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				while ((line = br.readLine()) != null) {
					user += line;
				}
				
				if (br != null)
					br.close();
			} catch (Exception e) {
				System.out.println("bufferedreader2----->"+e);
			}
	        
	        //System.out.println("user: "+user);
		} catch (Exception e) {
			System.out.println("userInfoError----->"+e);
		}
		
		ObjectMapper mapper = new ObjectMapper();
		NaverUser nu = mapper.readValue(user, NaverUser.class);
		System.out.println(nu.getResponse());
		
		
		return "login.jsp";
	}

}
