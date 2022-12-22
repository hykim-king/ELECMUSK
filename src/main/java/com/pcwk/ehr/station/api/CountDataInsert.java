package com.pcwk.ehr.station.api;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class CountDataInsert {

	public static void main(String[] args) {
		Statement stmt = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String path = CountDataInsert.class.getResource("").getPath();//현재 클래스의 절대경로
		File filePath = new File(path+"CountByMonth.json");//데이터 per Month
		//File filePath = new File(path+"CountByYear.json");//데이터 per Year
		//File filePath = new File("C:\\Users\\허승휘\\git\\ELECMUSK\\src\\main\\java\\com\\pcwk\\ehr\\station\\api\\CountByMonth.json");
		//File filePath = new File("C:\\Users\\허승휘\\git\\ELECMUSK\\src\\main\\java\\com\\pcwk\\ehr\\station\\api\\CountByYear.json");

		//데이터 담을 변수
		Long ulsan = 0L;
		Long choongbuk = 0L;
		Long count_sum = 0L;
		Long seoul = 0L;
		Long jeonbuk = 0L;
		Long gyeonggi = 0L;
		Long choongnam = 0L;
		Long busan = 0L;
		String standard_date="";
		Long gangwon = 0L;
		Long gyeongbuk = 0L;
		Long daejeon = 0L;
		Long sejong = 0L;
		Long jeju = 0L;
		Long daegu = 0L;
		Long incheon = 0L;
		Long jeonnam = 0L;
		Long gyeongnam = 0L;
		Long gwangju = 0L;
	    
		
		try{
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
			String SQL = "insert into REGIONAL_COUNT(ULSAN, CHOONGBUK, COUNT_SUM, SEOUL, JEONBUK, GYEONGGI, CHOONGNAM, BUSAN, STANDARD_DATE, GANGWON, GYEONGBUK, DAEJEON, SEJONG, JEJU, DAEGU, INCHEON, JEONNAM, GYEONGNAM, GWANGJU) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			//PreParedStatement 객체 생성, 객체 생성시 SQL 문장 저장
			pstmt = conn.prepareStatement(SQL);
			
			//다건 JSON객체 (JSONArray)
			//FOR문 활용하여 JSONArray 값 get
			if(jsonArr.size()>0) {
				for(int i=0; i<jsonArr.size(); i++) {
					JSONObject jsonObj = (JSONObject)jsonArr.get(i);
					System.out.println((Long)jsonObj.get("울산"));
					System.out.println((Long)jsonObj.get("충북"));
					System.out.println((Long)jsonObj.get("합계"));
					System.out.println((Long)jsonObj.get("서울"));
					System.out.println((Long)jsonObj.get("전북"));
					System.out.println((Long)jsonObj.get("경기"));
					System.out.println((Long)jsonObj.get("충남"));
					System.out.println((Long)jsonObj.get("부산"));
					System.out.println((String)jsonObj.get("기준일"));
					System.out.println((Long)jsonObj.get("강원"));
					System.out.println((Long)jsonObj.get("경북"));
					System.out.println((Long)jsonObj.get("대전"));
					System.out.println((Long)jsonObj.get("세종"));
					System.out.println((Long)jsonObj.get("제주"));
					System.out.println((Long)jsonObj.get("대구"));
					System.out.println((Long)jsonObj.get("인천"));
					System.out.println((Long)jsonObj.get("전남"));
					System.out.println((Long)jsonObj.get("경남"));
					System.out.println((Long)jsonObj.get("광주"));
					
					
					ulsan=(Long)jsonObj.get("울산");
					choongbuk=(Long)jsonObj.get("충북");
					count_sum=(Long)jsonObj.get("합계");
					seoul=(Long)jsonObj.get("서울");
					jeonbuk=(Long)jsonObj.get("전북");
					gyeonggi=(Long)jsonObj.get("경기");
					choongnam=(Long)jsonObj.get("충남");
					busan=(Long)jsonObj.get("부산");
					standard_date=(String)jsonObj.get("기준일");
					gangwon=(Long)jsonObj.get("강원");
					gyeongbuk=(Long)jsonObj.get("경북");
					daejeon=(Long)jsonObj.get("대전");
					sejong=(Long)jsonObj.get("세종");
					jeju=(Long)jsonObj.get("제주");
					daegu=(Long)jsonObj.get("대구");
					incheon=(Long)jsonObj.get("인천");
					jeonnam=(Long)jsonObj.get("전남");
					gyeongnam=(Long)jsonObj.get("경남");
					gwangju=(Long)jsonObj.get("광주");

					
					//psmt.set<데이터타입><? 순서, 값)
					pstmt.setLong(1, ulsan);
					pstmt.setLong(2, choongbuk);
					pstmt.setLong(3, count_sum);
					pstmt.setLong(4, seoul);
					pstmt.setLong(5, jeonbuk);
					pstmt.setLong(6, gyeonggi);
					pstmt.setLong(7, choongnam);
					pstmt.setLong(8, busan);
					pstmt.setString(9, standard_date);
					pstmt.setLong(10, gangwon);
					pstmt.setLong(11, gyeongbuk);
					pstmt.setLong(12, daejeon);
					pstmt.setLong(13, sejong);
					pstmt.setLong(14, jeju);
					pstmt.setLong(15, daegu);
					pstmt.setLong(16, incheon);
					pstmt.setLong(17, jeonnam);
					pstmt.setLong(18, gyeongnam);
					pstmt.setLong(19, gwangju);
					

					int r = pstmt.executeUpdate();
					
					System.out.println("SQL 실행:"+r+"개 의 row삽입");
				}
			}

			//SQL문 작성
			String SQL2 = "insert into REGIONAL_COUNT(ULSAN, CHOONGBUK, COUNT_SUM, SEOUL, JEONBUK, GYEONGGI, CHOONGNAM, BUSAN, STANDARD_DATE, GANGWON, GYEONGBUK, DAEJEON, SEJONG, JEJU, DAEGU, INCHEON, JEONNAM, GYEONGNAM, GWANGJU) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			//PreParedStatement 객체 생성, 객체 생성시 SQL 문장 저장
			pstmt = conn.prepareStatement(SQL2);
			
			
		}catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (org.json.simple.parser.ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			CloseUtil.close(null, pstmt, conn);
			
		}
		
	}

}