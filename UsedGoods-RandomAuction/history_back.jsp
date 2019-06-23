<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
    <meta charset="EUC-KR">
    <title>back</title>
    <script>
        var returnValue;
    </script>
</head>
<body>
    <%
        String type=request.getParameter("type");
        String num=request.getParameter("num");
        String strUsername=request.getParameter("strUsername");
        int number = Integer.parseInt(num);
        int intAccount = 0;

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
            int counter = 0;

            //낙찰 받은 물품을 거래확인 버튼을 누를 경우
            if(type.equals("ok")){
                sql = "update item set status = 3 where inumber=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,number);
                pstmt.executeUpdate();

                pstmt.close();
                sql = "select price,seller from item where inumber=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,number);
                rs = pstmt.executeQuery();
                rs.next();
                int ok_price = rs.getInt("PRICE");
                String ok_seller = rs.getString("SELLER");
                
                pstmt.close();
                sql = "update user_info set balance=balance+? where id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,ok_price);
                pstmt.setString(2,ok_seller);
                pstmt.executeUpdate();

                conn.commit();
                %>
                <script>
                    returnValue = alert("최종 구매를 성공했습니다.");
                    document.write(returnValue);
                </script>
                <%
            }

            //낙찰 받은 물품을 낙찰 취소할 경우
            if(type.equals("re")){
                sql = "select price,buyer from item where inumber=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,number);
                rs = pstmt.executeQuery();
                rs.next();
                int re_price = rs.getInt("PRICE");
                String re_buyer = rs.getString("BUYER");
                int temp = (re_price / 20);
                re_price = re_price - temp;

                pstmt.close();
                sql = "update user_info set balance=balance+? where id=?";  
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,re_price);
                pstmt.setString(2,re_buyer);
                pstmt.executeUpdate();

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
                sql = "update item set status=0,auc_date='0000-00-00',buyer='admin',price=0,inumber=? where inumber=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,counter);
                pstmt.setInt(2,number);
                pstmt.executeUpdate();

                conn.commit();
                %>
                <script>
                    returnValue = alert("낙찰이 취소 되었습니다. \n낙찰을 취소하여 수수료 5%를 제외한 금액을 돌려드립니다.");
                    document.write(returnValue);
                </script>
                <%
            }

            //물품 등록을 취소할 경우
            if(type.equals("cancel")){
                sql = "delete from item where inumber=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1,number);
                pstmt.executeUpdate();
                conn.commit();
                %>
                <script>
                    returnValue = alert("물품 등록이 취소 되었습니다.");
                    document.write(returnValue);
                </script>
                <%
            }

            rs.close();
            pstmt.close();
            sql = "select balance from user_info where id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,strUsername);
            rs = pstmt.executeQuery();
            rs.next();
            intAccount = rs.getInt("BALANCE");

             }catch(Exception e){
                e.printStackTrace();
            }finally{
                if(rs!=null)try{rs.close();}catch(SQLException sqle){}
                if(pstmt!=null)try{pstmt.close();}catch(SQLException sqle){}
                if(conn!=null)try{conn.close();}catch(SQLException sqle){}
            }
      %>
      <script>
          location.href='auction_history.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>';
      </script>
</body>
</html> 