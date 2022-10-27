package com.manage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ManageDAO {
	private Connection conn = DBConn.getConnection();
	
	public List<ManageDTO> listMember() {
		List<ManageDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT c.cusNum, userId, name, TO_CHAR(birth, 'YYYY-MM-DD') birth, tel, "
					+ " email, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, TO_CHAR(mod_date, 'YYYY-MM-DD') mod_date "
					+ " FROM member1 m"
					+ " JOIN customer c ON m.cusNum = c.cusNum ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ManageDTO dto = new ManageDTO();
				
				dto.setCusNum(rs.getInt("cusNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("name"));
				dto.setBirth(rs.getString("birth"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setMod_date(rs.getString("mod_date"));
				
				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
		
		return list;
	}
}