package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Place;

public class SearchPlaceSelectDB {
	static SearchPlaceSelectDB sps_db = new SearchPlaceSelectDB();
	
	public static SearchPlaceSelectDB seldb() {
		return sps_db;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Place> searchmtd(String search_text) {	
		SqlSession sqls = sql.openSession();	
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("text",search_text);
		
		List<Place> plaList = sqls.selectList("search_select",param);
		sqls.close();
		return plaList;
	}
	
}
