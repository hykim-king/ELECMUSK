package com.pcwk.ehr.naver.service;

import java.io.IOException;

import com.pcwk.ehr.cmn.SearchVO;

/**
 * Naver 검색 API
 * blog	https://openapi.naver.com/v1/search/blog.json
 * news	https://openapi.naver.com/v1/search/news.json
 * 책	https://openapi.naver.com/v1/search/book.json
 * 카페글	https://openapi.naver.com/v1/search/cafearticle.json
 * 쇼핑	https://openapi.naver.com/v1/search/shop.json
 * @author ITSC
 */
public interface NaverSearchService {
	
	/**
	 * Naver 검색
	 * @param inVO
	 * @return JSON(String)
	 * @throws IOException
	 */
	String doNaverSearch(SearchVO inVO) throws IOException;
	
}
