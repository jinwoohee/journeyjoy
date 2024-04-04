package com.jj.inter;

import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.PackageSearchDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package;

public class PackageSearch implements JourneyInterface{
	
	static PackageSearch pSelect = new PackageSearch();
	
	public static PackageSearch packageSearchInter() {
		return pSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		System.out.println("---inter/PackageSearch---");

		HashMap<String, String> param = new HashMap<String, String>();
		//param.put("param1", request.getParameter("param1"));
		param.put("param2", request.getParameter("param2"));
		param.put("param3", request.getParameter("param3"));
		param.put("param4", request.getParameter("param4"));
		param.put("date", request.getParameter("date"));
		param.put("txt", request.getParameter("txt"));
		
		PackageSearchDB searchPackage = PackageSearchDB.select();
		List<Package> pkList = searchPackage.selectPackage(param);
		request.setAttribute("pkList", pkList);

		return "ajax.jsp";
	}
}
