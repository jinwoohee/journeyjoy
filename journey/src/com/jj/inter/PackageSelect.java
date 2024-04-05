package com.jj.inter;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.conn.LikeSelectDB;
import com.jj.conn.PackageSelectDB;
import com.jj.conn.PurchaseSelectDB;
import com.jj.dao.JourneyInterface;
import com.jj.dto.Package_like;
import com.jj.dto.Purchase;
import com.jj.dto.Package;

public class PackageSelect implements JourneyInterface{
	
	static PackageSelect pSelect = new PackageSelect();
	
	public static PackageSelect packageSelectInter() {
		return pSelect;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		/* 패키지 전체 */
		PackageSelectDB selectPackage = PackageSelectDB.select();
		List<Package> pkList = selectPackage.selectPackage();
		request.setAttribute("pkList", pkList);
		
		/* 좋아요 */
		LikeSelectDB selectLike = LikeSelectDB.select();
		List<Package_like> likeList = selectLike.selectLike();
		request.setAttribute("likeList", likeList);
		
		return "package_list.jsp";
	}
}
