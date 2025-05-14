package com.pcwk.ehr.cmn;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.google.common.base.*;

public class StringUtil {

	static final Logger log = LogManager.getLogger(StringUtil.class);

	/**
	 * request에 파라메터 null처리
	 * 
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	// nvl
	public static String nvl(String value, String defaultValue) {
		if (Strings.isNullOrEmpty(value)) {
			return defaultValue;
		}
		return value;
	}

	/**
	 * 
	 * @param maxNum: 총 글수 
	 * @param currentPageNo: 현재 페이지 번호
	 * @param rowPerPage: 페이지 사이즈(10,20,...,100)
	 * @param bottomCount: 10/5
	 * @param url: 서버 호출 URL
	 * @param scriptName: 자바스크립트 함수명
	 * @return "html 텍스트"
	 */
	public static String renderingPager(int maxNum, int currentPageNo, int rowPerPage, int bottomCount, String url, String scriptName) {
		StringBuilder html = new StringBuilder(2000);
		
		int maxPageNo = (maxNum -1) / rowPerPage +1;
		int startPageNo = ((currentPageNo -1) / bottomCount) * bottomCount +1;
		int endPageNo = ((currentPageNo -1) / bottomCount+1) * bottomCount; 
		
		long nowBlockNo = ((currentPageNo -1) / bottomCount)+1;
		long maxBlockNo = ((maxNum -1)/bottomCount)+1;
		
		if(currentPageNo > maxPageNo) {
			return "";
		}
		
		/**
		 *    <div class="pagination">
			    <a href="#" class="prev disabled">«</a>
			    <a href="#" class="prev disabled"><</a>
			    <a href="#" class="page active">1</a>
			    <a href="#" class="page">2</a>
			    <a href="#" class="page">3</a>
			    <a href="#" class="page">4</a>
			    <a href="#" class="page">5</a>
			    <a href="#" class="prev disabled">></a>
			    <a href="#" class="next">»</a>
			   </div> 
		 */
		html.append("<div class=\"pagination\"> \n");
		if(nowBlockNo > 1 && nowBlockNo <= maxBlockNo) {
			html.append("<a href=\"javascript:"+scriptName+"('"+url+"',1);\" class=\"prev \">&laquo;</a> \n");
		}
		
		if(startPageNo > bottomCount) {
			html.append("<a href=\"javascript:"+scriptName+"('"+url+"',"+(startPageNo - bottomCount)+");\" >");
			html.append("<span>&lt;</span>");
			html.append("</a> \n");  
		}
		
		int inx = 0;
		for(inx = startPageNo; inx<=maxPageNo && inx<=endPageNo; inx++) {
			if(inx == currentPageNo) {
				html.append("<a href=\"#\" class=\"disabled\">");
				html.append(inx);
				html.append("</a>\n");
			}else {
				html.append("<a href=\"javascript:"+scriptName+"('"+url+"',"+(inx)+"); \" class=\"active\">");
				html.append(inx);
				html.append("</a>\n");
			}
		}
		
		if(maxPageNo>inx) {
			html.append("<a href=\"javascript:"+scriptName+"('"+url+"',"+((nowBlockNo * bottomCount)+1)+");\" >");
			html.append("<span>&gt;</span>");
			html.append("</a> \n");
		}
		
		if(maxPageNo>inx) {
			html.append("<a href=\"javascript:"+scriptName+"('"+url+"',"+(maxPageNo)+");\" >");
			html.append("<span>&raquo;</span>");
			html.append("</a> \n");
		}
		
		html.append("</div>");
		log.debug(html.toString());

		return html.toString();
	}

}
