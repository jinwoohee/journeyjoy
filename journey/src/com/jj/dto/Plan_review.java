package com.jj.dto;

import java.sql.Date;
import java.util.Arrays;

public class Plan_review {
	private int pr_no;
	private String u_id;
	private int plan_no;
	private String pl_eat_no;
	private String pr_title;
	private String pr_contents;
	private String pr_file;
	private Date pr_date;
	
	public int getpr_no() {
		return pr_no;
	}
	public void setpr_no(int pr_no) {
		this.pr_no = pr_no;
	}
	public String getu_id() {
		return u_id;
	}
	public void setu_id(String u_id) {
		this.u_id = u_id;
	}
	public int getplan_no() {
		return plan_no;
	}
	public void setplan_no(int plan_no) {
		this.plan_no = plan_no;
	}
	public String getpl_eat_no() {
		return pl_eat_no;
	}
	public void setpl_eat_no(String[] pl_eat_no) {
		String place_no = Arrays.toString(pl_eat_no);
		String pl_no = place_no.replaceAll("\\[", "").replaceAll("\\]", "");
		
		this.pl_eat_no = pl_no;
	}
	public String getpr_title() {
		return pr_title;
	}
	public void setpr_title(String pr_title) {
		this.pr_title = pr_title;
	}
	public String getpr_contents() {
		return pr_contents;
	}
	public void setpr_contents(String pr_contents) {
		this.pr_contents = pr_contents;
	}
	public String getpr_file() {
		return pr_file;
	}
	public void setpr_file(String pr_file) {
		this.pr_file = pr_file;
	}
	public Date getpr_date() {
		return pr_date;
	}
	public void setpr_date(Date pr_date) {
		this.pr_date = pr_date;
	}
}
