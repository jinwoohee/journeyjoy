package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;

import com.jj.dao.JourneySql;

public class MypagePlaceReview_placeSelectDB {

	public void mypagePlaceSelectDB(String pl_eat_no) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		
		close(con);
	}
}
