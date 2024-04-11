package com.jj.conn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Ticket;

public class TicketSelectDB {
	static TicketSelectDB tick_sel = new TicketSelectDB();
	
	public static TicketSelectDB seldb() {
		return tick_sel;
	}
	
	SqlSessionFactory sql = SqlMapconfig.getSqlSession();
	
	public List<Ticket> selectMth(String thema) {
		String [] ticket = thema.split("_");
		
		SqlSession sqls = sql.openSession();	
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("tick_sort", ticket);
		
		List<Ticket> tickList = sqls.selectList("ticket_select",param);
		System.out.println("티켓결과"+tickList.size());
		sqls.close();
		return tickList ;
	}
}