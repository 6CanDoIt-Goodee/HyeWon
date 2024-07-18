package com.book.admin.event.dao;

import static com.book.common.sql.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.book.admin.event.vo.Event;

public class EventDao {

    // 이벤트 생성 메서드
    public int createEvent(Event event, Connection conn) {
        PreparedStatement pstmt = null;
        int result = 0;

        try {
            String sql = "INSERT INTO events (event_title, event_content, event_form, event_progress, event_start, event_end, event_ori_image, event_new_image, event_category_no, event_quota) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, event.getEv_title());
            pstmt.setString(2, event.getEv_content());
            pstmt.setInt(3, event.getEv_form());
            pstmt.setString(4, event.getEv_progress());
            pstmt.setString(5, event.getEv_start());
            pstmt.setString(6, event.getEv_end());
            pstmt.setString(7, event.getOri_image());
            pstmt.setString(8, event.getNew_image());
            pstmt.setInt(9, event.getEvent_category());
            if (event.getEv_form() == 2) {
                pstmt.setInt(10, event.getEvent_quota());
            } else {
                pstmt.setNull(10, java.sql.Types.INTEGER);
            }
            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        return result;
    }

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

            sql += " ORDER BY e.event_regdate ASC LIMIT ?, ?";

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

    public int updateEvent(Event event, Connection conn) {
        PreparedStatement pstmt = null;
        int result = 0;

        try {
            StringBuilder query = new StringBuilder("UPDATE events SET ");
            query.append("event_title=?, ");
 
            if (event.getEv_start() != null && !event.getEv_start().isEmpty()) {
                query.append("event_start=?, ");
            }
 
            if (event.getEv_end() != null && !event.getEv_end().isEmpty()) {
                query.append("event_end=?, ");
            }
 
            if (event.getEv_progress() != null && !event.getEv_progress().isEmpty()) {
                query.append("event_progress=?, ");
            }

            query.append("event_content=?, event_category_no=?, event_quota=?");
 
            if (event.getOri_image() != null && !event.getOri_image().isEmpty()) {
                query.append(", event_ori_image=?");
            }
 
            if (event.getNew_image() != null && !event.getNew_image().isEmpty()) {
                query.append(", event_new_image=?");
            }

            query.append(" WHERE event_no=?");

            pstmt = conn.prepareStatement(query.toString());

            int index = 1;
            pstmt.setString(index++, event.getEv_title());
 
            if (event.getEv_start() != null && !event.getEv_start().isEmpty()) {
                pstmt.setString(index++, event.getEv_start());
            }
 
            if (event.getEv_end() != null && !event.getEv_end().isEmpty()) {
                pstmt.setString(index++, event.getEv_end());
            }
 
            if (event.getEv_progress() != null && !event.getEv_progress().isEmpty()) {
                pstmt.setString(index++, event.getEv_progress());
            }

            pstmt.setString(index++, event.getEv_content());
            pstmt.setInt(index++, event.getEvent_category());
            pstmt.setInt(index++, event.getEvent_quota());
 
            if (event.getOri_image() != null && !event.getOri_image().isEmpty()) {
                pstmt.setString(index++, event.getOri_image());
            }
 
            if (event.getNew_image() != null && !event.getNew_image().isEmpty()) {
                pstmt.setString(index++, event.getNew_image());
            }

            pstmt.setInt(index++, event.getEvent_no());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }

        return result;
    }

    
    public int deleteEvent(int eventNo, Connection conn) {
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            String sql = "DELETE FROM events WHERE event_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, eventNo);

            result = pstmt.executeUpdate();  

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        return result;
    }

    // 참여자 내역
    public List<Map<String, String>> getEventParticipations(Connection conn) {
        List<Map<String, String>> events = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT e.event_no AS 번호, u.user_name AS 이름, e.event_title AS 제목, e.event_progress AS 진행일, p.participate_date AS 참여등록일, p.participate_state AS 상태 " +
                         "FROM events e " +
                         "JOIN participates p ON e.event_no = p.event_no " +
                         "JOIN users u ON u.user_no = p.user_no";

            pstmt = conn.prepareStatement(sql); 
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, String> event = new HashMap<>(); 
                event.put("event_no", rs.getString("번호"));
                event.put("event_title", rs.getString("제목"));
                event.put("event_progress", rs.getString("참여등록일"));
                event.put("participate_date", rs.getString("진행일"));
                event.put("user_name", rs.getString("이름"));
                event.put("participate_state", rs.getString("상태"));
                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return events;
    }
    
}