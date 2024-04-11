package com.jj.conn;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Class_list;
import static com.jj.db.JdbcUtil.*;

public class ClassListSelectDB {

	public ArrayList<Class_list> selectClass() {
		
		ArrayList<Class_list> classList = null;
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		classList = sql.selectClassList();
		close(con);
		
		return classList;
	}
}
