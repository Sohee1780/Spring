package com.momo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.momo.vo.FileVO;

@Service
public interface FileUploadService {
	public List<FileVO> getList(int bno);
	
	public int insertFile(FileVO file);
}
