package com.book.member.event.dao;

import static com.book.common.sql.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.book.member.event.vo.Event;

public class EventDao {
	public int createEvent(Event event, Connection conn) {
		System.out.println("Event Category: " + event.getEvent_category());
		System.out.println("Event Title: " + event.getEv_title());
        System.out.println("Event Content: " + event.getEv_content());
        System.out.println("Event Form: " + event.getEv_form());
        System.out.println("Event Progress: " + event.getEv_progress());
        System.out.println("Event Start: " + event.getEv_start());
        System.out.println("Event End: " + event.getEv_end());
        System.out.println("Event Original Image: " + event.getOri_image());
        System.out.println("Event New Image: " + event.getNew_image()); 
        System.out.println("Event Quota: " + event.getEvent_quota());
        
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			String sql = "INSERT INTO `events` (event_title, event_content, event_form, event_progress, event_start, event_end, event_ori_image, event_new_image, event_category_no, event_quota) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
                pstmt.setNull(10, 0);
            } 
            result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	
	public List<Map<String, String>> selectEventList(Event option, Connection conn) {
	    List<Map<String, String>> list = new ArrayList<>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try { 
	        String sql = "SELECT e.event_no AS 번호, e.event_title AS 제목, e.event_regdate AS 등록일, e.event_form AS 유형, c.event_category_name AS 카테고리명 " +
	                     "FROM `events` e " +
	                     "JOIN `event_category` c ON e.event_category_no = c.event_category_no";
	        if(option.getEv_title() != null) {
	            sql += " WHERE e.event_title LIKE CONCAT('%', ?, '%')";
	        }
	        sql += " ORDER BY e.event_no ASC LIMIT ?, ?";
	        
	        pstmt = conn.prepareStatement(sql);
	        int paramIndex = 1;
	        if (option.getEv_title() != null) {
	            pstmt.setString(paramIndex++, option.getEv_title());
	        }
	        pstmt.setInt(paramIndex++, option.getLimitPageNo());
	        pstmt.setInt(paramIndex, option.getNumPerPage());

	        rs = pstmt.executeQuery();
	        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
	        
	        while (rs.next()) {
	            Map<String, String> row = new HashMap<>();
	            row.put("event_no", rs.getString("번호"));
	            row.put("event_title", rs.getString("제목"));
	            row.put("event_regdate", outputFormat.format(originalFormat.parse(rs.getString("등록일"))));
	            row.put("event_form", rs.getString("유형"));
	            row.put("event_category_name", rs.getString("카테고리명"));
	            list.add(row);
	        } 
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	    }
	    return list;
	}


	
	public int selectEventCount(Event option, Connection conn) { 
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT COUNT(*) AS cnt FROM `events`";
			if(option.getEv_title() != null) {
				sql += " WHERE event_title LIKE CONCAT('%','"+option.getEv_title()+"','%')";
			}
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return result; 
	}
	
	
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
                                  rs.getString("event_category_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }

        return event;
    }
	
}
