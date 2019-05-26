package com.exem9.lms.web.maintenance.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.PlatformTransactionManager;

import com.exem9.lms.common.CommonProperties;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.common.dao.ICommonDao;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.dao.ICustomerDao;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.dbms.dao.IDbmsDao;
import com.exem9.lms.web.maintenance.bean.MatBean;
import com.exem9.lms.web.maintenance.dao.IMatDao;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.dao.IMemberDao;
import com.exem9.lms.web.team.bean.TeamBean;
import com.exem9.lms.web.team.dao.ITeamDao;



@RemoteProxy(name="IMatService")
@Service(value="IMatService")
public class MatService implements IMatService{
	
	@Autowired
	public IMatDao iMatDao;
	
	@Autowired
	public ICommonDao iCommonDao;
	
	@Autowired
	public IMemberDao iMemberDao;
	
	@Autowired
	public ICustomerDao iCustomerDao;
	
	@Autowired
	public ITeamDao iTeamDao;
	
	@Autowired
	public IDbmsDao iDbmsDao;
	
	@Autowired
	private PlatformTransactionManager transactionManager;
	
	public List<SupoBean> getSupolevel() throws Throwable {
		// TODO Auto-generated method stub
		return iCommonDao.getSupolevel();
	}

	public List<SupoBean> getSupovisit(String supoId) throws Throwable {
		
		HashMap params = new HashMap();
		
		if(supoId == ""){
			params.put("supoId",supoId);
		}else{
			params.put("supoId",Integer.parseInt(supoId));
		}
		
		return iCommonDao.getSupovisit(params);
	}
/*	public List getdbms() throws Throwable {
		
		// TODO Auto-generated method stub
		return iDbmsDao.getdbms();
	}*/

	public List<MemberBean> getTeammember(int deptId, int teamId, String user1Id)
			throws Throwable {
		
		HashMap params = new HashMap();
		if(deptId == 0){
			params.put("deptId","");
		}else{
			params.put("deptId",deptId);
		}
		
		if(teamId == 0){
			params.put("teamId","");
		}else{
			params.put("teamId",teamId);
		}
		
		params.put("user1Id",user1Id);
		
		return iMemberDao.getTeammember(params);
	}
/*	public List<TeamBean> getuserteam(String userDept) throws Throwable {
		// TODO Auto-generated method stub
		HashMap params = new HashMap();
		params.put("userDept",userDept);
		
		
		return iTeamDao.getuserteam(params);
	}*/
	
	//고객사 정보 등록시 담당부서에 해당 하는 팀정보 가져오기
	public List<TeamBean> getdeptteam(String deptId) throws Throwable {
		// TODO Auto-generated method stub
		HashMap params = new HashMap();
		params.put("deptId",Integer.parseInt(deptId));
		
		
		return iTeamDao.getdeptteam(params);
	}
	
	public List<DbmsBean> getdbms() throws Throwable {
		// TODO Auto-generated method stub
		return iDbmsDao.getdbms();
	}

	public String insertMatinfo(String cusNm, String proNm, String dbmsId,
			String dbmsVersion, String cusUserId, String salesmanId,
			String user1Id, String user2Id, String supoLeverId,
			String supoVisitId, String supoinstallData, String supostateDate,
			String supoendDatae, String etc) throws Throwable {

		String result = "FAILED";
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
				
		HashMap params = new HashMap();
		params.put("cusNm",cusNm);
		params.put("proNm",proNm);
		params.put("dbmsId",Integer.parseInt(dbmsId));
		params.put("dbmsVersion",dbmsVersion);
		params.put("cusUserId",Integer.parseInt(cusUserId));
		params.put("salesmanId",salesmanId);
		params.put("user1Id",user1Id);
	/*	if(user2Id.equals("0")){
			user2Id = null;
		}*/
		params.put("user2Id",user2Id);
		params.put("supoLeverId",Integer.parseInt(supoLeverId));
		params.put("supoVisitId",Integer.parseInt(supoVisitId));
		params.put("supoinstallData",supoinstallData);
		params.put("supostateDate",supostateDate);
		params.put("supoendDatae",supoendDatae);
		params.put("etc",etc);
		params.put("userId", (String)session.getAttribute("sUserId"));
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition() );
		
		try{
			iMatDao.insertMatinfo(params);
			
			Integer matId = (Integer) iMatDao.getInsertedMatId(params); // 신규 등록후 고객사ID 값 반환
					
			params.put("matId", matId);

			if(matId != null){
				iMatDao.insertMatCusinfo(params);
			}					
			
			this.transactionManager.commit(status);
			
		} catch(Exception e) {
			
			this.transactionManager.rollback(status);
			e.printStackTrace();
			 //throw new Exception("Transaction2: ");
             //TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
             return result;
		}
		
		result = "SUCCESS";
		return 	result;
	}

	public List<MatBean> getmatinfo(String selectBtnVal, String selectTextVal, int pageNo) throws Throwable {
		
		HashMap params = new HashMap();
		
		params.put("selectBtnVal", Integer.parseInt(selectBtnVal));
		params.put("selectTextVal",selectTextVal);
		params.put("viewCount", CommonProperties.VIEWCOUNT);
		
		int startNo = 1+(CommonProperties.VIEWCOUNT * (pageNo-1));
		int endNo = CommonProperties.VIEWCOUNT * pageNo;
		
		if(pageNo == 1){
			params.put("pageNo", ""); 
		}else{
			params.put("pageNo", pageNo);
		}
		
		params.put("startNo", startNo);
		params.put("endNo", endNo);
		
		return iMatDao.getmatinfo(params);
	}

	public List<MatBean> getmatinfo1(String selectBtnVal, String selectTextVal, int pageNo) throws Throwable {
		
		HashMap params = new HashMap();
		
		params.put("selectBtnVal", Integer.parseInt(selectBtnVal));
		params.put("selectTextVal",selectTextVal);
		params.put("viewCount", CommonProperties.VIEWCOUNT);
		
		int startNo = 1+(CommonProperties.VIEWCOUNT * (pageNo-1));
		int endNo = CommonProperties.VIEWCOUNT * pageNo;
		
		if(pageNo == 1){
			params.put("pageNo", ""); 
		}else{
			params.put("pageNo", pageNo);
		}
		
		params.put("startNo", startNo);
		params.put("endNo", endNo);
		
		return iMatDao.getmatinfo(params);
	}
		
	public LineBoardBean getNCount(String selectBtnVal, String selectTextVal, int nowPage) throws Throwable {
		HashMap params = new HashMap();
		
		params.put("selectBtnVal", Integer.parseInt(selectBtnVal));
		params.put("selectTextVal",selectTextVal);
		
		int nCount = iMatDao.getNCount(params);
		int maxPage=0;
		int startPage=0;
		int endPage=0;
		int nowpage=0;
		
		if(nowPage == 0){
			nowpage = 1;
		}else if(nowPage != 0){
			nowpage = nowPage;
		}		
		
		if(nCount % CommonProperties.VIEWCOUNT == 0){
			maxPage = nCount / CommonProperties.VIEWCOUNT;
		}else{
			maxPage = (nCount / CommonProperties.VIEWCOUNT) + 1;
		}
		
		//startPage = nowpage / CommonProperties.PAGECOUNT + 1;
		startPage = ( (nowpage - 1) / CommonProperties.PAGECOUNT ) * CommonProperties.PAGECOUNT + 1;
		endPage = startPage + CommonProperties.PAGECOUNT -1;
		
		if(endPage > maxPage){
			endPage = maxPage;
		}		
		
		LineBoardBean lbb = new LineBoardBean();
		lbb.setStartPage(startPage);
		lbb.setEndPage(endPage);
		lbb.setMaxPage(maxPage);
		lbb.setNowPage(nowpage);
		return lbb;
	}
	
	// 삭제
	public String deleteMatinfo(String chkId) throws Throwable {
		
		HashMap params = new HashMap();
		params.put("chkId", Integer.parseInt(chkId) );
		
		System.out.println("============================================================== mat delete call : ");
		
		String result = "FAILED";
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition() );
		
		try{			
			String MatDeleteResult = iMatDao.deleteMatCusinfo(params);		
   
			System.out.println(MatDeleteResult);
			 
			if(MatDeleteResult.equals("SUCCESS")){
				iMatDao.deleteMatinfo(params);
			}					
			
			this.transactionManager.commit(status);
			
		} catch(Exception e) {
			
			this.transactionManager.rollback(status);
			e.printStackTrace();
			 //throw new Exception("Transaction2: ");
             //TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
             return result;
		}
		
		result = "SUCCESS";
		return 	result;	
	}
	
	public String updateMatinfo(String custId, String pjtId, String cususerId, String dbmsId, 
			String user1Id, String user2Id,  String salesmanId, String installDay, String contractId, 
			String visitId, String startDay, String endDay, String etc, String chkId) throws Throwable {
	
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
		
		HashMap params = new HashMap();
		
		params.put("custId",Integer.parseInt(custId));
		params.put("pjtId",Integer.parseInt(pjtId));
		params.put("cususerId",Integer.parseInt(cususerId));
		params.put("dbmsId",Integer.parseInt(dbmsId)); 
		params.put("user1Id",user1Id);
		params.put("user2Id",user2Id);
		params.put("salesmanId",salesmanId);
		params.put("installDay",installDay);
		params.put("contractId",Integer.parseInt(contractId));
		params.put("visitId",Integer.parseInt(visitId));
		params.put("startDay",startDay);
		params.put("endDay",endDay);
		params.put("etc",etc);
		params.put("chkId",Integer.parseInt(chkId));
		
		return iMatDao.updateMatinfo(params);
	}

	public List<CustomerMemberBean> getcusmemberinfo(int cusId) throws Throwable {
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
		
		HashMap params = new HashMap();
		
		params.put("cusId",cusId);

		// TODO Auto-generated method stub
		return iCustomerDao.getcusmemberinfo(params);
	}
	

	public List<CustomerMemberBean> getprodbmsmemberinfo(int cusId,int proId,int dbmsId) throws Throwable {
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
		
		HashMap params = new HashMap();
		
		params.put("cusId",cusId);
		params.put("proId",proId);
		params.put("dbmsId",dbmsId);

		// TODO Auto-generated method stub
		return iCustomerDao.getprodbmsmemberinfo(params);
	}

	public List<CustomerMemberBean> getMatCusMemberinfo(String matId)
			throws Throwable {

		HashMap params = new HashMap();
		
		params.put("matId",matId);
		
		return iMatDao.getMatCusMemberinfo(params);
	}

	public String insertMatcusmemberinfo(int cusId, int proId, int dbmsId,
			String cusUserId, String cusUserPhone, String cusUserMail)
			throws Throwable {
		
		HashMap params = new HashMap();
		
		params.put("cusId", cusId);
		params.put("pjtId", proId);
		params.put("dbmsId", dbmsId);
		
		String result = "FAILED";
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition() );
		
		try{
			if(cusUserId != null)
			{				
				params.put("cususerNm", cusUserId);
				params.put("cususerPhone", cusUserPhone);
				params.put("cususerMail", cusUserMail);
				
				iCustomerDao.insertCusmember(params);  
				
				Integer cusmemberId = iCustomerDao.getInsertedCusmemberId(params); // 해당고객사의 기 등록된 담당자 ID값 반환
				params.put("cusmemberId", cusmemberId);
				iCustomerDao.insertPjtDbmsCusmember(params);
				
				this.transactionManager.commit(status);
			}
		}catch(Exception e) {
				
				this.transactionManager.rollback(status);
				e.printStackTrace();
				 //throw new Exception("Transaction2: ");
	             //TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
	             return result;
			}
			
			result = "SUCCESS";
			return 	result;
	}
}
