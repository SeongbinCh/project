package com.care.project.community.board.Service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.care.project.community.board.DTO.BoardDTO;
import com.care.project.community.board.DTO.BoardRepDTO;

public interface BoardService {
	public Map<String, Object> boardList( int num );
	public String writeSave( BoardDTO dto, MultipartFile image_file_name );
	public BoardDTO contentView( int write_no );
	public BoardDTO getContent( int write_no );
	public String modify( BoardDTO dto, MultipartFile file );
	public String delete( int write_no, String fileName );
	
	public List<BoardRepDTO> replyList(int write_group, int page, int size);
	public void addReply( BoardRepDTO dto );
	public int getRepCount(int write_group);
	public void modifyReply( BoardRepDTO dto );
	public void deleteReply( int reply_no );
}