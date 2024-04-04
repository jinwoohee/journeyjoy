package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Package_like;
import com.jj.dto.Package;
public class LikeSelectDB {
	
	static LikeSelectDB selectDB = new LikeSelectDB();
	
	public static LikeSelectDB select() {
		return selectDB;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Package_like> selectLike(){
		System.out.println("--- conn/likeListSelectDB ---");
		
		SqlSession ss = sql.openSession();
		List<Package_like> likeList = ss.selectList("likeSelect");
		ss.close();
		
		return likeList;
	}
	
	public Package_like selectDetailLike(int p_no) {
		System.out.println("--- conn/likeSelectDB ---");
		
		SqlSession ss = sql.openSession();
		Package_like like = ss.selectOne("likeSelectDetail", p_no);
		ss.close();
		
		return like;	
	}

}
