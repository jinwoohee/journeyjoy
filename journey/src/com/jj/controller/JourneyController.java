package com.jj.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.dao.JourneyInterface;
import com.jj.inter.ClassInsert;
import com.jj.inter.ClassListSelect;
import com.jj.inter.CommInsert;
import com.jj.inter.EaterySelect;
import com.jj.inter.EstimateInsert;
import com.jj.inter.EstimateSelect;
import com.jj.inter.LikeDelete;
import com.jj.inter.LikeInsert;
import com.jj.inter.PackageDetail;
import com.jj.inter.PackageInsert;
import com.jj.inter.PackageSearch;
import com.jj.inter.PackageSelect;
import com.jj.inter.PlaceReviewSearch;
import com.jj.inter.PlanDelete;
import com.jj.inter.PlanInsert;
import com.jj.inter.PlanSelect;
import com.jj.inter.PsInsert;
import com.jj.inter.PurchaseDelete;
import com.jj.inter.PurchaseInsert;
import com.jj.inter.RewardInsert;
import com.jj.inter.ScheduleInsert;
import com.jj.inter.SearchPlaceSelect;
import com.jj.inter.WhClear;
import com.jj.inter.WhSearch;
import com.jj.inter.WhSelect;
import com.jj.inter.WhlistSelect;

public class JourneyController extends HttpServlet {
	public void	service(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		JourneyInterface ji;
		
		if (page.equals("wh")) { //워홀 전체 select
			ji = WhSelect.whselect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("whlist")) { //워홀 1개만 select
			ji = WhlistSelect.whlistselect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("whsearch")) { //검색창 조건에 따른 select
			ji = WhSearch.whsearch();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("whclear")) {
			ji = WhClear.whclear();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//진수님 부분
		else if(page.equals("insert")) {
			ji = EstimateInsert.insertEstimate();
			try {
				System.out.println("0번");
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
			}
			
		}else if(page.equals("plan")) {
			ji = EaterySelect.select_eat();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}else if(page.equals("place_search")) {
			ji = SearchPlaceSelect.search_place();			
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}else if(page.equals("schedule_insert")) { 
			ji = ScheduleInsert.insertSchedule();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}else if(page.equals("select")) {
			ji = EstimateSelect.selectEstimate();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}else if(page.equals("save_plan")) {
			ji = PlanInsert.insertPlan();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }save_plan
			}
		}else if(page.equals("plan_select")) {
			ji = PlanSelect.selectPlan();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}else if(page.equals("plan_delete")) {
			System.out.println("딜리트들어옴");
			ji = PlanDelete.deletePlan();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}
		
		
		//윤영 부분
		else if(page.equals("packageInsert")) { //패키지 insert
			ji = PackageInsert.packageInsertinter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 패키지 insert ---" + e);
			}
		}else if(page.equals("packageSelect")) { //패키지 리스트 select
			ji = PackageSelect.packageSelectInter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 패키지 select ---" + e);
			}
			
		}else if(page.equals("packageSearch")) { //패키지 검색 select
			ji = PackageSearch.packageSearchInter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 패키지 검색 ---" + e);
			}
		}else if(page.equals("package_scheduleInsert")) { //일정 insert
			ji = PsInsert.scheduleInsertinter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				response.sendRedirect(result);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 일정 insert ---" + e);
			}
			
		}else if(page.equals("rewardInsert")) { //금액 insert
			ji = RewardInsert.rewardInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 리워드 insert ---" + e);
			}
			
		}else if(page.equals("package_detail")) { //패키지 상세보기
			ji = PackageDetail.packageDetailInter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 패키지 상세보기 ---" + e);
			}
			
		}else if(page.equals("like_insert")) { //찜하기
			ji = LikeInsert.likeInsertinter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / like insert ---" + e);
			}
			
		}else if(page.equals("like_delete")) { //찜하기해제
			ji = LikeDelete.likeDeleteinter();
			String result; 
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / like delete ---" + e);
			}
			
		}else if(page.equals("purchase")) {//구매하기
			ji = PurchaseInsert.purchaseInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 구매하기 ---" + e);
			}
			
		}else if(page.equals("purchase_delete")) { //구매취소
			ji = PurchaseDelete.pDeleteinter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 구매취소 ---" + e);
			}
		}else if(page.equals("commInsert")) {
			ji = CommInsert.commentInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 댓글 insert ---" + e);
			}
		}else if(page.equals("inquiryInsert")) {//문의하기
			
		}else if(page.equals("placeReviewSearch")) {//장소리뷰 검색
			ji = PlaceReviewSearch.placeReviewSearchInter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 장소리뷰검색 ---" + e);
			}
		}else if(page.equals("classInsert")) {//모임 등록하기
			ji = ClassInsert.classInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 모임 insert ---" + e);
			}
		}else if (page.equals("clist")) { //모임 select
			ji = ClassListSelect.classlistselect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			System.out.println("--- controller else ---");
		}
	}
}
