package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.jj.dao.JourneySql;
import com.jj.dto.Package;
import com.jj.dto.Package_schedule;

public class MypagePackageSelectDB {
	
	public ArrayList<Package> mypagePackageSelectDB(String u_id) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<Package> plist = sql.mypagePackageSelect(u_id); //패키지 상세내용
		System.out.println("MypagePackageSelectDB list----->"+plist.size());
		
		close(con);
		return plist;
	}
}
