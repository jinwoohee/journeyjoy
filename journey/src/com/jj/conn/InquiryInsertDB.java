package com.jj.conn;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Inquiry;

public class InquiryInsertDB {
	static InquiryInsertDB qInsertDB = new InquiryInsertDB();
	
	public static InquiryInsertDB inquiryInsertDB() {
		return qInsertDB;
	}

	SqlSessionFactory sql = SqlMapconfig.getSqlSession();

	public int inquiryInsertDB(String i_contents, int p_no, String u_id) {
		SqlSession ss = sql.openSession();
		
		Inquiry dto = new Inquiry();
		dto.setP_no(p_no);
		dto.setU_id(u_id);
		dto.setI_contents(i_contents);
		//System.out.println("InquiryInsertDB----->"+dto.getP_no()+"/"+dto.getU_id()+"/"+dto.getI_contents());
		
		int row = ss.insert("inquiry_insert", dto);
		System.out.println("inquiry_insert------->"+row);
		
		ss.commit();
		ss.close();
		
		return row;
	}
}
