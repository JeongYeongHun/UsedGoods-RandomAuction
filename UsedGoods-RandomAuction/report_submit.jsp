<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
    <title>�Ű� �Ϸ�</title>
    <script>
        var returnValue

        function succ(){
            returnValue = alert("�Ű� �Ϸ�");
            document.write(returnValue);
            history.back(0);
        }
    </script>
</head>
<body>
  <%
  //�Ű��ư�� ������ ��� �����ͺ��̽��� ����ϴ� �κ�
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