<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
    <title>로그인</title>
</head>
<body>
    <script>
        var returnValue

        function fail(){
           returnValue = alert("회원정보가 없습니다.");
           document.write(returnValue);
           history.back();
        }
        

    </script>
  <%
  //로그인 버튼을 눌렀을 경우 데이터베이스와 비교하는 부분
    String strUsername=request.getParameter("username");
    String strPassword=request.getParameter("password");

    Connection conn   = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try{
        String jdbcUrl  = "";
        String dbId  = "";
        String dbPass = "";
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);

        String sql = "select id,password from user_info";      
        pstmt = conn.prepareStatement(sql);   
        rs = pstmt.executeQuery();      
            
        int temp = 0;

        while(rs.next()){    
            String rs_id = rs.getString("ID");
            String rs_pass = rs.getString("PASSWORD");
            if(rs_id.equals(strUsername) == true && rs_pass.equals(strPassword) == true){
                temp = 1;
                break;
            }
        }
        
        if(temp == 1){
            if(strUsername.equals("admin")==true){
                response.sendRedirect("admin.jsp");
            }
            else{
                session.setAttribute("strUsername", strUsername);
                response.sendRedirect("auction.jsp");  
            }
        }
        else{
            %>
            <script>
                fail();
            </script>
            <%
        }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(rs!=null)try{rs.close();}catch(SQLException sqle){}
            if(pstmt!=null)try{pstmt.close();}catch(SQLException sqle){}
            if(conn!=null)try{conn.close();}catch(SQLException sqle){}
        }
  %>
</body>
</html> 