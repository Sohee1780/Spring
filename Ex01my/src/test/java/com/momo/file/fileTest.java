package com.momo.file;

import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.momo.mapper.FileUploadMapper;
import com.momo.vo.FileVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class fileTest {
	@Autowired
	FileUploadMapper fileMapper;
	
	@Test
	public void insertTest() {
		log.info("getList****************");
		FileVO file = new FileVO();
		
		file.setBno(121);
		file.setFilename("Filename");
		file.setFiletype("I");
		file.setUploadpath("Uploadpath");
		
		UUID uuid = UUID.randomUUID();
		file.setUuid(uuid.toString());
		
		fileMapper.insertFile(file);
	}
	
	@Test
	public void getList() {
		log.info("getList****************");
		log.info(fileMapper.getList(121));
	}
}
