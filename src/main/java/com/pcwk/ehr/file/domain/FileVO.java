package com.pcwk.ehr.file.domain;

import com.pcwk.ehr.cmn.DTO;

public class FileVO extends DTO {
	
	//DB: fileId, fileSeq(복합KEY)
	
	private String orgFileName 	;//원본파일명
	private String saveFileName	;//저장파일명
	private String savePath 	;//저장경로
	private String ext 			;//확장자
	private long   fileSize		;//파일사이즈(byte)
	
	private String imageViewPath;
	
	public FileVO() {}

	public FileVO(String orgFileName, String saveFileName, String savePath, String ext, long fileSize,
			String imageViewPath) {
		super();
		this.orgFileName = orgFileName;
		this.saveFileName = saveFileName;
		this.savePath = savePath;
		this.ext = ext;
		this.fileSize = fileSize;
		this.imageViewPath = imageViewPath;
	}

	public String getImageViewPath() {
		return imageViewPath;
	}

	public void setImageViewPath(String imageViewPath) {
		this.imageViewPath = imageViewPath;
	}

	public String getOrgFileName() {
		return orgFileName;
	}

	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}

	public String getSaveFileName() {
		return saveFileName;
	}

	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getExt() {
		return ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	@Override
	public String toString() {
		return "FileVO [orgFileName=" + orgFileName + ", saveFileName=" + saveFileName + ", savePath=" + savePath
				+ ", ext=" + ext + ", fileSize=" + fileSize + ", imageViewPath=" + imageViewPath + ", toString()="
				+ super.toString() + "]";
	}
	
}
