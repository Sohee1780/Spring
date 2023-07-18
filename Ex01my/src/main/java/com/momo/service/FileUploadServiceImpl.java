package com.momo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.momo.mapper.FileUploadMapper;
import com.momo.vo.FileVO;

@Service
public class FileUploadServiceImpl implements FileUploadService{

	@Autowired
	FileUploadMapper fileMapper;
	
	@Override
	public List<FileVO> getList(int bno) {
		// TODO Auto-generated method stub
		return fileMapper.getList(bno);
	}

	@Override
	public int insertFile(FileVO file) {
		// TODO Auto-generated method stub
		return fileMapper.insertFile(file);
	}

}
