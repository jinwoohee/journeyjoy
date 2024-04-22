package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Eatery;
import com.jj.dto.Place;

public class PackagePlaceSelectDB {
	
	static PackagePlaceSelectDB selectDB = new PackagePlaceSelectDB();
	
	public static PackagePlaceSelectDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	/*장소*/
	public List<Place> selectPlace(){
		
		SqlSession ss = sql.openSession();
		List<Place> placeList = ss.selectList("packagePlaceSelect");
		ss.close();
		
		return placeList;	
	}
	
	/*식당*/
	public List<Eatery> selectEatery(){
		
		SqlSession ss = sql.openSession();
		List<Eatery> eatList = ss.selectList("packageEatSelect");
		ss.close();
		
		return eatList;	
		
	}
}
