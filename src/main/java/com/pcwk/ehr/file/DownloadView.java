package com.pcwk.ehr.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {

   final Logger LOG = LogManager.getLogger(getClass());
   
   public DownloadView() {
      //contentType
      setContentType("application/download;charset=utf-8");
   }
   
   //다운로드 view에서 시작
   @Override
   protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
         HttpServletResponse response) throws Exception {
      setResponseContentType(request, response);
      
      //컨드롤로에서 원본 파일명 , downloadFile정보 가져오기.
      String orgFileNm = (String) model.get("orgFileNm");
      File downloadFile = (File) model.get("downloadFile");
      
      LOG.debug("orgFileNm"+orgFileNm);
      LOG.debug("downloadFile"+downloadFile);
      
      //다운로드 파일 이름 변경 : 원본 파일
      setDownloadFileName(orgFileNm, request, response);
      
      //다운로드 파일
      downloadFile(downloadFile, request, response);
      
   }
   
   /**
    * 다운로드 파일 이름 변경: 원본파일
    * @param orgFileNm
    * @param request
    * @param response
    * @throws Exception
    */
   public void setDownloadFileName(String orgFileNm,HttpServletRequest request,
         HttpServletResponse response)throws Exception {
      LOG.debug("--------------------------------");
      LOG.debug("----orgFileNm-----"+orgFileNm);
      LOG.debug("--------------------------------");
      
      orgFileNm = URLEncoder.encode(orgFileNm, "utf-8");
      LOG.debug("--encode orgFileNm--"+orgFileNm);
      
      //header에 원본 파일명 전달
      response.setHeader("Content-Disposition", "attachement;fileName=\""+orgFileNm+"\";");
      response.setHeader("Content-Transfer-Encoding", "binary");
      
   }
   
   
   /**
    * 파일 다운로드
    * @param downloadFile
    * @param request
    * @param response
    * @throws Exception
    */
   public void downloadFile(File downloadFile,HttpServletRequest request,
         HttpServletResponse response)throws Exception {
      
      FileInputStream in=new FileInputStream(downloadFile);
      
      OutputStream out = response.getOutputStream();
      
      try {
         
         int fileSize =  FileCopyUtils.copy(in, out);
         LOG.debug("--------------------------------");
         LOG.debug("----fileSize-----"+fileSize+"bytes");
         LOG.debug("--------------------------------");
         
         
         
      } catch (IOException e) {
         throw e;
      }finally {
         if(null != out) {
            try {
               out.close();
            } catch (IOException e) {
               // TODO: handle exception
            }
         }
         if(null != in) {
            try {
               in.close();
            } catch (IOException e) {
               // TODO: handle exception
            }
         }
      }
      
   }
   
   


}