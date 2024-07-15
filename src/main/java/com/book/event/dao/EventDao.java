package com.book.event.dao;

import static com.book.common.sql.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.book.event.vo.Event;

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
	
	public List<Event> selectEventList(Event option, Connection conn) {
		List<Event> list = new ArrayList<Event>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try { 
			String sql = "SELECT * FROM `events`";
			if(option.getEv_title() != null) {
				sql += " WHERE board_title LIKE CONCAT('%', '" +  option.getEv_title() + "', '%')";
			}
			sql += " LIMIT "+option.getLimitPageNo()+", "+option.getNumPerPage();
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Event resultVo = new Event(rs.getInt("event_no"),
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
						rs.getInt("event_quota"));
				list.add(resultVo);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		System.out.println(list);
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
            String sql = "SELECT * FROM events WHERE event_no = ?";
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
                                  rs.getInt("event_quota"));
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
