package com.care.project.mypage.Controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.care.project.DTO.MemberDTO;
import com.care.project.common.LoginSession;
import com.care.project.mypage.Service.MypageService;


@Controller
@RequestMapping("mypage")
public class MypageController {
	@Autowired MypageService ms;
	//메인
	@GetMapping("")
	public String mypage(Model model, HttpSession session) {
		String userId = (String) session.getAttribute(LoginSession.LOGIN);
		model.addAttribute("content", ms.getContent(userId));
		return "mypage/mypage";
	}
	//마이페이지 수정 페이지
	@GetMapping("modifyForm")
	public String modifyForm(@RequestParam String id, Model model) {
		model.addAttribute("content", ms.getContent(id));
		return "mypage/modifyForm";
	}
	//수정
	@PostMapping("modify")
	public void modify(MemberDTO dto,
						HttpServletResponse res) throws Exception{
		String msg = ms.modify( dto );
		res.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = res.getWriter();
		out.print( msg );
	}	
}
