package com.jj.inter;

import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
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
		
		/*첨부파일*/
		String realFolder="";
		String saveFolder="/uploadFile";
		int fileSize=10*1024*1024;
		ServletContext context = request.getServletContext();
		realFolder=context.getRealPath(saveFolder);   		
		MultipartRequest multi=new MultipartRequest(request,realFolder,fileSize,"UTF-8",new DefaultFileRenamePolicy());
		
		
		/* 한글안깨지게 */
		com.jj.dto.Package pk = new com.jj.dto.Package();
		pk.setU_id(multi.getParameter("u_id"));
		pk.setP_nation(multi.getParameter("nation"));
		pk.setP_city(multi.getParameter("city"));
		pk.setP_theme(multi.getParameter("theme"));
		pk.setP_title(multi.getParameter("title"));
		pk.setP_start_date(multi.getParameter("startDt"));
		pk.setP_end_date(multi.getParameter("endDt"));
		pk.setP_volume(Integer.parseInt(multi.getParameter("volumn")));
		pk.setP_due_date(multi.getParameter("dueDt"));
		
		String pay = multi.getParameter("guide");
		String guidePay = pay.replaceAll(",", "");
		pk.setP_guide_pay(Integer.parseInt(guidePay));

		/* 첨부파일 */
		if (multi.getParameter("file") == "") {
			pk.setP_file("img/travel/travel18.jpg");//썸네일 기본이미지 넣기
		} else {
			pk.setP_file(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		}
		pk.setP_notification(multi.getParameter("notice"));
		pk.setP_url("aa"); // 현재페이지 URL > 나중에 뒤에 ?페이지번호 붙이기
		
		HashMap<String, Integer> param = insertDB.insertPackage(pk);
		
		return "package_schedule.jsp?p_no="+param.get("p_no")+"&p_period="+param.get("p_period");
	}
}
