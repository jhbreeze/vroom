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
			sql = "INSERT INTO event(eveNum, userId, eveTitle, eveCont, eveRegDate)"
					+ " VALUES (event_seq.NEXTVAL, 'admin', ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getEveTitle());
			pstmt.setString(2, dto.getEveCont());

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
			sql = "SELECT COUNT(*) FROM event";
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
			sql = " SELECT eveNum, eveTitle, TO_CHAR(eveRegDate, 'YYYY-MM-DD') eveRegDate " + " FROM event e "
					+ " JOIN member1 m ON e.userId = m.userId " + " ORDER BY eveNum DESC "
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
			sql = " SELECT eveNum, eveTitle, TO_CHAR(eveRegDate, 'YYYY-MM-DD') eveRegDate "
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
	
	public EventDTO readList(Long eveNum) {
		EventDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT eveNum, userId, eveTitle, eveCont, eveRegDate "
					+ " FROM event "
					+ " WHERE eveNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, eveNum);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new EventDTO();
				
				dto.setEveNum(rs.getLong("eveNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setEveTitle(rs.getString("eveCont"));
				dto.setEveCont(rs.getString("eveCont"));
				dto.setEveRegDate(rs.getString("eveRegDate"));
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
	
	public void updateEvent(EventDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE event SET eveTitle=?, eveCont=?, "
					+ " AND userId=? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getEveTitle());
			pstmt.setString(2, dto.getEveCont());
			pstmt.setString(3, dto.getUserId());
			
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

}
