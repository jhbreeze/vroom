package com.qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class QnADAO {
	private Connection conn = DBConn.getConnection();

	public void insertQna(QnADTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = " INSERT INTO qna(qnaNum, qnaSubject, qnaContent, qnaRegDate, userId) "
					+ " VALUES(qna_seq.NEXTVAL, ?, ?, SYSDATE, ?) ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getQnaSubject());
			pstmt.setString(2, dto.getQnaContent());
			pstmt.setString(3, dto.getUserId());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}

	}

	public void insertQnaN(QnADTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = " INSERT INTO qna(qnaNum, qnaSubject, qnaContent, qnaRegDate, qnaName, qnaPwd) "
					+ " VALUES(qna_seq.NEXTVAL, ?, ?, SYSDATE, ?, ?) ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getQnaSubject());
			pstmt.setString(2, dto.getQnaContent());
			pstmt.setString(3, dto.getQnaName());
			pstmt.setString(4, dto.getQnaPwd());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
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
			sql = " SELECT COUNT(*) FROM qna ";
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
			sql = " SELECT COUNT(*) FROM qna q "
		          + " LEFT OUTER JOIN member1 m ON q.userId = m.userId "
			      + " LEFT OUTER JOIN customer c ON m.cusNum = c.cusNum ";
			if (condition.equals("all")) {
				sql += " WHERE INSTR(qnaSubject, ?) >= 1 OR INSTR(qnaContent, ?) >=1 ";
			} else if (condition.equals("qnaRegDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE TO_CHAR(qnaRegDate, 'YYYYMMDD') = ? ";
			} else {
				sql += " WHERE INSTR(" + condition + ", ?) >=1 ";
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

	public List<QnADTO> listQna(int offset, int size) {
		List<QnADTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT q.qnaNum, "
					+ " SUBSTR(name,1,1)||NVL(LPAD('*', LENGTH(name)-2,'*'),'*') ||SUBSTR(name,-1,1) name, qnaSubject, qnaRegDate, "
					+ " SUBSTR(qnaName,1,1)||NVL(LPAD('*', LENGTH(qnaName)-2,'*'),'*') ||SUBSTR(qnaName,-1,1)qnaName, m.userId, NVL(replyCount, 0) replyCount "
					+ " FROM qna q "
					+ " LEFT OUTER JOIN member1 m ON q.userId = m.userId "
					+ " LEFT OUTER JOIN customer c ON m.cusNum = c.cusNum "
					+ " LEFT OUTER JOIN ( SELECT qnaNum, COUNT(*) replyCount "
					+ " FROM qnaReply GROUP BY qnaNum ) c ON q.qnaNum = c.qnaNum "
					+ " ORDER BY qnaNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnADTO dto = new QnADTO();

				dto.setQnaNum(rs.getLong("qnaNum"));
				dto.setName(rs.getString("name"));
				dto.setQnaSubject(rs.getString("qnaSubject"));
				dto.setQnaRegDate(rs.getString("qnaRegDate"));
				dto.setQnaName(rs.getString("qnaName"));
				dto.setUserId(rs.getString("userId"));
				
				dto.setReplyCount(rs.getInt("replyCount"));

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

	public List<QnADTO> listQna(int offset, int size, String condition, String keyword) {
		List<QnADTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT qnaNum, SUBSTR(name,1,1)||NVL(LPAD('*', LENGTH(name)-2,'*'),'*') ||SUBSTR(name,-1,1) name, "
					+ " qnaSubject, qnaRegDate, "
					+ " SUBSTR(qnaName,1,1)||NVL(LPAD('*', LENGTH(qnaName)-2,'*'),'*') ||SUBSTR(qnaName,-1,1)qnaName, m.userId "
		            + " FROM qna q "
					+ " LEFT OUTER JOIN member1 m ON q.userId = m.userId "
					+ " LEFT OUTER JOIN customer c ON m.cusNum = c.cusNum ";
			if (condition.equals("all")) {
				sql += " WHERE INSTR(qnaSubject, ?) >= 1 OR INSTR(qnaContent, ?) >= 1 ";
			} else if (condition.equals("qnaRegDate")) {
				keyword = keyword.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE TO_CHAR(qnaRegDate, 'YYYYMMDD') = ? ";
			} else {
				sql += " WHERE INSTR(" + condition + ", ?) >= 1 ";
			}
			sql += " ORDER BY qnaNum DESC ";
			sql += " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
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
				QnADTO dto = new QnADTO();

				dto.setQnaNum(rs.getLong("qnaNum"));
				dto.setName(rs.getString("name"));
				dto.setQnaSubject(rs.getString("qnaSubject"));
				dto.setQnaRegDate(rs.getString("qnaRegDate"));
				dto.setQnaName(rs.getString("qnaName"));
				dto.setUserId(rs.getString("userId"));

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

	public QnADTO readQna(long qnaNum, String userId) {
		QnADTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			if (!userId.equals("admin")) {
				sql = " SELECT qnaNum FROM qna WHERE qnaNum = ? AND userId = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, qnaNum);
				pstmt.setString(2, userId);
				rs = pstmt.executeQuery();
				boolean b = false;
				if (rs.next()) {
					b = true;
				}
				rs.close();
				pstmt.close();

				if (!b) {
					return null;
				}
			}
			
			sql = " SELECT qnaNum, q.userId, SUBSTR(name,1,1)||NVL(LPAD('*', LENGTH(name)-2,'*'),'*') ||SUBSTR(name,-1,1) name, SUBSTR(qnaName,1,1)||NVL(LPAD('*', LENGTH(qnaName)-2,'*'),'*') ||SUBSTR(qnaName,-1,1)qnaName, qnaSubject, qnaContent, qnaRegDate " + " FROM qna q "
					+ " LEFT OUTER JOIN member1 m ON q.userId = m.userId "
					+ " LEFT OUTER JOIN customer c ON m.cusNum = c.cusNum " + " WHERE qnaNum = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, qnaNum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new QnADTO();

				dto.setQnaNum(rs.getLong("qnaNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setName(rs.getString("name"));
				dto.setQnaName(rs.getString("qnaName"));
				dto.setQnaSubject(rs.getString("qnaSubject"));
				dto.setQnaContent(rs.getString("qnaContent"));
				dto.setQnaRegDate(rs.getString("qnaRegDate"));
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

		return dto;
	}

	public QnADTO readQna1(long qnaNum) {
		QnADTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT qnaNum, q.userId, c.name, SUBSTR(qnaName,1,1)||NVL(LPAD('*', LENGTH(qnaName)-2,'*'),'*') ||SUBSTR(qnaName,-1,1)qnaName, qnaSubject, qnaContent, qnaRegDate, qnaPwd "
		            + " FROM qna q "
					+ " LEFT OUTER JOIN member1 m ON q.userId = m.userId "
					+ " LEFT OUTER JOIN customer c ON m.cusNum = c.cusNum "
					+ " WHERE qnaNum = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, qnaNum);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new QnADTO();

				dto.setQnaNum(rs.getLong("qnaNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setName(rs.getString("name"));
				dto.setQnaName(rs.getString("qnaName"));
				dto.setQnaSubject(rs.getString("qnaSubject"));
				dto.setQnaContent(rs.getString("qnaContent"));
				dto.setQnaRegDate(rs.getString("qnaRegDate"));
				dto.setQnaPwd(rs.getString("qnaPwd"));
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

		return dto;
	}

	public void deleteQna1(long qnaNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			if (!userId.equals("admin")) {
				sql = " SELECT qnaNum FROM qna WHERE qnaNum = ? AND userId = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, qnaNum);
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
			if (userId.equals("admin")) {
				sql = " DELETE FROM qna WHERE qnaNum = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, qnaNum);

				pstmt.executeUpdate();
			} else {
				sql = " DELETE FROM qna WHERE qnaNum = ? AND userId = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, qnaNum);
				pstmt.setString(2, userId);

				pstmt.executeUpdate();
			}

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}

	}

	public void deleteQna2(long qnaNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = " DELETE FROM qna WHERE qnaNum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, qnaNum);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
	}

	public void insertReply(ReplyDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = " INSERT INTO qnaReply(replyNum, qnaNum, userId, qnaReplyCont, qnaReplyDate) "
					+ " VALUES(qnaReply_seq.NEXTVAL, ?, ?, ?, SYSDATE) ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, dto.getQnaNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getQnaReplyCont());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
		}
	}

	public int dataCountReply(long qnaNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT COUNT(*) FROM qnaReply WHERE qnaNum = ? ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, qnaNum);

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

	public List<ReplyDTO> listReply(long qnaNum, int offset, int size) {
		List<ReplyDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT r.replyNum, r.userId, c.name, qnaNum, qnaReplyCont, r.qnaReplyDate " + " FROM qnaReply r "
					+ " JOIN member1 m ON r.userId = m.userId " + " JOIN customer c ON m.cusNum = c.cusNum "
					+ " WHERE qnaNum = ? " + " ORDER BY r.replyNum DESC " + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setLong(1, qnaNum);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReplyDTO dto = new ReplyDTO();

				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setQnaNum(rs.getLong("qnaNum"));
				dto.setName(rs.getString("name"));
				dto.setQnaReplyCont(rs.getString("qnaReplyCont"));
				dto.setQnaReplyDate(rs.getString("qnaReplyDate"));

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

	public void deleteReply(long ReplyNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			if (!userId.equals("admin")) {
				sql = " SELECT replyNum FROM qnaReply WHERE qnaNum = ? AND userId = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, ReplyNum);
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

			sql = " DELETE FROM qnaReply " + " WHERE replyNum = ?  ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, ReplyNum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e2) {
				}
			}
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception e2) {
				}
			}
		}

	}

}
