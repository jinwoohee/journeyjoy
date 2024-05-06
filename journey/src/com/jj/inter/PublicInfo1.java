package com.jj.inter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.jj.dao.JourneyInterface;

public class PublicInfo1 implements JourneyInterface {
	static PublicInfo1 pinfo = new PublicInfo1();
	
	public static PublicInfo1 publicInfo1() {
		return pinfo;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse("http://www.worldjob.or.kr/openapi/overseasEmployment.do?gubun=A&item=N&year=2018");		
		System.out.println(document.getElementsByTagName("item"));
		//Element element = document.getDocumentElement();
		//System.out.println(element.getAttribute("name"));
		
		
		return "";
	}
}
