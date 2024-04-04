package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Class_list;

public class ClassListSelectDB {
	static ClassListSelectDB clistdb = new ClassListSelectDB();
	
	public static ClassListSelectDB classlistselectdb() {
		return clistdb;
		
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Class_list> select() {
		SqlSession ss = sql.openSession();
		List<Class_list> clist = ss.selectList("cs_select");
		
		ss.close();
		return clist;
	}
}
