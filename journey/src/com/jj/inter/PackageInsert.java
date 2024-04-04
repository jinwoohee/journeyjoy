package com.jj.inter;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PackageInsertDB;
import com.jj.dao.JourneyInterface;

public class PackageInsert implements JourneyInterface {

	static PackageInsert pInsert = new PackageInsert();

	public static PackageInsert packageInsertinter() {
		return pInsert;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("--- inter/packageInsert ---");

		PackageInsertDB insertDB = PackageInsertDB.insert();
		
		String title = new String(request.getParameter("title").getBytes("8859_1"),"UTF-8");
		String id = new String(request.getParameter("u_id").getBytes("8859_1"),"UTF-8");
		String notice = new String(request.getParameter("notice").getBytes("8859_1"),"UTF-8");

		com.jj.dto.Package pk = new com.jj.dto.Package();
		pk.setU_id(id);
		pk.setP_nation(request.getParameter("nation"));
		pk.setP_city(request.getParameter("city"));
		pk.setP_theme(request.getParameter("theme"));
		pk.setP_title(title);
		pk.setP_start_date(request.getParameter("startDt"));
		pk.setP_end_date(request.getParameter("endDt"));
		pk.setP_volume(Integer.parseInt(request.getParameter("volumn")));
		pk.setP_due_date(request.getParameter("dueDt"));
		
		String pay = request.getParameter("guide");
		String guidePay = pay.replaceAll(",", "");
		pk.setP_guide_pay(Integer.parseInt(guidePay));

		if (request.getParameter("file").equals("")) { //썸네일이 들어가는 이미지 div로 이름 바꾸기
			pk.setP_file("img/travel/travel18.jpg");
		} else {
			pk.setP_file(request.getParameter("file"));
		}
		pk.setP_notification(notice);
		pk.setP_url(request.getRequestURI()); // 현재페이지 URL > 나중에 뒤에 ?페이지번호 붙이기
		
		HashMap<String, Integer> param = insertDB.insertPackage(pk);
		
		return "package_schedule.jsp?p_no="+param.get("p_no")+"&p_period="+param.get("p_period");
	}
}
