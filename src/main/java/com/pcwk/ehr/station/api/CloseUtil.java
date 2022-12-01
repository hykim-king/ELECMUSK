package com.pcwk.ehr.station.api;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CloseUtil {
	
	public static void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if(rs != null) {
			try {
				rs.close();
			}catch(SQLException se) {
				
			}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			}catch(SQLException se) {
				
			}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(SQLException se) {
				
			}
		}
	}
	
}
