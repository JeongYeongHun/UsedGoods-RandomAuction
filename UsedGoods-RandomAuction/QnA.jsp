<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
<meta charset="EUC-KR">

<title>Q&A</title>

<link rel="stylesheet" href="frame.css">
<link rel="stylesheet" href="form.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

<style>
    .accordion 
    {
        list-style:none;padding:0;   
        max-width: 560px;
        margin: 50px auto 50px auto;
        border-top: 2px solid rgb(255,200,0);
    }
    .accordion li 
    {
        list-style:none;
        border-bottom: 2px solid rgb(255,200,0);
        position: relative;
    }
    .accordion li p 
    {
        display: none;
        padding: 10px 25px 30px;
        color: black;
    }
    .accordion a 
    {
        width: 100%;
        display: block;
        cursor: pointer;
        font-weight: 600;
        line-height: 3;
        font-size: 15px;
        text-indent: 15px;
        user-select: none;
        color:black;
        text-decoration:none 
    }
    
    .accordion a:after {
        width: 8px;
        height: 8px;
        border-right: 2px solid rgb(255,200,0);
        border-bottom: 2px solid rgb(255,200,0);
        position: absolute;
        right: 10px;
        content: " ";
        top: 17px;
        transform: rotate(-45deg);
        -webkit-transition: all 0.2s ease-in-out;
        -moz-transition: all 0.2s ease-in-out;
        transition: all 0.2s ease-in-out;
    }
    .accordion p {
        font-size: 13px;
        line-height: 2;
        padding: 10px;
    }
    
    a.active:after {
        transform: rotate(45deg);
        -webkit-transition: all 0.2s ease-in-out;
        -moz-transition: all 0.2s ease-in-out;
        transition: all 0.2s ease-in-out;
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

    <!--페이지 내용--> 
    
    <div class="form">
        <div class="form-panel one">
            <div class="form-header">
                <h3>Q&A</h3>
            </div>
            <ul class="accordion">
                <li>
                    <a>Q. 경매는 어떤 방식으로 이루어지나요?</a>
                    <p>
                        A. Auction은 한정된 정보의 랜덤 물건을 하나씩 두고 제한된 시간안에 실시간으로 여러 사용자들이 
                        경매에 참가하는 방식으로 이루어집니다. 물건들의 경매 순서는 경매 물품 등록순으로 
                        진행되며 경매는 입찰가 1,000원에서부터 시작됩니다. 경매가 시작된 후에는 입찰하기 버튼을
                        통해 1,000원씩 입찰가가 올라가게 되며 동시에 경매 진행 시간도 10초 추가됩니다. 경매 제한 시간이
                        다 될 때 까지 최고 입찰가를 제시한 사용자가 낙찰을 받게되며 그 물건에 대한 거래 권한을 얻게 됩니다.
                        그 후에 판매자와 경매 낙찰자가 조율하여 최종적으로 물건의 거래가 이루어지는 형식입니다.
                        <br>
                        <br>
                        거래 순서 : 물품 등록 → 경매 → 낙찰 → 거래 확인 → 판매와 구매
                    </p>
                </li>
                <li>
                    <a>Q. 잔액 충전은 어떻게 하나요?</a>
                    <p>
                        A. 회원가입 할 때 입력했던 계좌를 이용하여 123-45678-99-4989 농협으로 입금해주시면 
                        입금한 금액만큼 충전해 드립니다. 
                    </p>
                </li>
                <li>
                    <a>Q. 신고 처리는 어떻게 이루어지나요?</a>
                    <p>
                        A. 신고하기 페이지에서 신고 대상자와 신고내용을 작성하여 제출 해주시면 관리자가 판단하여 
                        신고 대상자에게 제제를 가하거나 법적 조치를 취해드립니다.
                    </p>
                </li>
            </ul>
            <div>
                다른 문의 사항이 있다면 tvstar1448@gmail.com 로 문의 주시길 바랍니다.
            </div>
        </div>
    </div>

    <!--아코디언 게시판-->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> 
    <script>
    (function($) {
        $('.accordion > li:eq(false) a').addClass('active').next().slideDown();

        $('.accordion a').click(function(j) {
            var dropDown = $(this).closest('li').find('p');

            $(this).closest('.accordion').find('p').not(dropDown).slideUp();

            if ($(this).hasClass('active')) {
                $(this).removeClass('active');
               
            } else {
                $(this).closest('.accordion').find('a.active').removeClass('active');
                $(this).addClass('active');
              
            }

            dropDown.stop(false, true).slideToggle();

            j.preventDefault();
        });
    })(jQuery);
    </script>


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
    
    /********메뉴 아이콘 에니메이션*********/
    
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