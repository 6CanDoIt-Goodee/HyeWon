package com.book.admin.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class GetEventRegular implements Job {

    @Override
    public void execute(JobExecutionContext arg0) throws JobExecutionException {
        Connection conn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        try {
            String sql = "SELECT n.notification_no, n.user_no, n.event_no, n.is_sent, " +
                    "e.event_title, e.event_start, e.event_quota, " +
                    "u.user_email " +
                    "FROM event_notifications n " +
                    "JOIN events e ON n.event_no = e.event_no " +
                    "JOIN users u ON n.user_no = u.user_no " +
                    "WHERE n.is_sent = 0";  // 아직 전송되지 않은 알림만 선택

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("notification_no", rs.getInt("notification_no"));
                map.put("user_no", rs.getInt("user_no"));
                map.put("event_no", rs.getInt("event_no"));
                map.put("is_sent", rs.getInt("is_sent"));
                map.put("event_title", rs.getString("event_title"));
                map.put("event_start", rs.getString("event_start"));
                map.put("event_quota", rs.getInt("event_quota"));
                map.put("user_email", rs.getString("user_email"));

                String content = String.format("%s 이벤트의 선착순 등록이 1시간 후 시작됩니다!", rs.getString("event_title"));
                map.put("content", content);
                result.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
            close(conn);
        }

        // 가져온 데이터가 현재 시간과 일치하는지 확인
        if (result.size() != 0) {
			/* System.out.println("알림 : " + result.size()); */
            for (int i = 0; i < result.size(); i++) {
                String eventStartStr = (String) result.get(i).get("event_start");
                LocalDateTime eventStart = LocalDateTime.parse(eventStartStr);
                
                // 모집 시작 시간 -1시간, 초단위 0
                LocalDateTime target = eventStart.minusHours(1).withSecond(0).withNano(0);
                // 현재 시간을 초를 0으로 설정
                LocalDateTime now = LocalDateTime.now().withSecond(0).withNano(0); 
                
                // target 시간과 now 시간 일치 확인
                if (now.isEqual(target)) {
                    int eventNo = (int) result.get(i).get("event_no");
                    int notificationNo = (int) result.get(i).get("notification_no");
                    String userEmail = (String) result.get(i).get("user_email");
                    String content = (String) result.get(i).get("content");

                    try {
                        sendEmail(userEmail, "이벤트 알림", content);
                        updateNotificationStatus(notificationNo); 
                    } catch (Exception e) { 
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    private void sendEmail(String to, String subject, String content) throws MessagingException { 
        String from = "rlaalswo6789@naver.com"; 
        Properties properties = System.getProperties();
 
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.host", "smtp.naver.com"); // SMTP 서버 호스트 수정 
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
         
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("rlaalswo6789@naver.com", "kimminjae5615!@");
            }
        }); 
          
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(content);
        Transport.send(message);
        System.out.println("알림 이메일 전송 성공");

        Transport.send(message);
    }

    private void updateNotificationStatus(int notificationNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
            String sql = "UPDATE event_notifications SET is_sent = 1 WHERE notification_no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notificationNo);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(pstmt);
            close(conn);
        }
    }
}