package com.manage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ManageDAO {
	private Connection conn = DBConn.getConnection();
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT COUNT(*) FROM member1 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
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
		
		return result;
	}
	
	
	public int dataCount(String condition, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT COUNT(*) FROM member1 m "
					+ " JOIN customer c ON m.cusNum = c.cusNum ";
			
			if(condition.equals("cusNum")) {
				sql += " WHERE m.cusNum = ? ";
			} else {
				sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
			} 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword); 
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
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
		return result;
	}
	
	
	public List<ManageDTO> listMember(int offset, int size) {
		List<ManageDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT m.cusNum, userId, name, TO_CHAR(birth, 'YYYY-MM-DD') birth, tel, "
					+ " email, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, TO_CHAR(mod_date, 'YYYY-MM-DD') mod_date "
					+ " FROM member1 m"
					+ " JOIN customer c ON m.cusNum = c.cusNum "
					+ " ORDER BY m.cusNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
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
	
	
	public List<ManageDTO> listMember(int offset, int size, String condition, String keyword) {
		List<ManageDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT m.cusNum, userId, name, TO_CHAR(birth, 'YYYY-MM-DD') birth, tel, "
					+ " email, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, TO_CHAR(mod_date, 'YYYY-MM-DD') mod_date "
					+ " FROM member1 m"
					+ " JOIN customer c ON m.cusNum = c.cusNum ";
			
			if(condition.equals("cusNum")) {
				sql += " WHERE m.cusNum = ? ";
			} else {
				sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
			} 

			sql	+= " ORDER BY m.cusNum DESC ";
			sql	+= " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			if(condition.equals("cusNum")) {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			} else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}
			
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