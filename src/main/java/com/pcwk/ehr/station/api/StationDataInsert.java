package com.pcwk.ehr.station.api;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class StationDataInsert {
	
	public static void main(String[] args) {
		Statement stmt = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String path = StationDataInsert.class.getResource("").getPath();//현재 클래스의 절대경로
		//File filePath = new File(path+"STATION_DATA.json");
		File filePath = new File("C:\\Users\\ITSC\\git\\ELECMUSK\\src\\main\\java\\com\\pcwk\\ehr\\station\\api\\STATION_DATA.json");
		
		//데이터 담을 변수
		String addr="";
		String chargeTp = "";
	    Long cpId = 9999999999L;
		String cpNm = "";
		String cpStat = "";
		String cpTp = "";
		Long csId = 9999999999L;
		String csNm = "";
		String lat = "";
		String longi = "";
		String statUpdatetime = "";

		
		//insert into JDBC 로직
			
		try {
			String driverClassName = "net.sf.log4jdbc.sql.jdbcapi.DriverSpy";
			String url = "jdbc:log4jdbc:oracle:thin:@192.168.3.101:1521:XE";
			String user = "ELECMUSK";
			String password = "pcwk";
			
			//JDBC Driver Loading
			Class.forName(driverClassName);
			
			//JDBC Connection getting
			conn = DriverManager.getConnection(url, user, password);
			
			System.out.println("DB CONNECTION SUCCESS");
			System.out.println("<<<<<< Driver:" + driverClassName + ", Connection:" + conn);
			
			//JSON 파일 읽기
			FileReader reader = new FileReader(filePath);
			//JSONParser 생성
		    JSONParser parser = new JSONParser();
		    //읽은 JSON 파일 -> JSONObject
		    JSONObject jsonobj = (JSONObject) parser.parse(reader);
		    //JSONObject -> JSONArray    key = ex) data : [{},{},{},{}, ...]
		    JSONArray jsonArr = (JSONArray)jsonobj.get("data");
		    //System.out.println("jsonArr:"+jsonArr);
		    
			//INSERT문
		    //STATION_SEQ.NEXTVAL -> seq 자동 +1
			String SQL = "insert into STATION_DATA(STATION_SEQ,addr, chargeTp, cpId, cpNm, cpStat, cpTp, csId, csNm, lat, longi, statUpdatetime) values(STATION_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?)";
			
			//PreParedStatement 객체 생성, 객체 생성시 SQL 문장 저장
			pstmt = conn.prepareStatement(SQL);
			
			//다건 JSON객체 (JSONArray)
			//FOR문 활용하여 JSONArray 값 get
			if(jsonArr.size()>0) {
				for(int i=0; i<jsonArr.size(); i++) {
					JSONObject jsonObj = (JSONObject)jsonArr.get(i);
					System.out.println((String)jsonObj.get("addr"));
					System.out.println((String)jsonObj.get("chargeTp"));
					System.out.println((Long)jsonObj.get("cpId"));
					System.out.println((String)jsonObj.get("cpNm"));
					System.out.println((String)jsonObj.get("cpStat"));
					System.out.println((String)jsonObj.get("cpTp"));
					System.out.println((Long)jsonObj.get("csId"));
					System.out.println((String)jsonObj.get("csNm"));
					System.out.println((String)jsonObj.get("lat"));
					System.out.println((String)jsonObj.get("longi"));
					System.out.println((String)jsonObj.get("statUpdatetime"));
					
					addr=(String)jsonObj.get("addr");
					chargeTp=(String)jsonObj.get("chargeTp");
					cpId=(Long)jsonObj.get("cpId");
					cpNm=(String)jsonObj.get("cpNm");
					cpStat=(String)jsonObj.get("cpStat");
					cpTp=(String)jsonObj.get("cpTp");
					csId=(Long)jsonObj.get("csId");
					csNm=(String)jsonObj.get("csNm");
					lat=(String)jsonObj.get("lat");
					longi=(String)jsonObj.get("longi");
					statUpdatetime=(String)jsonObj.get("statUpdatetime");
					
					//psmt.set<데이터타입><? 순서, 값)
					pstmt.setString(1, addr);
					pstmt.setString(2, chargeTp);
					pstmt.setLong(3, cpId);
					pstmt.setString(4, cpNm);
					pstmt.setString(5, cpStat);
					pstmt.setString(6, cpTp);
					pstmt.setLong(7, csId);
					pstmt.setString(8, csNm);
					pstmt.setString(9, lat);
					pstmt.setString(10, longi);
					pstmt.setString(11, statUpdatetime);

					int row = pstmt.executeUpdate();
					
					System.out.println("SQL 실행:"+row+"개 의 row삽입");
				}
			}

			//SQL문 작성
			String SQL2 = "insert into STATION_DATA(STATION_SEQ,addr, chargeTp, cpId, cpNm, cpStat, cpTp, csId, csNm, lat, longi, statUpdatetime) values(STATION_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?)";
			
			//PreParedStatement 객체 생성, 객체 생성시 SQL 문장 저장
			pstmt = conn.prepareStatement(SQL2);
			
			
		}catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (org.json.simple.parser.ParseException e) {
			e.printStackTrace();
		}finally {
			CloseUtil.close(null, pstmt, conn);
			
		}
		
	}

}