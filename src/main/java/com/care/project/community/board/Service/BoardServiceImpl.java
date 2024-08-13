package com.care.project.community.board.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.care.project.community.board.DTO.BoardDTO;
import com.care.project.community.board.DTO.BoardRepDTO;
import com.care.project.community.board.Mybatis.BoardMapper;


@Service
@Transactional
public class BoardServiceImpl implements BoardService{
	@Autowired BoardMapper boardmapper;
	@Autowired BoardFileService bfs;
	//게시글 리스트
	public Map<String, Object> boardList( int num ){
		int pageLetter = 10;
		int allCount = boardmapper.selectBoardCount();
		int repeat = allCount / pageLetter;
		
		if( allCount % pageLetter != 0 ) {
			repeat++;
		}
		
		int end = num * pageLetter;
		int start = end + 1 - pageLetter;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("repeat", repeat);
		map.put("list", boardmapper.boardList(start, end));
		
		return map;
	}
	//게시글 작성
	public String writeSave( BoardDTO dto, MultipartFile image_file_name ) {
		if( image_file_name.isEmpty() ) {
			dto.setImageFileName(null);
		} else {
			dto.setImageFileName( bfs.saveFile(image_file_name) );
		}
		
		int result = boardmapper.writeSave( dto );
		
		String msg = "", url = "";
		if( result == 1 ) {
			msg = "작성하였습니다.";
			url = "/project/community/boardList";
		} else {
			msg = "실패하였습니다.";
			url = "/project/community/writeForm";
		}
		
		return bfs.getMessage(msg, url);
	}
	//게시글 상세보기
	public BoardDTO contentView( int write_no ) {
		upHit( write_no );
		return boardmapper.getContent( write_no );
	}
	//조회수
	private void upHit( int write_no ) {
		boardmapper.upHit( write_no );
	}
	//게시글의 내용 가져오기
	public BoardDTO getContent( int write_no ) {
		return boardmapper.getContent( write_no );
	}
	//게시글 수정
	public String modify( BoardDTO dto, MultipartFile file ) {
		String originName = null;
		
		if( !file.isEmpty() ) {
			originName = dto.getImageFileName();
			dto.setImageFileName( bfs.saveFile( file ) );
		}
		
		int result = boardmapper.modify( dto );
		String msg = "", url = "";
		
		if( result == 1 ) {
			msg = "수정하였습니다.";
			url = "/project/community/contentView?write_no=" + dto.getWrite_no();
		} else {
			msg = "실패하였습니다.";
			url = "/project/community/modifyForm?write_no" + dto.getWrite_no();
		}
		return bfs.getMessage(msg, url);
	}
	//게시글 삭제
	public String delete( int write_no, String fileName ) {
		int result = boardmapper.delete( write_no );
		String msg = "", url = "";
		
		if( result == 1 ) {
			bfs.deleteImage( fileName );
			msg = "삭제하였습니다.";
			url = "/project/community/boardList";
		} else {
			msg = "실패하였습니다.";
			url = "/project/community/contentView?write_no" + write_no;
		}
		return bfs.getMessage(msg, url);
	}
	//댓글 작성
	public void addReply( BoardRepDTO dto ) {
		boardmapper.addReply( dto );
	}
	//댓글 리스트
	@Override
    public List<BoardRepDTO> replyList(int write_group, int page, int size) {
		int start = (page - 1) * size + 1;
		int end = page * size;
		
        return boardmapper.replyList(write_group, start, end);
    }
	//댓글 수 가져오기
	@Override
	public int getRepCount(int write_group) {
		return boardmapper.getRepCount(write_group);
	}
	//댓글 수정
	@Override
	public void modifyReply(BoardRepDTO dto) {
		boardmapper.modifyReply( dto );
	}
	//댓글 삭제
	@Override
	public void deleteReply(int reply_no) {
		boardmapper.deleteReply( reply_no );
	}
}
