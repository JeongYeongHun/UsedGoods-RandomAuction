<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Admin</title>
</head>
<body>
    <script>
        document.write("신고 내역<br><br>");
    </script>
    
    <%
        int intTime = 0;        
        int intPrice = 0;       
        String bidID = "";     

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
    
            String sql = "";  
            
            //신고내역 출력
            sql = "select * from report";         
            pstmt = conn.prepareStatement(sql);   
            rs = pstmt.executeQuery();         
                
            %>
            <script>
                document.write("<table border = 1 cellpadding = 5>");
                document.write("<tr>");
                document.write("<td>신고 유저</td>");
                document.write("<td>대상 유저</td>");
                document.write("<td>내용</td>");
                document.write("</tr>");
               
            </Script>
            <%
            while(rs.next())  
            {
                String id = rs.getString("ID");    
                String target_id = rs.getString("TARGET_ID");
                String contents = rs.getString("CONTENTS");
                %>
                <script>
                    document.write("<tr>");
                    document.write("<td><%=id%></td>");
                    document.write("<td><%=target_id%></td>");
                    document.write("<td><%=contents%></td>");
                    document.write("</tr>");
                </script>
                 <%
            }
            %>
            <script>
                document.write("</table>");
            </script>
            <%
                    pstmt.close();
                    sql = "update time_info set timeint = timeint - 1";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.executeUpdate();
                    conn.commit();

                    rs.close();
                    pstmt.close();
                    sql = "select * from time_info";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    rs.next();
                    intTime = rs.getInt("TIMEINT");
                    intPrice = rs.getInt("PRICE");
                    bidID = rs.getString("ID");

                    //받아온 시간값이 0이하일 경우. 즉,경매가 종료되는 시점
                    if(intTime <= 0){
                        int counter = 0;    
                        int unum = 0;     
                        

                        //아무도 입찰을 하지 않은 경우. 경매 기본 시작가가 1000원이기 때문
                        if(intPrice == 1000){   
                            pstmt.close();
                            sql = "update auction_count set count = count + 1";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.executeUpdate();

                            rs.close();
                            pstmt.close();
                            sql = "select * from auction_count";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            rs.next();
                            counter = rs.getInt("COUNT");

                            pstmt.close();
                            sql = "update item set inumber=?,status=0 where status=2";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1,counter);
                            pstmt.executeUpdate();
                        }
                        else{   //누군가 입찰을 한 경우
                            pstmt.close();
                            sql = "update user_info set balance=balance-? where id=?";  
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1,intPrice);
                            pstmt.setString(2,bidID);
                            pstmt.executeUpdate();

                            pstmt.close();
                            sql = "update item set price=?,buyer=?,auc_date=(select TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL),status=1 where status=2";   
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1,intPrice);
                            pstmt.setString(2,bidID);
                            pstmt.executeUpdate();

                            conn.commit();
                        }

                        rs.close();
                        pstmt.close();
                        sql = "select inumber from item where status=0 order by inumber";   
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();
                        if(rs.next()){
                            unum = rs.getInt("INUMBER");
                        }
                        else{
                            %>
                            <script>
                                window.open("about:blank","_self").close();
                            </script>
                            <%
                        }
                        
                        pstmt.close();
                        sql = "update item set status=2 where inumber=?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1,unum);
                        pstmt.executeUpdate();
                        
                        try {

                            Thread.sleep(5000);
                      
                      } catch (InterruptedException ex) { }

                      pstmt.close();
                      sql = "update time_info set timeint = 600,price = 1000,id='없음'";
                      pstmt = conn.prepareStatement(sql);
                      pstmt.executeUpdate();
                      conn.commit();
                    }

                    try {

                        Thread.sleep(834);
                  
                  } catch (InterruptedException ex) { }
                  
            }catch(Exception e){
                e.printStackTrace();
            }finally{
                if(rs!=null)try{rs.close();}catch(SQLException sqle){}
                if(pstmt!=null)try{pstmt.close();}catch(SQLException sqle){}
                if(conn!=null)try{conn.close();}catch(SQLException sqle){}
            }
      %>
      <script>
          history.go(0);
      </script>

</body>
</html> 