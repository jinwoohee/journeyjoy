package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.jj.conn.InquiryNoticeDB;
import com.jj.conn.InquiryUpdateFlagDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Inquiry;

public class InquiryFlag implements JourneyInterface {
	static InquiryFlag iFlag = new InquiryFlag();
	
	public static InquiryFlag inquiryFlag() {
		return iFlag;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		int flag = 0;
		
		InquiryNoticeDB iNoticeDB = new InquiryNoticeDB();
		ArrayList<Inquiry> inquiry_list = iNoticeDB.inquirySelect(u_id);
		
		for (Inquiry iq : inquiry_list) {
			System.out.println("flag----->"+iq.getI_flag());
			if (iq.getI_flag() == 0) { //새로운 알림이 있으면
				flag++;
			}
		}
		
		if (flag > 0) {
			InquiryUpdateFlagDB iuFlagDB = new InquiryUpdateFlagDB();
			iuFlagDB.inquiryUpdateFlag(u_id);
		}
		
		request.setAttribute("flag", flag);
		
		
		return "mflag.jsp";
	}
}
