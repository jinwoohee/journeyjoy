package com.jj.conn;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Purchase;

public class PurchaseSelectDB {
	
	static PurchaseSelectDB selectDB = new PurchaseSelectDB();
	
	public static PurchaseSelectDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public Purchase selectPur(int p_no){
		
		System.out.println("--- conn/purchaseSelectDB ---");
		
		SqlSession ss = sql.openSession();
		Purchase purchase = ss.selectOne("purchaseSelect", p_no);
		ss.close();
		
		return purchase;
	}

}
