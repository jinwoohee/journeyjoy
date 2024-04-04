package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Place;
import com.jj.dto.Schedule;

public class ScheduleInsertDB {
	static ScheduleInsertDB sch_in = new ScheduleInsertDB();
	
	public static ScheduleInsertDB insertdb() {
		return sch_in;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public int insertMtd(int e_no, int sche_day, String places) {	
		Schedule dto = new Schedule();
		
		String place = places.replaceAll("_", ",");
		
		dto.setE_no(e_no);
		dto.setSche_day(sche_day);
		dto.setPlace(place);
		
		SqlSession sqls = sql.openSession();
		
		int i = sqls.insert("schedule_insert",dto);

		sqls.commit();
		sqls.close();
		return i;
	}
	
}
