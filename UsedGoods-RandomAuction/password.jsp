<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
<title>비밀번호 찾기</title>
</head>
<body>
    <script>
        var returnValue

        function fail(){
           returnValue = alert("회원정보가 없습니다.");
           document.write(returnValue);
           history.back();
        }

        function find(){
            history.back();
        }

    </script>

  <%
  //비밀번호찾기를 눌렀을 경우 데이터베이스와 비교하여 비밀번호를 알려주는 부분
    String strUsername=request.getParameter("username");
    String strPersonalNum=request.getParameter("personalNum");
    String strEmail=request.getParameter("email");

    Connection conn   = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try{
        String jdbcUrl  = "";
        String dbId  = "";
        String dbPass = "";
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);

        String sql = "select id,password,ssn,email from user_info";   
        pstmt = conn.prepareStatement(sql);   
        rs = pstmt.executeQuery();   
            
        int temp = 0;
        String pass = " ";

        while(rs.next()){    
            String rs_id = rs.getString("ID");
            String rs_pass = rs.getString("PASSWORD");
            String rs_ssn = rs.getString("SSN");
            String rs_email = rs.getString("EMAIL");
            if(rs_id.equals(strUsername) == true && rs_ssn.equals(strPersonalNum) == true && rs_email.equals(strEmail) == true){
                temp = 1;
                pass = rs_pass;
                break;
                }
            }
        
        if(temp == 1){
            %>
            <script>
                document.write(alert("비밀번호는 <%=pass%> 입니다."));
                find();
            </script>
            <%
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