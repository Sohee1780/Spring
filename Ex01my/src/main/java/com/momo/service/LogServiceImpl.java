package com.momo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.momo.mapper.logMapper;
import com.momo.vo.LogVO;

@Service
public class LogServiceImpl implements LogService{

	@Autowired
	logMapper logMapper;
	
	@Override
	public int insert(LogVO vo) {
		// TODO Auto-generated method stub
		return logMapper.insert(vo);
	}

}
