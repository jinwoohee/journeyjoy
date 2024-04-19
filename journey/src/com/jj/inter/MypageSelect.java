package com.jj.inter;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.MypagePackageScheSelectDB;
import com.jj.conn.MypagePackageSelectDB;
import com.jj.conn.MypagePsPlaceSelectDB;
import com.jj.conn.MypagePurchaseSelectDB;
import com.jj.conn.MypageRewardSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package;
import com.jj.dto.Package_schedule;
import com.jj.dto.Purchase;

public class MypageSelect implements JourneyInterface {
	static MypageSelect mSelect = new MypageSelect();
	
	public static MypageSelect mypageSelect() {
		return mSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String u_id = request.getParameter("u_id");
		String tab = request.getParameter("tab"); //마이페이지 메뉴바
		
		/* 패키지(기획내역) */
		MypagePackageSelectDB mSelectDB = new MypagePackageSelectDB(); //패키지 상세내용
		ArrayList<Package> plist = mSelectDB.mypagePackageSelectDB(u_id);
		
		String no = "";
		for (Package pk : plist) {
			no += pk.getP_no() + "/";
		}
		
		MypagePackageScheSelectDB msSelectDB = new MypagePackageScheSelectDB(); //패키지 일정
		ArrayList<Package_schedule> pslist;
		HashMap<String, ArrayList<Package_schedule>> map = new HashMap<String, ArrayList<Package_schedule>>();
		
		MypageRewardSelectDB mrSelectDB = new MypageRewardSelectDB(); //패키지 리워드
		ArrayList<Package> rlist;
		HashMap<String, ArrayList<Package>> map2 = new HashMap<String, ArrayList<Package>>();
		
		MypagePsPlaceSelectDB mppSelectDB = new MypagePsPlaceSelectDB(); //패키지 장소
		ArrayList<Package_schedule> pclist;
		HashMap<String, ArrayList<Package_schedule>> map3 = new HashMap<String, ArrayList<Package_schedule>>();
		
		String[] p_no = no.split("/");
		for (String s : p_no) {
			pslist = msSelectDB.mypagePackageScheSelectDB(s);
			map.put(s, pslist);
			
			pclist = mppSelectDB.mypagePsPlaceSelect(pslist);
			map3.put(s, pclist);
			
			rlist = mrSelectDB.mypageRewardSelectDB(s);
			map2.put(s, rlist);
		}
		
		//System.out.println("MypageSelect-------->" + plist + " / " + map + " / " + map2);
		
		request.setAttribute("package", plist);
		request.setAttribute("packagesche", map);
		request.setAttribute("reward", map2);
		request.setAttribute("place", map3);
		
		/* 패키지(참여내역) */
		MypagePurchaseSelectDB mpSelectDB = new MypagePurchaseSelectDB();
		ArrayList<Purchase> pchlist = mpSelectDB.mypagePurchaseSelect(u_id);
		
		String num = "";
		for (Purchase p : pchlist) {
			num += p.getP_no() + "/";
		}
		
		p_no = num.split("/");
		for (String s : p_no) {
			mSelectDB.mypagePackageSelectDB2(s);
		}
		
		
		
		
		
		
		
		return "mypage.jsp?tab="+tab;
	}
}
