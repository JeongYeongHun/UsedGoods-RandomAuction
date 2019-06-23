<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
<meta charset="EUC-KR">

<title>신고 하기</title>

<link rel="stylesheet" href="frame.css">
<link rel="stylesheet" href="form.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

<style>
    .noresize 
    {
        resize: none;       /* 크기 임의 변경 불가 */
        resize: vertical;   /* 상하만 가능 */
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

    <!--신고 하기 페이지 내용--> 
    
    <div class="form">
        <div class="form-panel one">
            <div class="form-header">
                <h3>신고 하기</h3>
            </div>
        <div class="form-content">
            <form name = "report" action = "report_submit.jsp" method="POST">
                <div class="form-group">
                    <label for="target_username">신고할 사용자</label>
                    <input type="text" id="target_username" name="target_username" required="required" placeholder="아이디를 입력해 주세요" autocomplete="off">
                </div>
                <div class="form-group">
                    <label for="contents">신고 내용</label>
                    <textarea class = "noresize" rows="5" cols = "30" id="contents" name="contents" required="required"></textarea>
                </div>
                <div>
                    <input type="hidden" id="username" name="username" value="<%=strUsername%>">
                </div>
                <!--신고종류??-->
                <br>
                <br>
                <div class="form-group">
                    <button type="submit">신고</button> <!--신고내용 접수-->
                </div>
            </form>
        </div>
    </div>

    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script> 
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> 
    <script>
    $(document).ready(function () {
        var trigger = $('.hamburger'),
            overlay = $('.overlay'),
        isClosed = false;
    
        trigger.click(function () {
            hamburger_cross();      
        });
    
    /********메뉴 아이콘 클릭시 변환*********/
    
        function hamburger_cross() {
    
            if (isClosed == true) {          
            overlay.hide();
            trigger.removeClass('is-open');
            trigger.addClass('is-closed');
            $('.nav-side').removeClass('active');
            isClosed = false;
            } else {   
            overlay.show();
            trigger.removeClass('is-closed');
            trigger.addClass('is-open');
            $('.nav-side').addClass('active');
            isClosed = true;
            }
        }
        
        $('[data-toggle="offcanvas"]').click(function () {
            $('#wrapper').toggleClass('toggled');
        });  
    });
    
    </script>
    
</body>
</html>