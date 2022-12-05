package com.pcwk.ehr.cmn;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import com.google.gson.Gson;

public class StringUtil {
	
	
	
	/**
	 * Backand 메시지 처리
	 * @param msgId(1이 아니면 실패)
	 * @param msgContents
	 * @return json 문자열 
	 */
	public static String validMessageToJson(String msgId, String msgContents) {
		return new Gson().toJson(new MessageVO(msgId, msgContents));
	}
	
	/**
	 * 
	 * @return YYYYMMDD+32
	 */
	public static String getPK() {
		return getCurrentDate()+getUUID() ;
	}
    	
	/**
	 * 32bit UUID
	 * @return
	 */
	public static String getUUID() {
		UUID  uuid=UUID.randomUUID();
		
		return uuid.toString().replace("-", "");
	}
	
	/**
	 * 현재날자
	 * @return YYYYMMDD
	 */
	public static String getCurrentDate() {		
		return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
	}
	
	
	/**
	 * NULL처리
	 * 
	 * @param input
	 * @param replace
	 * @return
	 */
	public static String nvl(String input, String replace) {
		String retString = "";

		retString = (input == null) ? replace : input;

		return retString.trim();
	}

	/**
	 * 
	 * @param input
	 * @return
	 */
	public static String nvl(String input) {
		return nvl(input, "");
	}

	/**
	 * HTML 문자단위(엔티티)

		- 공백( )    &nbsp;
		- 부등호(<)    &lt;
		- 부등호(>)    &gt;
		- 앰퍼센트(&)    &amp;
		- 쌍따옴표(")    &quot;
	 * @param str
	 * @return
	 */
	public static String toReplace(String str) {

		if (str == null) {
			return null;
		}


		return str.replaceAll("[&]", "&amp;")
				  .replaceAll("[<]", "&lt;")
				  .replaceAll("[>]", "&gt;")
				  .replaceAll("[\"]", "&quot;");

	}
	
	/**
	 * 
	 * @param maxNum:총글수
	 * @param currPageNo : 현재 페이지
	 * @param rowPerPage : 10/20/30/50/100
	 * @param bottomCount: 10
	 * @param url : /PC_HTML/board/board.do?work_div=doRetrieve&page_no=1&search_div=10&search_word=title&page_size=10
	 * @param scriptName: javascript function name
	 * @return page처리된 문자열
	 */
	/*
    <table class="page_table">
     <tr >
      <td class="txt_center">
        <ul>
         <li>
         	<a href="javascript:doRetrieve(url,1)">&laquo;
         	</a>
         </li>
         <li><a href="javascript:doRetrieve(url,계산)">&lt;</a></li>
	           <% for(int i=1;i<=10;i++){ %>
	           <li><a href="#"><%=i %></a></li>
	           <% } %>
         <li><a href="#">&gt;</a></li>
         <li><a href="#">&raquo;</a></li>                         
        </ul>
      </td>          
     </tr>
    </table>
	 */	
	public static String renederPaging(int maxNum, int currPageNo, int rowPerPage, int bottomCount,String url, String scriptName) {
		StringBuilder html=new StringBuilder(2000);
        
		/*
		 * maxNum:총글수 (21)
		 * currPageNo : 현재 페이지(1)
		 * rowPerPage : 10
		 * bottomCount: 10
		 * << < 1 2 3 4 5 6 7 8 9 10 > >>
		 */
		
		int maxPageNo   = ((maxNum -1)/rowPerPage) + 1;
		int startPageNo = ((currPageNo - 1)/bottomCount) * bottomCount +1;//1,11,21,31,..
		int endPageNo   = ((currPageNo - 1)/bottomCount+1)* bottomCount; //10,20,30,40,..
		
		int nowBlockNo  = ((currPageNo-1)/bottomCount)+1;//1
		int maxBlockNo  = ((maxNum  -1)/bottomCount)+1;//3
		
		if(currPageNo > maxPageNo) {
			return "";
		}
		
		html.append("<table class=\"page_table\">  \n");
		html.append("<tr>\n");
		html.append("<td class=\"txt_center\"> \n");
		html.append("<ul> \n");
		
		// <<
		if(nowBlockNo > 1 && nowBlockNo <= maxBlockNo) {
			html.append("<li> \n");
			html.append("<a href=\"javascript:"+scriptName+"('"+url+"',1);\"> \n");
			html.append("&laquo;");
			html.append("</a> \n");
			html.append("</li> \n");
		}
		
		// <
		if(startPageNo > bottomCount) {
			html.append("<li> \n");
			html.append("<a href=\"javascript:"+scriptName+"('"+url+"',"+(startPageNo-bottomCount)+");\"> \n");
			html.append("&lt;");
			html.append("</a> \n");
			html.append("</li> \n");			
		}
		
		// 1 2 .. 10
		int inx = 0;
		for(inx = startPageNo;inx<=maxPageNo && inx <=endPageNo;inx++) {
			if(inx == currPageNo) {//현제 페이지 이면
				html.append("<li class='disable'> \n");
				html.append(inx);
				html.append("</li> \n");				
			}else {
				html.append("<li> \n");
				html.append("<a href=\"javascript:"+scriptName+"('"+url+"',"+inx+");\"> \n");
				html.append(inx);
				html.append("</a> \n");
				html.append("</li> \n");					
				
			}
		}
		
		// >
		if(maxPageNo > inx) {
			html.append("<li> \n");
			html.append("<a href=\"javascript:"+scriptName+"('"+url+"',"+((nowBlockNo*bottomCount)+1)+");\"> \n");
			html.append("&gt;");
			html.append("</a> \n");
			html.append("</li> \n");				
		}
		
		// >>
		if(maxPageNo > inx) {
			html.append("<li> \n");
			html.append("<a href=\"javascript:"+scriptName+"('"+url+"',"+maxPageNo+");\"> \n");
			html.append("&raquo;");
			html.append("</a> \n");
			html.append("</li> \n");			
		}
		
		
		html.append("</ul> \n");
		html.append("</td> \n");
		html.append("</tr> \n");
		html.append("</table> \n");
		
		
		
		return html.toString();
	}
	
}
