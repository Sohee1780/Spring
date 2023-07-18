package com.momo.mapper;

import java.util.List;

import com.momo.vo.FileVO;

public interface FileUploadMapper {
	/**
	 * 하나의 게시물에 대해 업로드된 파일 목록을 조회
	 * @param bno
	 * @return
	 */
	public List<FileVO> getList(int bno);
	
	public int insertFile(FileVO file);
}
