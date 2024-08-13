package com.care.project.community.board.Mybatis;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.care.project.community.board.DTO.BoardDTO;
import com.care.project.community.board.DTO.BoardRepDTO;

public interface BoardMapper {
	public List<BoardDTO> boardList( @Param("s") int start, @Param("e") int end );
	public int selectBoardCount();
	public int writeSave( BoardDTO dto );
	public BoardDTO getContent( int write_no );
	public int modify( BoardDTO dto );
	public int delete( int write_no );
	public void upHit( int write_no );
	
	public void addReply( BoardRepDTO dto );
	public List<BoardRepDTO> replyList( @Param("write_group") int write_group, 
									@Param("s") int start, @Param("e") int end );
	public int getRepCount( @Param("write_group") int write_group );
	public void modifyReply( BoardRepDTO dto );
	public void deleteReply( int reply_no );
}
