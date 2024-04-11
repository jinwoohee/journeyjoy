package com.jj.dto;

import java.sql.Date;

public class Inquiry {
	private int i_no;
	private int p_no;
	private String u_id;
	private String i_contents;
	private Date i_date;
	
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getI_contents() {
		return i_contents;
	}
	public void setI_contents(String i_contents) {
		this.i_contents = i_contents;
	}
	public Date getI_date() {
		return i_date;
	}
	public void setI_date(Date i_date) {
		this.i_date = i_date;
	}
	public int getI_no() {
		return i_no;
	}
	public void setI_no(int i_no) {
		this.i_no = i_no;
	}
	
}
