<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
<title>회원가입 완료</title>
</head>
<body>
    <script>
        var returnValue

        function cpass(){
           returnValue = alert("비밀번호가 일치하지 않습니다.");
           document.write(returnValue);
           history.back();
        }

        function succ(){
            returnValue = alert("회원가입 완료");
            document.write(returnValue);
            location.href = "index.html";
        }

        function id_over(){
            returnValue = alert("이미 사용중인 ID 입니다.");
            document.write(returnValue);
            history.back();
        }
    </script>

  <%
  //회원가입하기를 눌렀을 경우 데이터베이스와 비교하고 데이터베이스에 등록하는 부분
    String strUsername=request.getParameter("username");
    String strPassword=request.getParameter("password");
    String strCpassword=request.getParameter("cpassword");
    String strName=request.getParameter("name");
    String strPersnoalNum=request.getParameter("personalNum");
    String strAddress=request.getParameter("address");
    String strPhoneNum=request.getParameter("phoneNum");
    String strEmail=request.getParameter("email");
    String strAccount=request.getParameter("account");
    String strBank=request.getParameter("bank");
    int balance = 0;

    Connection conn   = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try{
        String jdbcUrl  = "";
        String dbId  = "";
        String dbPass = "";
        
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);

        if(strPassword.equals(strCpassword) == false){
            %>
            <script>
               cpass();
            </script>
        <%
        }
        else{
            String sql = "select id from user_info";     
            pstmt = conn.prepareStatement(sql);  
            rs = pstmt.executeQuery();   
            
            int temp = 0;

            while(rs.next()){   
                String rs_id = rs.getString("ID");

                if(rs_id.equals(strUsername) == true){
                    temp = 1;
                    break;
                    
                }
            }

            if(temp == 0){
                pstmt.close();
                sql = "insert into user_info values (?,?,?,?,?,?,?,?,?,?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,strUsername);
                pstmt.setString(2,strPassword);
                pstmt.setString(3,strName);
                pstmt.setString(4,strPersnoalNum);
                pstmt.setString(5,strAddress);
                pstmt.setString(6,strPhoneNum);
                pstmt.setString(7,strEmail);
                pstmt.setString(8,strAccount);
                pstmt.setString(9,strBank);
                pstmt.setInt(10,balance);
                pstmt.executeUpdate();
                %>
                <script>
                     succ();
                 </script>
             <%
            }
            else if(temp == 1){
            %>
                <script>
                    id_over();
                </script>
            <%
            }
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