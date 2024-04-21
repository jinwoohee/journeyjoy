package com.jj.conn;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;

public class PackageInsertDB {
	
	static PackageInsertDB insertDB = new PackageInsertDB();
	
	public static PackageInsertDB insert() {
		return insertDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public HashMap<String, Integer> insertPackage(com.jj.dto.Package pk) {
		HashMap<String, Integer> param = new HashMap<String, Integer>();
		
		System.out.println("--- conn/packageInsertDB ---");
		SqlSession ss = sql.openSession();
		int result = ss.insert("packageInsert",pk);
		
		ss.commit();
		ss.close();
		
		param.put("p_no", pk.getP_no());
		param.put("p_period", pk.getP_period());
		param.put("p_city", Integer.parseInt(pk.getP_city()));
		
		return param;
	}
}
