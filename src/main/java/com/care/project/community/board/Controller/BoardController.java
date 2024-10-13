package com.care.project.community.board.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.care.project.community.board.DTO.BoardDTO;
import com.care.project.community.board.Service.BoardFileService;
import com.care.project.community.board.Service.BoardService;

@Controller
@RequestMapping("community")
public class BoardController {
	@Autowired BoardService bs;
	//게시판 리스트
	@GetMapping("boardList")
	public String boardList(Model model,
			@RequestParam( required = false, defaultValue = "1") int num) {
		Map<String, Object> map = bs.boardList(num);
		int currentPage = num;
		int totalPages = (int)map.get("repeat");
		
		if(totalPages <= 0) {
			totalPages = 1;
		}
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("repeat", totalPages);
		model.addAttribute("currentPage", currentPage);
		
		return "Community_board/boardList";
	}
	//게시글 작성 페이지
	@GetMapping("writeForm")
	public String writeForm() {
		return "Community_board/writeForm";
	}
	//게시글 작성 메서드
	@PostMapping("writeSave")
	public void writeSave(BoardDTO dto, 
			@RequestParam(required = false) MultipartFile image_file_name,
			HttpServletResponse res) throws IOException {
	    if (dto == null) {
	        res.sendError(HttpServletResponse.SC_BAD_REQUEST, "BoardDTO is null");
	        return;
	    }
	    if (image_file_name == null) {
	        res.sendError(HttpServletResponse.SC_BAD_REQUEST, "image_file_name is null");
	        return;
	    }

		String msg = bs.writeSave( dto, image_file_name );
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print( msg );
	}
	//게시글 상세보기 페이지
	@GetMapping("contentView")
	public String contentView(@RequestParam int write_no, Model model) {
		model.addAttribute("dto", bs.contentView( write_no ));
		return "Community_board/contentView";
	}
	//게시글 내 이미지 파일 다운로드
	@GetMapping("download")
	public void download(@RequestParam String name,
						HttpServletResponse res) throws Exception{
		res.addHeader("Content-disposition", "attachment; fileName=" + name);
		File file = new File(BoardFileService.IMAGE_REPO + "/" + name);
		FileInputStream in = new FileInputStream(file);
		FileCopyUtils.copy(in, res.getOutputStream());
		in.close();
	}
	//게시글 수정 페이지
	@GetMapping("modifyForm")
	public String modifyForm(@RequestParam int write_no,
							Model model) {
		model.addAttribute("content", bs.getContent( write_no ));
		
		return "Community_board/modifyForm";
	}
	//게시글 수정 메서드
	@PostMapping("modify")
	public void modify(BoardDTO dto,
						@RequestParam MultipartFile file,
						HttpServletResponse res) throws Exception {
		String msg = bs.modify( dto, file );
		res.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = res.getWriter();
		out.print( msg );
	}
	//게시글 삭제 메서드
	@GetMapping("delete")
	public void delete(@RequestParam int write_no,
						@RequestParam String fileName,
						HttpServletResponse res) throws Exception{
		String msg = bs.delete( write_no, fileName );
		res.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = res.getWriter();
		out.print( msg );
	}
}