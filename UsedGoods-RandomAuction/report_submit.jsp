<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
    <title>신고 완료</title>
    <script>
        var returnValue

        function succ(){
            returnValue = alert("신고 완료");
            document.write(returnValue);
            history.back(0);
        }
    </script>
</head>
<body>
  <%
  //신고버튼을 눌렀을 경우 데이터베이스에 등록하는 부분
    String strUsername = request.getParameter("username");
    String strTarget_username = request.getParameter("target_username");
    String strContents = request.getParameter("contents");

    Connection conn   = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try
    {
        String jdbcUrl  = "";
        String dbId  = "";
        String dbPass = "";
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);

        String sql = "insert into report values (?,?,?)";  
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1,strUsername);
        pstmt.setString(2,strTarget_username);
        pstmt.setString(3,strContents);
    
        pstmt.executeUpdate();
        conn.commit();
        
        %>
        <script>
            succ();
        </script>
        <%
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        if(rs!=null)try{rs.close();}catch(SQLException sqle){}
        if(pstmt!=null)try{pstmt.close();}catch(SQLException sqle){}
        if(conn!=null)try{conn.close();}catch(SQLException sqle){}
    }
  %>
</body>
</html> 