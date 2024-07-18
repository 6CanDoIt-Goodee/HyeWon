package com.book.member.event.dao;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.book.admin.event.vo.Event;
import com.book.member.event.vo.MemEvent;

public class MemEventDao {
 
    // 이벤트 목록 조회 메서드
    public List<Map<String, String>> selectEventList(Event option, Connection conn) {
        List<Map<String, String>> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT e.event_no AS 번호, e.event_title AS 제목, e.event_regdate AS 등록일, e.event_form AS 유형, c.event_category_name AS 카테고리명 " +
                    "FROM events e " +
                    "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                    "WHERE 1=1"; // 시작 조건

            // 카테고리 번호에 따라 필터링 조건 추가
            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    sql += " AND e.event_form = ?";
                } else {
                    sql += " AND c.event_category_no = ?";
                }
            }

            // 이벤트 제목 필터링 조건 추가
            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                sql += " AND e.event_title LIKE CONCAT('%', ?, '%')";
            }

            sql += " ORDER BY e.event_no ASC LIMIT ?, ?";

            pstmt = conn.prepareStatement(sql);
            int paramIndex = 1;

            // 카테고리 번호 설정
            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    pstmt.setInt(paramIndex++, option.getEvent_category()); // event_form 값 설정
                } else {
                    pstmt.setInt(paramIndex++, option.getEvent_category()); // event_category_no 값 설정
                }
            }

            // 이벤트 제목 설정
            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                pstmt.setString(paramIndex++, option.getEv_title());
            }

            // LIMIT OFFSET 설정 (페이징 처리)
            pstmt.setInt(paramIndex++, option.getLimitPageNo());
            pstmt.setInt(paramIndex, option.getNumPerPage());

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("event_no", rs.getString("번호"));
                row.put("event_title", rs.getString("제목"));
                row.put("event_regdate", rs.getString("등록일"));
                row.put("event_form", rs.getString("유형"));
                row.put("event_category_name", rs.getString("카테고리명"));
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return list;
    }



    // 선택된 카테고리에 따라 전체 이벤트 개수 조회 메서드
    public int selectEventCount(Event option, Connection conn) {
        int result = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) AS cnt FROM events e " +
                    "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                    "WHERE 1=1"; // 시작 조건

            // 카테고리 번호에 따라 필터링 조건 추가
            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    sql += " AND e.event_form = ?";
                } else {
                    sql += " AND c.event_category_no = ?";
                }
            }

            // 이벤트 제목 필터링 조건 추가
            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                sql += " AND e.event_title LIKE CONCAT('%', ?, '%')";
            }

            pstmt = conn.prepareStatement(sql);
            int paramIndex = 1;

            // 카테고리 번호 설정
            if (option.getEvent_category() != 0) {
                if (option.getEvent_category() == 1 || option.getEvent_category() == 2) {
                    pstmt.setInt(paramIndex++, option.getEvent_category()); // event_form 값 설정
                } else {
                    pstmt.setInt(paramIndex++, option.getEvent_category() - 2); // event_category_no 값 설정
                }
            }

            // 이벤트 제목 설정
            if (option.getEv_title() != null && !option.getEv_title().isEmpty()) {
                pstmt.setString(paramIndex++, option.getEv_title());
            }

            rs = pstmt.executeQuery();

            if (rs.next()) {
                result = rs.getInt("cnt");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }

    // 이벤트 번호로 조회 메서드
    public Event selectEventByNo(int eventNo, Connection conn) {
        Event event = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT e.*, c.event_category_name " +
                    "FROM events e " +
                    "JOIN event_category c ON e.event_category_no = c.event_category_no " +
                    "WHERE e.event_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, eventNo);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                event = new Event(rs.getInt("event_no"),
                        rs.getInt("event_category_no"),
                        rs.getString("event_title"),
                        rs.getString("event_content"),
                        rs.getInt("event_form"),
                        rs.getString("event_regdate"),
                        rs.getString("event_progress"),
                        rs.getString("event_start"),
                        rs.getString("event_end"),
                        rs.getString("event_ori_image"),
                        rs.getString("event_new_image"),
                        rs.getInt("event_quota"),
                        rs.getString("event_category_name"),
                        rs.getInt("event_registered"),
                        rs.getInt("event_waiting")); 
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }

        return event;
    }
    
    // 이벤트 참여 여부 확인
    public boolean checkRegistration(int eventNo, int userNo, Connection conn) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isRegistered = false;

        try {
            String sql = "SELECT COUNT(*) FROM participates WHERE event_no = ? AND user_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, eventNo);
            pstmt.setInt(2, userNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    isRegistered = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
 
        return isRegistered;
    }
 
    // 이벤트 참여자 추가
	public void registerForEvent(int eventNo, int userNo) {
	        String sql = "INSERT INTO participates (user_no, event_no) VALUES (?, ?)";
	        
	        try (Connection conn = getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            pstmt.setInt(1, userNo);
	            pstmt.setInt(2, eventNo);
	            pstmt.executeUpdate();
	            close(conn); 
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	
	// 이벤트 참여자 삭제
    public void cancelRegistration(int eventNo, int userNo) {
        String sql = "DELETE FROM participates WHERE event_no = ? AND user_no = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, eventNo);
            pstmt.setInt(2, userNo);
            pstmt.executeUpdate();
            close(conn); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    

}