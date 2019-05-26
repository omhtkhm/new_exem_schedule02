package com.exem9.lms.web.schedule.service;

import java.util.List;

import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.schedule.bean.SchBean;

public interface IScheduleService {
	
	public List<SchBean> getsch(String fromYYYYMMDD, String toYYYYMMDD, int pageNo) throws Throwable;
	/*내 일정정보 조회*/
	public List<SchBean> getmysch(String strfromYYYYMMDD, String strtoYYYYMMDD, String currentUserId, int i)  throws Throwable;
	
	/*내 일정정보 조회_모바일용*/
	public List<SchBean> getmysch_m(String strfromYYYYMMDD, String strtoYYYYMMDD, String currentUserId)  throws Throwable;
	
	/*내 일정 등록 insertSchInfo 이벤트*/
	public String insertSchinfo(String user_id,String customer_id, String project_id,
								String dbms_id,String category_id,
								String start_time, String end_time,
								String contents) throws Throwable ;

	/*내일정 리스트 Row 갯수 가져오기(페이지 처리)*/
	public LineBoardBean getNCount(String fromYYYYMMDD, String toYYYYMMDD, int nowPage) throws Throwable;
	public LineBoardBean getmyNCount(String fromYYYYMMDD, String toYYYYMMDD, String userId, int nowPage) throws Throwable;

	/*내 일정 수정 */
	public String updateSchinfo(String user_id,String customer_id, String project_id,
								String dbms_id,String category_id,
								String start_time, String end_time,
								String contents, String chkId) throws Throwable ;
	
	/*금주 계산 유틸리티 */
	public String getThisWeek()throws Throwable;
	
	public String[] weekCalendar(String yyyymmdd)throws Throwable;
	
	public List<SchBean> getTeamsch(String strfromYYYYMMDD, String strtoYYYYMMDD, int pageNo, int teamFilter, int deptFilter) throws Throwable;
	
	public List<SchBean> getTeamsch_m(String strfromYYYYMMDD, String strtoYYYYMMDD, int teamFilter, int deptFilter) throws Throwable;
	
		public LineBoardBean getTeamNCount(String fromYYYYMMDD, String toYYYYMMDD, int nowPage, int teamFilter, int deptFilter) throws Throwable;
	
	/*내 일정 삭제 */
	public String deleteSchinfo(String chkId) throws Throwable ;
	
	public List<SchBean> getmysch_m_edit(String supoId) throws Throwable;

}
