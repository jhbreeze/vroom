package com.event;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class EventDAO {
	private Connection conn = DBConn.getConnection();

	public void insertEvent(EventDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO event(eveNum, userId, eveTitle, eveCont, imageFilename, event, eveRegDate)"
					+ " VALUES (event_seq.NEXTVAL, 'admin', ?, ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getEveTitle());
			pstmt.setString(2, dto.getEveCont());
			pstmt.setString(3, dto.getImageFilename());
			pstmt.setLong(4, dto.getEvent());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
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
			sql = "SELECT COUNT(*) FROM event WHERE event = 0 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}

		}

		return result;
	}
	public int dataCount2() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT COUNT(*) FROM event WHERE event = 1 ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}

			if (pstmt != null) {
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
			sql = " SELECT COUNT(*) FROM event e " + " JOIN member1 m ON e.userId = m.userId ";
			if (condition.equals("all")) {
				sql += " WHERE INSTR(eveTitle, ?) >= 1 OR INSTR(eveCont, ?) >= 1 ";
			} else if (condition.equals("eveRegDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE TO_CHAR(eveRegDate, 'YYYYMMDD') = ? ";
			} else {
				sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
			}

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, keyword);
			if (condition.equals("all")) {
				pstmt.setString(2, keyword);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}

		}

		return result;
	}

	public List<EventDTO> listEvent(int offset, int size) {
		List<EventDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT eveNum, eveTitle, TO_CHAR(eveRegDate, 'YYYY-MM-DD') eveRegDate, imageFilename, event "
		            + " FROM event e "
					+ " JOIN member1 m ON e.userId = m.userId " 
		            + " ORDER BY eveNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				EventDTO dto = new EventDTO();

				dto.setEveNum(rs.getLong("eveNum"));
				dto.setEveTitle(rs.getString("eveTitle"));
				dto.setEveRegDate(rs.getString("eveRegDate"));
				dto.setImageFilename(rs.getString("imageFilename"));
				dto.setEvent(rs.getLong("event"));

				list.add(dto);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}

		return list;
	}

	public List<EventDTO> listEvent(int offset, int size, String condition, String keyword) {
		List<EventDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT eveNum, eveTitle, TO_CHAR(eveRegDate, 'YYYY-MM-DD') eveRegDate, imageFilename "
					+ " FROM event ";
			if(condition.equals("all")) {
				sql += " WHERE INSTR(eveTitle, ?) >= 1 OR INSTR(eveCont, ?) >= 1 ";
			} else if(condition.equals("reg_date")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE TO_CHAR(eveRegDate, 'YYYYMMDD') = ? ";
			} else {
				sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
			}
			sql += " ORDER BY eveNum DESC ";
			sql += " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			if(condition.equals("all")) {
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
			
			while (rs.next()) {
				EventDTO dto = new EventDTO();
				
				dto.setEveNum(rs.getLong("eveNum"));
				dto.setEveTitle(rs.getString("eveTitle"));
				dto.setEveRegDate(rs.getString("eveRegDate"));
				dto.setImageFilename(rs.getString("imageFilename"));
				
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
	
	public EventDTO readList(long eveNum) {
		EventDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT eveNum, e.userId, eveTitle, eveCont, eveRegDate, imageFilename, event, name "
					+ " FROM event e"
					+ " JOIN member1 m ON e.userId = m.userId " 
					+ " JOIN customer c ON m.cusNum = c.cusNum " 
					+ " WHERE eveNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, eveNum);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new EventDTO();
				
				dto.setEveNum(rs.getLong("eveNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setEveTitle(rs.getString("eveTitle"));
				dto.setEveCont(rs.getString("eveCont"));
				dto.setEveRegDate(rs.getString("eveRegDate"));
				dto.setImageFilename(rs.getString("imageFilename"));
				dto.setEvent(rs.getLong("event"));
				dto.setName(rs.getString("name"));
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
		
		return dto;
	}
	
	public EventDTO preReadEvent(long eveNum, String condition, String keyword) {
		EventDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			if(keyword != null && keyword.length() != 0) {
				sb.append(" SELECT eveNum, eveTitle ");
				sb.append(" FROM event e ");
				sb.append(" JOIN member1 m ON e.userId = m.userId ");
				sb.append(" WHERE ( eveNum > ? ) ");
				if (condition.equals("all")) {
					sb.append("   AND ( INSTR(eveTitle, ?) >= 1 OR INSTR(eveCont, ?) >= 1 ) ");
				} else if (condition.equals("eveRegDate")) {
					keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
					sb.append("   AND ( TO_CHAR(eveRegDate, 'YYYYMMDD') = ? ) ");
				} else {
					sb.append("   AND ( INSTR(" + condition + ", ?) >= 1 ) ");
				}
				sb.append(" ORDER BY eveNum ASC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");

				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, eveNum);
				pstmt.setString(2, keyword);
				if (condition.equals("all")) {
					pstmt.setString(3, keyword);
				}
			} else {
				sb.append(" SELECT eveNum, eveTitle FROM event ");
				sb.append(" WHERE eveNum > ? ");
				sb.append(" ORDER BY eveNum ASC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");
				
				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, eveNum);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new EventDTO();
				
				dto.setEveNum(rs.getLong("eveNum"));
				dto.setEveTitle(rs.getString("eveTitle"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e2) {
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e2) {
				}
			}
		}
		return dto;
	}
	
	public EventDTO nextReadEvent(long eveNum, String condition, String keyword) {
		EventDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			if (keyword != null && keyword.length() != 0) {
				sb.append(" SELECT eveNum, eveTitle ");
				sb.append(" FROM event e ");
				sb.append(" JOIN member1 m ON e.userId = m.userId ");
				sb.append(" WHERE ( eveNum < ? ) ");
				if (condition.equals("all")) {
					sb.append("   AND ( INSTR(eveTitle, ?) >= 1 OR INSTR(eveCont, ?) >= 1 ) ");
				} else if (condition.equals("eveRegDate")) {
					keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
					sb.append("   AND ( TO_CHAR(eveRegDate, 'YYYYMMDD') = ? ) ");
				} else {
					sb.append("   AND ( INSTR(" + condition + ", ?) >= 1 ) ");
				}
				sb.append(" ORDER BY eveNum DESC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");

				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, eveNum);
				pstmt.setString(2, keyword);
				if (condition.equals("all")) {
					pstmt.setString(3, keyword);
				}
			} else {
				sb.append(" SELECT eveNum, eveTitle FROM event ");
				sb.append(" WHERE eveNum < ? ");
				sb.append(" ORDER BY eveNum DESC ");
				sb.append(" FETCH FIRST 1 ROWS ONLY ");

				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, eveNum);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new EventDTO();
				
				dto.setEveNum(rs.getLong("eveNum"));
				dto.setEveTitle(rs.getString("eveTitle"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}

			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}

		return dto;
	}

	
	public void updateEvent(EventDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE event SET eveTitle=?, eveCont=?, imageFilename=?, event=? "
					+ " WHERE eveNum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getEveTitle());
			pstmt.setString(2, dto.getEveCont());
			pstmt.setString(3, dto.getImageFilename());
			pstmt.setLong(4, dto.getEvent());
			pstmt.setLong(5, dto.getEveNum());
			
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
		}

	}
	
	public void deleteEvent(long eveNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			if (userId.equals("admin")) {
				sql = "DELETE FROM event WHERE eveNum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, eveNum);
				
				pstmt.executeUpdate();
			} else {
				sql = "DELETE FROM event WHERE eveNum=? AND userId=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, eveNum);
				pstmt.setString(2, userId);
				
				pstmt.executeUpdate();
			}

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
		}
	}
	
	public List<ReplyDTO> listReply(long eveNum, int offset, int size) {
		List<ReplyDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT r.replyNum, r.userId, name, r.eveNum, evReplyContent, evReplyDate "
					+ " FROM eventReply r "
					+ " JOIN member1 m ON r.userId = m.userId "
					+ " JOIN customer c ON m.cusNum = c.cusNum "
					+ " WHERE eveNum = ? "
					+ " ORDER BY r.replyNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, eveNum);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyDTO dto = new ReplyDTO();
				
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setEveNum(rs.getLong("eveNum"));
				dto.setEvReplyContent(rs.getString("evReplyContent"));
				dto.setUserId(rs.getString("userId"));
				dto.setName(rs.getString("name"));
				dto.setEvReplyDate(rs.getString("evReplyDate"));
				
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
	
	public int dataCountReply(long eveNum){
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT COUNT(*) FROM eventReply WHERE eveNum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, eveNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
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
		}
		return result;
	}
	
	public void insertReply(ReplyDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = " INSERT INTO eventReply(replyNum, eveNum, userId, evReplyContent, evReplyDate) "
					+ " VALUES(eventReply_seq.NEXTVAL, ?, ?, ?, SYSDATE) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, dto.getEveNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getEvReplyContent());
			
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
	
	public void deleteRely(long replyNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			if(!userId.equals("admin")) {
				sql = " SELECT replyNum FROM eventReply WHERE replyNum = ? AND userId = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, replyNum);
				pstmt.setString(2, userId);
				rs = pstmt.executeQuery();
				boolean b = false;
				if(rs.next()) {
					b = true;
				}
				rs.close();
				pstmt.close();
				
				if(!b) {
					return;
				}
			}
			
			sql = " DELETE FROM eventReply "
					+ " WHERE replyNum = ? ";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, replyNum);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
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


}
