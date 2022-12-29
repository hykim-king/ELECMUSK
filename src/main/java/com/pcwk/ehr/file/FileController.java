package com.pcwk.ehr.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.file.domain.FileVO;

import net.coobird.thumbnailator.Thumbnailator;

@Controller("FileController")
@RequestMapping("file")
public class FileController {
	
	final String FILE_PATH = "c:\\upload"; //일반 파일
																								//resources/upload/2022/12/20221208a5227265b63e42ef983bd2a71b369dd1.png
	final String IMG_PATH  = "C:\\Users\\ITSC\\git\\ELECMUSK\\src\\main\\webapp\\resources\\upload"; //이미지 파일
	
	String IMG_VIEW_PATH = "/resources/upload";
	
	final Logger LOG = LogManager.getLogger(getClass());
	String addYYYYMMPath = "";
	
	@Resource(name = "downloadView")
	View download;
	
	public FileController() {
		//init();
	}
	
	/**
	 * 파일 다운로드
	 * @param fileVO
	 * @param modelAndView
	 * @return
	 */
	@RequestMapping(value = "/download.do", method = RequestMethod.POST)
	public ModelAndView download(FileVO fileVO , ModelAndView modelAndView) {
	   LOG.debug("┌──────────────────────────────┐");
	   LOG.debug("│download() = ");
	   LOG.debug("│fileVO() = "+fileVO);
	   LOG.debug("└──────────────────────────────┘");
	   
	   //원본 파일명
	   //File객체
	   File downloadFile = new File(fileVO.getSavePath(),fileVO.getSaveFileName());
	   
	   //view 지정 : com.pcwk.ehr.file.DownloadView
	   modelAndView.setView(download);
	   
	   //원본 파일명
	   modelAndView.addObject("orgFileNm", fileVO.getOrgFileName());
	   
	   //파일 객체
	   modelAndView.addObject("downloadFile", downloadFile);
	   
	   return modelAndView;
	}

	
	public void init() {
	   String yyyyFolder = StringUtil.getCurrentDate("yyyy");
	   //LOG.debug("│yyyyFolder = "+yyyyFolder);
	   String mmFolder = StringUtil.getCurrentDate("MM");
	   //LOG.debug("│mmFolder = "+mmFolder);
	   
	   //LOG.debug("│File.separator = "+File.separator);
	   
	   // \2022\12
	   addYYYYMMPath = File.separator+yyyyFolder+File.separator+mmFolder;
	   LOG.debug("│addYYYYMMPath = "+addYYYYMMPath);
	   
	   //IMG_VIEW_PATH = IMG_VIEW_PATH+"/"+yyyyFolder+"/"+mmFolder;
	   
	   //일반 파일
	   File nomalFileDir = new File(FILE_PATH+addYYYYMMPath);
	   if(nomalFileDir.isDirectory() == false) {
	      boolean isNormalMake = nomalFileDir.mkdirs();
	      LOG.debug("┌──────────────────────────────┐");
	      LOG.debug("│isNormalMake = "+isNormalMake);
	      
	   }
	   //이미지 파일
	   File imgeFileDir = new File(IMG_PATH+addYYYYMMPath);
	   if(imgeFileDir.isDirectory() == false) {
	      boolean isNormalMake = imgeFileDir.mkdirs();
	      LOG.debug("│isNormalMake = "+isNormalMake);
	   }
	   
	   
	   LOG.debug("└──────────────────────────────┘");
	}
	
	@RequestMapping(value = "/ajaxUpload.do",method = RequestMethod.POST
	      ,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String ajaxUpload(MultipartHttpServletRequest mReg, HttpServletRequest req)throws IOException{
	   String jsonString = "";
	   
	   init();
	   
	   List<FileVO> list = new ArrayList<FileVO>();
	   
	   Iterator<String> fileNames = mReg.getFileNames();
	   
	   while(fileNames.hasNext()) {
	      String upfileName = fileNames.next();
	      LOG.debug("│upfileName = "+upfileName);
	      
	      FileVO outVO = new FileVO();
	      
	      MultipartFile multipartFile = mReg.getFile(upfileName);
	      //원본파일명
	      outVO.setOrgFileName(multipartFile.getOriginalFilename());
	      
	      if(null == outVO.getOrgFileName() || "".equals(outVO.getOrgFileName())) {
	         continue;
	      }
	      
	      String ext = "";
	      if(outVO.getOrgFileName().indexOf(".")>-1) {
	         int idx = outVO.getOrgFileName().lastIndexOf(".");
	         ext = outVO.getOrgFileName().substring(idx+1);
	      }
	      
	      //확장자
	      outVO.setExt(ext);
	      
	      //파일 사이즈
	      outVO.setFileSize(multipartFile.getSize());
	      
	      //저장경로
	      String savePath = "";
	      String savePathThumnail = "";
	      if("png".equalsIgnoreCase(ext)||
	         "jpeg".equalsIgnoreCase(ext)||
	         "jpg".equalsIgnoreCase(ext)||
	         "gif".equalsIgnoreCase(ext)
	            ) {
	         savePath = this.IMG_PATH+addYYYYMMPath;
	         
		  	   String yyyyFolder = StringUtil.getCurrentDate("yyyy");
			   String mmFolder = StringUtil.getCurrentDate("MM");
	         //Tomact 실제경로
	         String tomcatRealPath =  req.getServletContext().getRealPath(IMG_VIEW_PATH+"/"+yyyyFolder+"/"+mmFolder);
	         savePath = tomcatRealPath;
	         
	         LOG.debug("│tomcatRealPath: "+tomcatRealPath);
	         LOG.debug("│savePathThumnail: "+savePathThumnail);
	         outVO.setImageViewPath(this.IMG_VIEW_PATH+"/"+yyyyFolder+"/"+mmFolder);
	         LOG.debug("│getImageViewPath: "+outVO.getImageViewPath());
	         
	      }else {
	         savePath = this.FILE_PATH+addYYYYMMPath;
	      }
	      LOG.debug("│savePath: "+savePath);
	      
	      outVO.setSavePath(savePath);
	      
	      //저장 파일명
	      String saveFileName = StringUtil.getPK()+"."+ext;
	      outVO.setSaveFileName(saveFileName);
	      
	      LOG.debug("│outVO: "+outVO);
	      
	      File saveFileObj = new File(outVO.getSavePath(), outVO.getSaveFileName());
	
	      multipartFile.transferTo(saveFileObj);
	      
	      list.add(outVO);
	      String originalFile = "";
	      String toCopyFile = "";
	      originalFile = savePath+"\\"+outVO.getSaveFileName();
	      toCopyFile = IMG_PATH+addYYYYMMPath+"\\"+outVO.getSaveFileName();
	      LOG.debug("│originalFile: " + originalFile );
	      LOG.debug("│toCopyFile: " + toCopyFile );
	      LOG.debug("│copy: " + commonCopy(originalFile, toCopyFile) );
	   }
	   
	   jsonString = new Gson().toJson(list);
	   LOG.debug("│jsonString: "+jsonString);
	   
	   return jsonString;
	}
	
	/**
	 * 파일이 image인지 판단
	 * @param file
	 * @return true/false
	 */
	private boolean isImageFile(File file) {
	   try {
	      String contentType = Files.probeContentType(file.toPath());
	      LOG.debug("│contentType: "+contentType);
	      return contentType.startsWith("image");
	   } catch (IOException e) {
	      e.printStackTrace();
	   }
	   return false;
	}
	
	/**
	 * 파일 업로드
	 * method = RequestMethod.POST (파일업로드는 무조건 POST)
	 * @param modelAndView
	 * @param mReg
	 * @return modelAndView
	 * @throws IOException
	 */
	@RequestMapping( value = "/upload.do", method = RequestMethod.POST
		      ,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ModelAndView upload(ModelAndView modelAndView, MultipartHttpServletRequest mReg) throws IOException {
		LOG.debug("┌──────────────────────────────");
		LOG.debug("│=upload=");
		init();
		
		List<FileVO> list = new ArrayList<FileVO>();
		
		Iterator<String> fileNames = mReg.getFileNames();
		
		while(fileNames.hasNext()) {
			String upfileName = fileNames.next();
			LOG.debug("│=upfileName=: "+upfileName);
			
			FileVO outVO = new FileVO();
			
			MultipartFile multipartFile = mReg.getFile(upfileName);
			
			outVO.setOrgFileName(multipartFile.getOriginalFilename());
			
			//파일이 없으면 continue
			if(null == outVO.getOrgFileName() || "".equals(outVO.getOrgFileName())) {
				continue;
			}
			
			String ext = "";
			if(outVO.getOrgFileName().indexOf(".") > -1) {
				int idx = outVO.getOrgFileName().lastIndexOf(".");
				ext = outVO.getOrgFileName().substring(idx+1);
			}
			
			//확장자
			outVO.setExt(ext);
			
			//파일 사이즈
			outVO.setFileSize(multipartFile.getSize());
			
			String savePath = "";
			if("png".equalsIgnoreCase(ext) || 
			   "jpeg".equalsIgnoreCase(ext) ||
			   "jpg".equalsIgnoreCase(ext) ||
			   "ico".equalsIgnoreCase(ext) ||
			   "gif".equalsIgnoreCase(ext) 
					) {
				savePath = this.IMG_PATH+addYYYYMMPath;
			} else {
				savePath = this.FILE_PATH+addYYYYMMPath;
			}
			
			//저장 경로
			outVO.setSavePath(savePath);
			
			//저장파일명
			String saveFileName = StringUtil.getPK()+"."+ext;
			outVO.setSaveFileName(saveFileName);
			LOG.debug("│=outVO=: "+outVO);
			
			File saveFileObj = new File(outVO.getSavePath(), outVO.getSaveFileName());
			
			multipartFile.transferTo(saveFileObj);
			//image파일인지 판단
			//s_저장파일명
			if(isImageFile(saveFileObj)) {
				FileOutputStream thumbnail = new FileOutputStream(
											 new File(outVO.getSavePath(),"s_"+outVO.getSaveFileName()));
				try {
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				} catch (IOException e) {
					LOG.debug(e.getMessage());
					throw e;
				}
			}
			
			list.add(outVO);
			LOG.debug("└──────────────────────────────");
		}
		
		modelAndView.addObject("list", list);
		modelAndView.setViewName("elecmusk/reg_evcar");
		return modelAndView;
	}
	
	public static boolean commonCopy(String inFilePath, String outFilePath) {
		File orgFile = new File(inFilePath);
		File outFile = new File(outFilePath);
		
		try {
			FileUtils.copyFile(orgFile, outFile);
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
}
