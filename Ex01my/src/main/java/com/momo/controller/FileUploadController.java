package com.momo.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.momo.service.FileUploadService;
import com.momo.vo.FileVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@Log4j
public class FileUploadController {
	
	@Autowired
	FileUploadService service;
	
	@GetMapping("/file/fileupload")
	public void fileupload() {
		
	}
	
	private static final String ATTACHES_DIR = "c:\\upload\\";
	
	/**
	 * 전달된 타입이 없는경우
	 *  enctype="multipart/form-data" 오타
	 *  설정이 안되었을때 
	 *  	라이브러리추가
	 *  	bean객체 생성
	 * @param files
	 * @return
	 */
	@PostMapping("/file/fileuploadAction")
	public String fileAction(List<MultipartFile> files, int bno, RedirectAttributes rttr) {
		log.info("fileupload");
		
		// 인서트 결과를 담을 변수
		int insertRes = 0;
		
//		files.forEach(file -> {
//			log.info("oFileName : "+file.getOriginalFilename());
//			log.info("name : "+file.getName());
//			log.info("size : "+file.getSize());
//		});
		for(MultipartFile file : files) {

			// 선택된 파일이 없는 경우 다음파일로 이동
			if(file.isEmpty()) {
				continue;
			}
			
			log.info("oFileName : "+file.getOriginalFilename());
			log.info("name : "+file.getName());
			log.info("size : "+file.getSize());
			
			try {
				// UUID
				/*
				 * 소프트웨어 구축에 쓰이는 식별자 표준
				 * 파일이름이 중복되어 파일이 소실되지 않도록 uuid를 붙여서 저장
				 */
				UUID uuid = UUID.randomUUID();
				String saveFileName=uuid+"_"+file.getOriginalFilename();
				
				String uploadpath = getFolder();
				
				// dir경로
				// c:/upload/2023/7
				// 			/년/월/일
				//									경로반환(2023/07/18/)
				File sFile = new File(ATTACHES_DIR+uploadpath+saveFileName);
				// file(원본파일)을 sFile(저장할 대상 파일)에 저장
				file.transferTo(sFile);
				
				FileVO vo = new FileVO();
				
				// 주어진 파일의 Mime유형을 확인
				String contentType = Files.probeContentType(sFile.toPath());
				
				// Mime타입을 확인하여 이미지인 경우 썸네일을 생성
				if(contentType != null && contentType.startsWith("image")) {
					// 썸네일 생성
					vo.setFiletype("I");
					// 썸네일생성
					// 원본파일, 크기, 저장될 경로
					String thmbnail = ATTACHES_DIR+uploadpath+"s_"+saveFileName;
					Thumbnails.of(sFile).size(100, 100).toFile(thmbnail);
				} else {
					vo.setFiletype("F");
				}
				
				vo.setBno(bno);
				vo.setFilename(file.getOriginalFilename());
				vo.setFiletype("I");
				vo.setUploadpath(uploadpath);
				vo.setUuid(uuid.toString());
				log.info("*****************************************");
				log.info(vo);
				log.info(file.getOriginalFilename());
				
				int res = service.insertFile(vo);
				
				if(res>0) {
					insertRes++;
				}
			} catch (IllegalStateException e) {
				
				e.printStackTrace();
			} catch (IOException e) {
				
				e.printStackTrace();
			}
		}
		
		String msg = insertRes+"건 저장 되었습니다.";
		rttr.addAttribute("msg", msg);
		
		return "redirect:/file/fileupload";
	}
	
	@GetMapping("/file/list/{bno}")
	public @ResponseBody Map<String, Object> fileuploadList(@PathVariable("bno") int bno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", service.getList(bno));
		
		log.info("***********************");
		log.info(map);
		log.info("***********************");
		
		
		return map;
	}
	
	// 중복 방지용
	// 업로드 날짜를 폴더 이름으로 사용(파일관리에도 유용)
	// 2023/07/18
	public String getFolder() {
		LocalDate currentDate = LocalDate.now();
		log.info("currentDate : "+currentDate);
		log.info("경로 : "+currentDate.toString().replace("-", File.separator));
		
		String uploadPath = currentDate.toString().replace("-", File.separator)+File.separator;
		
		// 폴더가 없으면 폴더를 생성
		File saveDir = new File(ATTACHES_DIR+uploadPath);
		if(!saveDir.exists()) {
			if(saveDir.mkdirs()) {
				log.info("폴더생성!");
			}else {
				log.info("폴더생성 실패");
			}
		}
		
		
		return uploadPath;
	}
}
