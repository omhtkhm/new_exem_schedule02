package com.exem9.lms.web.position.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



import com.exem9.lms.exception.UserNotFoundException;
import com.exem9.lms.web.position.service.IPosiService;

@Controller
public class PosiController {
	@Autowired
	public IPosiService iPosiService;
	
	@RequestMapping(value = "/Posi")
	public ModelAndView posi(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.setViewName("Posi/Posi");
		}
				
		return modelAndView;
	}
	
}