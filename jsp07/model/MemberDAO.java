package web.jsp07.model;

import java.awt.datatransfer.SystemFlavorMap;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
		//네번째
	//커넥션 메서드 : 내부에서만 사용할거라 private 접근제어자 붙힘
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
		
	}

	
	
	
	//회원가입
	public void insertMember(MemberDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			String sql = "insert into users values(?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			//DB순서대로 작성
			pstmt.setString(1,dto.getId());
			pstmt.setString(2,dto.getPw());
			pstmt.setString(3,dto.getName());
			pstmt.setString(4,dto.getEmail());
			pstmt.setString(5,dto.getBirth());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
			
		}
	}
		
	//id pw 일치하는지 확인 메서드
	public boolean idPwCheck(String id, String pw) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from users where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2,pw);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	
	
	// 회원 1명의 전체정보 가져오기
	public MemberDTO getUser (String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO dto = null;
		
		try {
			conn = getConnection();
			String sql = "select * from users where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO(); //객체생성
				dto.setId (rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setBirth(rs.getString("birth"));
				dto.setReg(rs.getTimestamp("reg"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return dto;
	}
	
	
	//회원 정보 수정 
	public int updateUser(MemberDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = -1;
		
		try {
			conn = getConnection();
			String sql = "update users set birth=?, email=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getBirth());
			pstmt.setString(2,dto.getEmail());
			pstmt.setString(3,dto.getId());
			
			result = pstmt.executeUpdate();
			
			 System.out.println("dao result: " + result);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	
	//회원 탈퇴
	public int deleteUser(String id, String pw) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			//id pw 확인 처리
			String sql = "select pw from users where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			
			rs = pstmt.executeQuery(); //result가 -1 나왓다면 if문도 못탄것이다.
			if(rs.next()) {//id,pw 일치
				String dbpw=rs.getString("pw"); //db에서 해당 id의 pw꺼내서 변수에 저장
				if(dbpw.equals(pw)) {//db상의 pw와 사용자가 입력한 pw가 동일하면
					//회원탈퇴 로직 처리
					sql = "delete from users where id = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,id);
					result = pstmt.executeUpdate();// result가 삭제 잘 되면1, 안되면 0
					}else {//비번 안맞으면 0
					result = 0;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		System.out.println("dao delete result : " + result);
		return result;
	}
	
	// 아이디 중복 여부 확인 메서드
	
	public boolean confirmId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			conn=getConnection();
			String sql = "select id from users where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
			return result;
	}
	
	

	
	
	
	
	
	
		
	
	
	
	
}
