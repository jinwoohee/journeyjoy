package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Estimate;
import com.jj.dto.Eatery;;

public class EaterySelectDB {
	static EaterySelectDB eat_sel = new EaterySelectDB();
	
	public static EaterySelectDB seldb() {
		return eat_sel;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Eatery> selectMth(String e_food_taste, String day) {	
		SqlSession sqls = sql.openSession();	
		String [] food_arr = e_food_taste.split("_");
		int day_count = Integer.parseInt(day)*9;
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("eat_food_taste", food_arr);
		param.put("day", day_count);
		
		List<Eatery> eatList = sqls.selectList("eatery_select",param);
		sqls.close();
		return eatList;
	}
}
