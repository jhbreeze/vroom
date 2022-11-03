package com.faq;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class FaqDAO {
	private Connection conn = DBConn.getConnection();

	// 자주하는 질문 입력
	public void insertFaq(FaqDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = " INSERT INTO faq ( faqNum, userId, faqSubject, faqContent, faqRegDate ) "
					+ " VALUES (faq_seq.NEXTVAL, 'admin', ?, ?, SYSDATE) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getFaqSubject());
			pstmt.setString(2, dto.getFaqContent());
			
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

	// 전체 데이터 개수
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT COUNT(*) FROM faq ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
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
		return result;
	}

	// 리스트출력 및 내용 출력
	public List<FaqDTO> listFaq(int offset, int size) {
		List<FaqDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT faqSubject, faqContent, faqNum "
					+ " FROM faq f "
					+ " JOIN member1 m ON f.userId = m.userId " 
		            + " ORDER BY faqNum DESC "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				FaqDTO dto = new FaqDTO();
				
				dto.setFaqSubject(rs.getString("faqSubject"));
				dto.setFaqContent(rs.getString("faqContent"));
				dto.setFaqNum(rs.getLong("faqNum"));
				
				list.add(dto);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
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

		return list;
	}

	public FaqDTO readFaq(long faqNum) {
		FaqDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT faqSubject, faqContent, faqNum "
					+ " FROM faq "
					+ " WHERE faqNum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, faqNum);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new FaqDTO();
				
				dto.setFaqSubject(rs.getString("faqSubject"));
				dto.setFaqContent(rs.getString("faqContent"));
				dto.setFaqNum(rs.getLong("faqNum"));
			}

		} catch (Exception e) {
			e.printStackTrace();
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

		return dto;
	}

	//
	public void updateFaq(FaqDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = " UPDATE faq SET faqSubject=?, faqContent= ? "
					+ " WHERE faqNum = ? AND userId = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getFaqSubject());
			pstmt.setString(2, dto.getFaqContent());
			pstmt.setLong(3, dto.getFaqNum());
			pstmt.setString(4, dto.getUserId());
			
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

	public void deleteFaq(long faqNum, String userId) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			if (!userId.equals("admin")) {
				sql = " SELECT faqNum FROM faq WHERE faqNum = ? AND userId = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setLong(1, faqNum);
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

			sql = " DELETE FROM faq WHERE faqNum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, faqNum);

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
	
	public void deleteFaqList(long[] faqNums) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM faq WHERE faqNum IN (";
			for (int i = 0; i < faqNums.length; i++) {
				sql += "?,";
			}
			sql = sql.substring(0, sql.length() - 1) + ")";

			pstmt = conn.prepareStatement(sql);
			
			for (int i = 0; i < faqNums.length; i++) {
				pstmt.setLong(i + 1, faqNums[i]);
			}

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

}
