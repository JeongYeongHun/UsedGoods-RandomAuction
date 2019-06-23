<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
<meta charset="EUC-KR">
    <title>경매 내역</title>

    <link rel="stylesheet" href="frame.css">
    <link rel="stylesheet" href="form.css">
    <link rel="stylesheet" href="tab.css">
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <style>
        .form
        {
            width: 1300px;
        }
        td
        {
            font-size: 15px;
        }
        tr
        {
            height: 43.5px;
        }
    </style>
</head>
<body>
    <%
    String strUsername=request.getParameter("strUsername");
    String intAccount=request.getParameter("intAccount");
    %>
    <div class="nav-top">
        <ul>
          <li class="title"><button type="button" onclick="location.href='auction.jsp'">Auction</button></li>
          <li class="loginfo_id">아이디 : <%=strUsername%></li>
          <li class="loginfo_balance">잔 액 : <%=intAccount%> ￦</li>
          <li class="loginfo"><a href="index.html" target="_self">로그아웃</a></li>
        </ul>
    </div>
  
    
    <ul class="nav-side">
        <li>MENU</li>
        <li> <a href="auction.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-bank"></i> 경매장</a> </li>
        <li> <a href="register_stuff.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-plus"></i> 물품 등록</a> </li>
        <li> <a href="auction_history.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-folder"></i> 경매 내역</a> </li>
        <li> <a href="report.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-twitter"></i> 신고하기</a> </li>
        <li> <a href="QnA.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-file-o"></i> Q&A</a> </li>
    </ul> 
            
    <div id="page-content-wrapper">
        <button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas">
            <span class="hamb-top"></span> 
            <span class="hamb-middle"></span> 
            <span class="hamb-bottom"></span>
        </button>
    </div>
    
    <!--경매 내역 정보-->

    <%
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
                
    %>

    <div class="form">
        <div class="form-panel one">
            <div class="form-header">
                <h3>경매 내역</h3>
            </div>
            <div class='tab'>
                <input type='radio' name='a' id='tabOne' tabindex="1" checked>
                <input type='radio' name='a' id='tabTwo' tabindex="2">       
                <input type='radio' name='a' id='tabThree' tabindex="3">
            <div class="tab-nav">
                <label for='tabOne'>낙찰 받은 물품</label>            
                <label for='tabTwo'>경매 등록 물품</label>
                <label for='tabThree'>경매 완료 물품</label>
            </div>
                <div class='tab-content tab-one'>  <!--낙찰 받은 물품 정보-->
                    <table class='table'>
                        <tr>
                            <td>물품 번호</td>
                            <td>물품 이름</td>
                            <td>낙찰가</td>
                            <td>경매 날짜</td>
                            <td>판매자</td>
                            <td>거래 확인</td>
                        </tr>
                        <%
                            sql = sql.format(Locale.US, "select * from item where buyer = '%s' and status = 1 order by inumber", strUsername); 
                            pstmt = conn.prepareStatement(sql);  
                            rs = pstmt.executeQuery();       
                            
                            while(rs.next())
                            {
                                String inumber = rs.getString("INUMBER");
                                String name = rs.getString("NAME");
                                String price = rs.getString("PRICE");

                                String auc_date = rs.getString("AUC_DATE");
                                String seller = rs.getString("SELLER");
                        %>
                        <tr>
                            <td><%=inumber%></td>
                            <td><%=name%></td>
                            <td><%=price%></td>
                            <td><%=auc_date%></td>
                            <td><%=seller%></td>
                            <td><button onclick="location.href='history_back.jsp?type=ok&num=<%=inumber%>&strUsername=<%=strUsername%>'">구매</button>
                                <button onclick="location.href='history_back.jsp?type=re&num=<%=inumber%>&strUsername=<%=strUsername%>'">취소</button></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </div>
                <div class='tab-content tab-two'>  <!--경매 등록 물품 정보-->
                    <table class='table'>
                        <tr>
                            <td>물품 번호</td>
                            <td>물품 이름</td>
                            <td>경매 대기 순서</td>
                            <td>등록 날짜</td>
                            <td>등록 취소</td>
                        </tr>
                        <%
                            rs.close();
                            pstmt.close();
                            sql = "select count(*) as count from item where status=0";
                            pstmt = conn.prepareStatement(sql);    
                            rs = pstmt.executeQuery();   
                            rs.next();
                            int allcount = rs.getInt("COUNT");

                            rs.close();
                            pstmt.close();
                            sql = "select inumber from item where status=0 order by inumber";
                            pstmt = conn.prepareStatement(sql);  
                            rs = pstmt.executeQuery();             
                            int i=0;
                            int allnumber[] = new int[allcount];
                            while(rs.next()){
                                allnumber[i] = rs.getInt("INUMBER");
                                i = i + 1;
                            }
                            int count=i+1;

                            rs.close();
                            pstmt.close();
                            sql = sql.format(Locale.US, "select * from item where seller = '%s' and status = 0 order by inumber", strUsername); 
                            pstmt = conn.prepareStatement(sql);    
                            rs = pstmt.executeQuery();       

                            int chk = 1;

                            while(rs.next())
                            {
                                chk = 1;
                                int inumber = rs.getInt("INUMBER");
                                String name = rs.getString("NAME");
                                int turn = 0;
                                String reg_date = rs.getString("REG_DATE");

                                for(i=0; i < count; i++){
                                    if(allnumber[i] != inumber){
                                        chk = chk + 1;
                                    }
                                    else{
                                        turn = chk;
                                        break;
                                    }
                                }
                        %>
                        <tr>
                            <td><%=inumber%></td>
                            <td><%=name%></td>
                            <td><%=turn%></td>
                            <td><%=reg_date%></td>
                            <td><button onclick="location.href='history_back.jsp?type=cancel&num=<%=inumber%>&strUsername=<%=strUsername%>'">취소</button></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </div>
                <div class='tab-content tab-three'>  <!--판매 완료 물품 정보-->     
                    <table class='table'>
                        <tr>
                            <td>물품 번호</td>
                            <td>물품 이름</td>
                            <td>낙찰가</td>
                            <td>경매 날짜</td>
                            <td>구매자</td>
                            <td>거래 상태</td>
                        </tr>
                        <%
                            //판매 완료 물품 정보를 조회하기 위한 쿼리
                            rs.close();
                            pstmt.close();
                            sql = sql.format(Locale.US, "select * from item where seller = '%s' and (status = 1 or status = 3) order by inumber", strUsername);   
                            pstmt = conn.prepareStatement(sql);   
                            rs = pstmt.executeQuery();          

                            
                            while(rs.next())
                            {
                                String inumber = rs.getString("INUMBER");
                                String name = rs.getString("NAME");
                                String price = rs.getString("PRICE");

                                String auc_date = rs.getString("AUC_DATE");
                                String buyer = rs.getString("BUYER");
                                String status = "";

                                if(rs.getInt("STATUS") == 1)
                                    status = "미확인";
                                else if(rs.getInt("STATUS") == 3)
                                    status = "판매 완료";
                        %>
                        <tr>
                            <td><%=inumber%></td>
                            <td><%=name%></td>
                            <td><%=price%></td>
                            <td><%=auc_date%></td>
                            <td><%=buyer%></td>
                            <td><%=status%></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </div>   
            </div>
        </div>       
    </div>

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

    <script>
        function button_buy(str)
        {
            alert("구매 완료");


        }
    </script>

    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script> 
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> 
    <script>
        
        /*********메뉴 아이콘 에니메이션************/
        $(document).ready(function () 
        {
            var trigger = $('.hamburger'),
            overlay = $('.overlay'),
            isClosed = false;

            trigger.click(function () 
            {
            hamburger_cross();      
            });

            function hamburger_cross() 
            {
                if (isClosed == true) 
                {          
                    overlay.hide();
                    trigger.removeClass('is-open');
                    trigger.addClass('is-closed');
                    $('.nav-side').removeClass('active');
                    isClosed = false;
                } 
                else 
                {   
                    overlay.show();
                    trigger.removeClass('is-closed');
                    trigger.addClass('is-open');
                    $('.nav-side').addClass('active');
                    isClosed = true;
                }
            }

            $('[data-toggle="offcanvas"]').click(function () 
            {
                $('#wrapper').toggleClass('toggled');
            });  
        });
    </script>
</body>
</html>