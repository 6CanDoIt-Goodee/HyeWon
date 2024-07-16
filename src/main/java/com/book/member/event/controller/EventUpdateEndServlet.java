package com.book.member.event.controller;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.commit;
import static com.book.common.sql.JDBCTemplate.getConnection;
import static com.book.common.sql.JDBCTemplate.rollback;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.book.member.event.dao.EventDao;
import com.book.member.event.vo.Event;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/event/updateEnd")
public class EventUpdateEndServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EventUpdateEndServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // doGet에서는 일반적으로 처리할 내용이 없으므로, POST 메서드로만 처리합니다.
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // URL에서 eventNo와 eventType을 가져옵니다.
        int eventNo = Integer.parseInt(request.getParameter("eventNo")); 
        String eventType = request.getParameter("eventType");

        // 파일 업로드 관련 처리
        if (ServletFileUpload.isMultipartContent(request)) {
            String dir = request.getServletContext().getRealPath("/upload/event");
            int maxSize = 1024 * 1024 * 10; // 10MB
            String encoding = "UTF-8";
            DefaultFileRenamePolicy dfr = new DefaultFileRenamePolicy();
            MultipartRequest mr = new MultipartRequest(request, dir, maxSize, encoding, dfr);

            // Event 객체 생성 및 데이터 설정
            Event event = new Event();
            event.setEvent_no(eventNo);
            event.setEv_form(Integer.parseInt(eventType));

            if ("1".equals(eventType)) {
                String oriName = mr.getOriginalFileName("eventimage1");
                String reName = mr.getFilesystemName("eventimage1");
                event.setEv_title(mr.getParameter("eventTitle1"));
                event.setEv_start(mr.getParameter("startDate1"));
                event.setEv_end(mr.getParameter("endDate1"));
                event.setEv_content(mr.getParameter("eventContent1"));
                event.setOri_image(oriName);
                event.setNew_image(reName);
                event.setEvent_category(Integer.parseInt(mr.getParameter("eventCategory1")));
            } else if ("2".equals(eventType)) {
                String oriName = mr.getOriginalFileName("eventimage2");
                String reName = mr.getFilesystemName("eventimage2");
                event.setEv_title(mr.getParameter("eventTitle2"));
                event.setEv_start(mr.getParameter("startDate2"));
                event.setEv_end(mr.getParameter("endDate2"));
                event.setEv_progress(mr.getParameter("progressDate2"));
                event.setEv_content(mr.getParameter("eventContent2"));
                event.setOri_image(oriName);
                event.setNew_image(reName);
                event.setEvent_category(Integer.parseInt(mr.getParameter("eventCategory2")));
                event.setEvent_quota(Integer.parseInt(mr.getParameter("eventQuota2")));
            }

            // 데이터베이스 처리를 위한 연결과 DAO 호출
            Connection conn = getConnection();
            EventDao eventDao = new EventDao();
            int result = eventDao.updateEvent(event, conn);
            close(conn);

            // 결과에 따라 커밋 또는 롤백을 수행하고 연결을 닫습니다.
            if (result > 0) {
                commit(conn);
                // 수정된 이벤트의 상세 페이지로 리다이렉트합니다.
                response.sendRedirect(request.getContextPath() + "/event/detail?eventNo=" + eventNo);
            } else {
                rollback(conn);
                // 수정에 실패한 경우 수정 페이지로 다시 이동합니다.
                response.sendRedirect(request.getContextPath() + "/event/update?eventNo=" + eventNo + "&eventType=" + eventType);
            }
        } else {
            // 파일 업로드가 아닌 경우에는 이벤트 수정 페이지로 다시 이동합니다.
            response.sendRedirect(request.getContextPath() + "/event/update?eventNo=" + eventNo + "&eventType=" + eventType);
        }
    }
}
