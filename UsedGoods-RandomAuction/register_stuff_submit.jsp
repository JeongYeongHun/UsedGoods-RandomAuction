<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
    <meta charset="EUC-KR">
    <title>물품 등록</title>
</head>
<body>
<%
//물품 등록하기 버튼을 눌렀을 경우 데이터베이스에 동작하는 부분
    String strName = request.getParameter("name");
    String strVal = request.getParameter("val");
    String strUsername = request.getParameter("strUsername");

    Connection conn   = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try{
      String jdbcUrl  = "";
      String dbId  = "";
      String dbPass = "";
      
      Class.forName("oracle.jdbc.driver.OracleDriver");
      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);

      String sql = "";
      int counter = 0;

      sql = "update auction_count set count = count + 1";
      pstmt = conn.prepareStatement(sql);
      pstmt.executeUpdate();

      pstmt.close();
      sql = "select * from auction_count";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      rs.next();
      counter = rs.getInt("COUNT");

      pstmt.close();
      sql = "insert into item values (?,0,?,?,0,?,'admin',(select TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL),'0000-00-00')";
      pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1,counter);
      pstmt.setString(2,strName);
      pstmt.setString(3,strVal);
      pstmt.setString(4,strUsername);
      pstmt.executeUpdate();
      conn.commit();
%>
        <script>
            returnValue = alert("물품 등록 완료");
            document.write(returnValue);
            history.back(0);
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