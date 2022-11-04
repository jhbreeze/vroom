package com.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class NoticeDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertNotice(NoticeDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = " INSERT INTO board(boardNum, userId, categoryNum, boSubject, boCont, boDate, notice) "
					+ " VALUES(board_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setLong(2, dto.getCategoryNum());
			pstmt.setString(3, dto.getBoSubject());
			pstmt.setString(4, dto.getBoCont());
			pstmt.setLong(5, dto.getNotice());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
	}
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT NVL(COUNT(*),0) FROM board";
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
			sql = " SELECT COUNT(*) FROM board b "
					+ " JOIN member1 m ON b.userId = m.userId ";
			if (condition.equals("all")) {
				sql += "  WHERE INSTR(boSubject, ?) >= 1 OR INSTR(boCont, ?) >= 1 ";
			} else if (condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += "  WHERE TO_CHAR(boDate, 'YYYYMMDD') = ? ";
			} else {
				sql += "  WHERE INSTR(" + condition + ", ?) >= 1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			if(condition.equals("all")) {
				pstmt.setString(2, keyword);
			}
			
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
	
	public List<NoticeDTO> listNotice(int offset, int size) {
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append(" SELECT boardNum, b.userId, name, boSubject, category, ");
			sb.append(" boDate ");
			sb.append(" FROM board b ");
			sb.append(" JOIN member1 m ON b.userId = m.userId ");
			sb.append(" JOIN customer c ON m.cusNum = c.cusNum ");
			sb.append(" JOIN noticeCategory n ON b.categoryNum = n.categoryNum ");
			sb.append(" ORDER BY boardNum DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				
				dto.setBoardNum(rs.getLong("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setName(rs.getString("name"));
				dto.setBoSubject(rs.getString("boSubject"));
				dto.setBoDate(rs.getString("boDate"));
				dto.setCategory(rs.getString("category"));
				
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
	
	public List<NoticeDTO> listNotice2() {
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append(" SELECT boardNum, b.userId, name, boSubject, category, ");
			sb.append(" boDate ");
			sb.append(" FROM board b ");
			sb.append(" JOIN member1 m ON b.userId = m.userId ");
			sb.append(" JOIN customer c ON m.cusNum = c.cusNum ");
			sb.append(" JOIN noticeCategory n ON b.categoryNum = n.categoryNum ");
			sb.append(" ORDER BY boardNum DESC ");
			sb.append(" FETCH FIRST 6 ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				
				dto.setBoardNum(rs.getLong("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setName(rs.getString("name"));
				dto.setBoSubject(rs.getString("boSubject"));
				dto.setBoDate(rs.getString("boDate"));
				dto.setCategory(rs.getString("category"));
				
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
	
	public List<NoticeDTO> listNotice(int offset, int size, String condition, String keyword) {
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append(" SELECT boardNum, b.userId, c.name, boSubject, category, ");
			sb.append(" boDate ");
			sb.append(" FROM board b ");
			sb.append(" JOIN member1 m ON b.userId = m.userId ");
			sb.append(" JOIN customer c ON m.cusNum = c.cusNum ");
			sb.append(" JOIN noticeCategory n ON b.categoryNum = n.categoryNum ");
			if (condition.equals("all")) {
				sb.append(" WHERE INSTR(boSubject, ?) >= 1 OR INSTR(boCont, ?) >= 1 ");
			} else if (condition.equals("boDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sb.append(" WHERE TO_CHAR(boDate, 'YYYYMMDD') = ?");
			} else {
				sb.append(" WHERE INSTR(" + condition + ", ?) >= 1 ");
			}
			sb.append(" ORDER BY boardNum DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			if (condition.equals("all")) {
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, keyword);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				
				dto.setBoardNum(rs.getLong("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setName(rs.getString("name"));
				dto.setBoSubject(rs.getString("boSubject"));
				dto.setBoDate(rs.getString("boDate"));
				dto.setCategory(rs.getString("category"));
				
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
	
	public List<NoticeDTO> listNotice() {
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append(" SELECT boardNum, b.userId, c.name, boSubject, n.category, ");
			sb.append(" TO_CHAR(boDate, 'YYYY-MM-DD') boDate  ");
			sb.append(" FROM board b ");
			sb.append(" JOIN member1 m ON b.userId=m.userId ");
			sb.append(" JOIN customer c ON m.cusNum = c.cusNum ");
			sb.append(" JOIN noticeCategory n ON b.categoryNum = n.categoryNum ");
			sb.append(" WHERE notice=1  ");
			sb.append(" ORDER BY boardNum DESC ");

			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				
				dto.setBoardNum(rs.getLong("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setName(rs.getString("name"));
				dto.setBoSubject(rs.getString("boSubject"));
				dto.setBoDate(rs.getString("boDate"));
				dto.setCategory(rs.getString("category"));
				
				
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
	
	public NoticeDTO readNotice(long boardNum) {
		NoticeDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT boardNum, notice, b.userId, c.name, boSubject, boCont, boDate, category "
					+ " FROM board b "
					+ " JOIN member1 m ON b.userId=m.userId "
					+ " JOIN noticeCategory n ON b.categoryNum = n.categoryNum "
					+ " JOIN customer c ON m.cusNum = c.cusNum "
					+ " WHERE boardNum = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, boardNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setBoardNum(rs.getLong("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setName(rs.getString("name"));
				dto.setBoSubject(rs.getString("boSubject"));
				dto.setBoCont(rs.getString("boCont"));
				dto.setBoDate(rs.getString("boDate"));
				dto.setCategory(rs.getString("category"));
				dto.setNotice(rs.getLong("notice"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		return dto;
	}
	
	public NoticeDTO preReadNotice(long boardNum, String condition, String keyword) {
		NoticeDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			if(keyword != null && keyword.length() != 0) {
				sb.append(" SELECT boardNum, boSubject, c.category ");
				sb.append(" FROM board b ");
				sb.append(" JOIN noticeCategory c ON b.categoryNum = c.categoryNum ");
				sb.append(" WHERE ( boardNum > ? )");
				if(condition.equals("all")) {
					sb.append(" AND ( INSTR(boSubject, ?) >=1 OR INSTR(boCont, ?) >=1) ");
				} else if(condition.equals("boDate")) {
					keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
					sb.append(" AND (TO_CHAR(boDate, 'YYYYMMDD') = ? ");
				} else {
					sb.append(" AND (INSTR("+condition+", ?) >=1) ");
				}
				sb.append(" ORDER BY boardNum ASC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");
				
				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, boardNum);
				pstmt.setString(2, keyword);
				if(condition.equals("all")) {
					pstmt.setString(3, keyword);
				}
			} else {
				sb.append(" SELECT boardNum, boSubject FROM board ");
				sb.append(" WHERE boardNum > ? ");
				sb.append(" ORDER BY boardNum ASC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");
				
				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, boardNum);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setBoardNum(rs.getLong("boardNum"));
				dto.setBoSubject(rs.getString("boSubject"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		return dto;
	}
	
	public NoticeDTO nextReadNotice(long boardNum, String condition, String keyword) {
		NoticeDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			if(keyword != null && keyword.length() != 0) {
				sb.append(" SELECT boardNum, boSubject, c.category ");
				sb.append(" FROM board b ");
				sb.append(" JOIN noticeCategory c ON b.categoryNum = c.categoryNum ");
				sb.append(" WHERE ( boardNum < ? )");
				if(condition.equals("all")) {
					sb.append(" AND ( INSTR(boSubject, ?) >=1 OR INSTR(boCont, ?) >=1) ");
				} else if(condition.equals("boDate")) {
					keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
					sb.append(" AND (TO_CHAR(boDate, 'YYYYMMDD') = ? ");
				} else {
					sb.append(" AND (INSTR("+condition+", ?) >=1) ");
				}
				sb.append(" ORDER BY boardNum DESC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");
				
				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, boardNum);
				pstmt.setString(2, keyword);
				if(condition.equals("all")) {
					pstmt.setString(3, keyword);
				}
			} else {
				sb.append(" SELECT boardNum, boSubject FROM board ");
				sb.append(" WHERE boardNum < ? ");
				sb.append(" ORDER BY boardNum DESC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");
				
				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, boardNum);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setBoardNum(rs.getLong("boardNum"));
				dto.setBoSubject(rs.getString("boSubject"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if(rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}
		return dto;
	}
	
	public void updatetNotice(NoticeDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = " UPDATE board SET notice=?, boSubject=?, boCont=?, categoryNum=? "
					+ " WHERE boardNum=? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, dto.getNotice());
			pstmt.setString(2, dto.getBoSubject());
			pstmt.setString(3, dto.getBoCont());
			pstmt.setLong(4, dto.getCategoryNum());
			pstmt.setLong(5, dto.getBoardNum());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			pstmt = null;
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
	}
	
	public void deleteNotice(long boardNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			if (!userId.equals("admin")) {
				sql = " SELECT boardNum FROM notice WHERE boardNum = ? AND userId = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, boardNum);
				pstmt.setString(2, userId);
				rs = pstmt.executeQuery();
				boolean b = false;
				if (rs.next()) {
					b = true;
				}
				rs.close();
				pstmt.close();

				if (!b) {
					return;
				}
			}
			
			sql = "DELETE FROM board WHERE boardNum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, boardNum);
			
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
		}

	}
	
}
