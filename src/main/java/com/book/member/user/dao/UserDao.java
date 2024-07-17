package com.book.member.user.dao;

import static com.book.common.sql.JDBCTemplate.close;
import static com.book.common.sql.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.book.member.user.vo.User;

public class UserDao {
	public static int createUser(User u) {
		PreparedStatement pstmt = null;
		Connection conn = getConnection();
		int result = 0;
		try {
			String sql = "INSERT INTO `users`(user_name,user_id, user_pw,user_email,user_nickname,is_verified) VALUES(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getUser_name());
			pstmt.setString(2, u.getUser_id());
			pstmt.setString(3, u.getUser_pw());
			pstmt.setString(4, u.getUser_email());
			pstmt.setString(5, u.getUser_nickname());
			pstmt.setBoolean(6, false);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn);
			close(pstmt);
		}
		return result;	
	}

	public boolean verifyUser(String email) {
		PreparedStatement pstmt = null;
		Connection conn = getConnection();
		boolean isVerified = false;
		try {
			 String sql = "UPDATE users SET is_verified = ? WHERE user_email = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setBoolean(1, true);
	            pstmt.setString(2, email);
	            int rowsUpdated = pstmt.executeUpdate();
	            if (rowsUpdated > 0) {
	                isVerified = true;
	            }
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn);
			close(pstmt);
		}
		return isVerified;
	}
	
	public User loginUser(String id, String pw) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn =getConnection();
		User u=null;
		try {
			String sql = "SELECT * FROM `users` WHERE user_id=? AND user_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				u = new User(
						rs.getInt("user_no"),
						rs.getString("user_name"),
						rs.getString("user_id"),
						rs.getString("user_pw"),
						rs.getString("user_email"),
						rs.getString("user_nickname"),
						rs.getInt("user_active"),
						rs.getBoolean("is_verified"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn);
			close(rs);
			close(pstmt);
		}
		return u;
	}
	
	public User checkpw(String pw) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn =getConnection();
		User u=null;
		try {
			String sql = "SELECT * FROM `users` WHERE user_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				u = new User(
						rs.getInt("user_no"),
						rs.getString("user_name"),
						rs.getString("user_id"),
						rs.getString("user_pw"),
						rs.getString("user_email"),
						rs.getString("user_nickname"),
						rs.getInt("user_active"),
						rs.getBoolean("is_verified"));			
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn);
			close(rs);
			close(pstmt);
		}
		return u;
	}
	
	public int editUser(int no,String pw, String name, String nickname, String email) {
		PreparedStatement pstmt = null;
		Connection conn =getConnection();
		int result = 0;
		try {
			String sql = "UPDATE `users` set user_pw=?,user_email=?, user_name=?,user_nickname=? WHERE user_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,pw);
			pstmt.setString(2,email);
			pstmt.setString(3, name);
			pstmt.setString(4, nickname);
			pstmt.setInt(5, no);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn);
			close(pstmt);
		}
		return result;
	}
	

	public User getUserByNameAndEmail(String name, String email) throws SQLException {
        PreparedStatement pstmt = null;
        Connection conn = getConnection();
        String query = "SELECT * FROM users WHERE user_name = ? AND user_email = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            User u = new User(
                    rs.getInt("user_no"),
                    rs.getString("user_name"),
                    rs.getString("user_id"),
                    rs.getString("user_pw"),
                    rs.getString("user_email"),
                    rs.getString("user_nickname"),
                    rs.getInt("user_active"),
                    rs.getBoolean("is_verified"));
            return u;
        } else {
            return null;
        }
    }
}