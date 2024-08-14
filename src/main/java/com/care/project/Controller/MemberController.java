package com.care.project.Controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.care.project.DTO.MemberDTO;
import com.care.project.Service.MemberService;
import com.care.project.common.LoginSession;

@Controller
@RequestMapping("member")
public class MemberController {
	@Autowired MemberService ms;
	
	@GetMapping("main")
	public String main() {
		return "main";
	}
	//로그인 페이지
	@GetMapping("login")
	public String login(HttpServletRequest req, HttpSession session) {
			String referer = req.getHeader("Referer");
			System.out.println("referer : " + referer);
			if (referer != null && !referer.contains("/membership") && !referer.contains("/login")) {
	            session.setAttribute("prevPage", referer);
	        }
		return "member/login";
	}
	//로그인 검사 메서드
	@PostMapping("login_chk")
	public String loginChk( @RequestParam String id, @RequestParam String pwd,
			@RequestParam( required = false, defaultValue = "off" ) String autoLogin,
			HttpSession session,
			RedirectAttributes rs,
			HttpServletResponse res) {
		int result = ms.loginChk( id, pwd );
		if( result == 1 ) {
			rs.addFlashAttribute("loginError", "아이디가 존재하지 않습니다.");
			return "redirect:login";
		} else if( result == 2 ) {
			rs.addFlashAttribute("loginError", "비밀번호가 틀립니다.");
			return "redirect:login";
		}

		if(autoLogin.equals("on")) {
			int limitTime = 60*60*24*1;
			Cookie loginCookie = new Cookie("loginCookie", session.getId());
			loginCookie.setPath("/");
			loginCookie.setMaxAge(limitTime);
			res.addCookie(loginCookie);
			
			ms.keepLogin(session.getId(), id);
		}
		session.setAttribute(LoginSession.LOGIN, id);
		
		
	    rs.addAttribute("id", id);
	    rs.addAttribute("autoLogin", autoLogin);
	    
	    return "redirect:successLogin";
	}
	//로그인 성공시 실행할 메서드
	@GetMapping("successLogin")
	public String successLogin( @RequestParam String id, @RequestParam String autoLogin,
								HttpSession session, HttpServletResponse res,
								RedirectAttributes rs) {
		String prevPage = (String) session.getAttribute("prevPage");
		System.out.println("successLogin prevPage : " + prevPage);
		
		rs.addFlashAttribute("loginMsg", "로그인하였습니다");
		
		if (prevPage != null) {
            session.removeAttribute("prevPage");
            return "redirect:" + prevPage;
        }
		return "redirect:main";
	}
	//로그아웃 메서드
	@GetMapping("logout")
	public String logout(HttpSession session,
						@CookieValue(value="loginCookie", required = false) Cookie cookie,
						HttpServletResponse res, HttpServletRequest req,
						RedirectAttributes rs) {
		//이전 페이지 값을 referer에 저장
		String referer = req.getHeader("Referer");
		System.out.println("referer : " + referer);
		
		if( referer != null && !referer.contains("/logout") ) {
			session.setAttribute("prevPage", referer);
		}
		//쿠키 무효화
		if( cookie != null ) {
			cookie.setMaxAge(0);
			res.addCookie(cookie);
			ms.keepLogin("nan", (String)session.getAttribute(LoginSession.LOGIN));
		}
		//세션에 있는 prevPage값을 변수에 저장
		String prevPage = (String)req.getSession().getAttribute("prevPage");
		System.out.println("prevPage : " + prevPage);
		//세션 무효화
		session.invalidate();
		
		rs.addFlashAttribute("logoutMsg", "로그아웃하였습니다");
		
		if( prevPage != null ) {
			return "redirect:" + prevPage;
		}
		return "redirect:main";
	}
	//회원가입 폼
	@GetMapping("membership")
	public String membership() {
		return "member/membership";
	}
	//회원가입 메서드
	@RequestMapping("register")
	public String register(MemberDTO dto) {
		System.out.println("--------dto---------");
		System.out.println(dto.getId());
		System.out.println(dto.getPwd());
		System.out.println(dto.getAddr1());
		System.out.println(dto.getAddr2());
		System.out.println(dto.getAddr3());
		int result = ms.register( dto );
		if( result == 1 ) {
			return "redirect:login";
		}
		return "redirect:main";
	}
}
