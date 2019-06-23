<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
<meta charset="EUC-KR">

<title>물품 정보</title>
</head>
<body>
    <%
    //경매화면에서 ? 마크를 눌렀을 경우 표시되는 물품의 정보를 작성하는 부분
    Connection conn   = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try{
      String jdbcUrl  = "";
      String dbId  = "";
      String dbPass = "";
      
      Class.forName("oracle.jdbc.driver.OracleDriver");
      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);

      String sql = "select info, inumber, seller from item where status=2";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      rs.next();
      String strText = rs.getString("INFO");
      String strInumber = rs.getString("INUMBER");
      String strSeller = rs.getString("SELLER");

      out.println("물품 번호 : " + strInumber);
      %>
      <br>
      <%
      out.println("판매자 : " + strSeller);
      %>
      <br>
      <br>
      <%
      out.println("설명 : " + strText);
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