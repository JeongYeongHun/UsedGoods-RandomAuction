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
            <li class="loginfo_id">���̵� : <%=strUsername%></li>
            <li class="loginfo_balance">�� �� : <%=intAccount%> ��</li>
            <li class="loginfo"><a href="index.html" target="_self">�α׾ƿ�</a></li>
        </ul>
    </div>
        
    <ul class="nav-side">
        <li>MENU</li>
        <li> <a href="auction.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-bank"></i> �����</a> </li>
        <li> <a href="register_stuff.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-plus"></i> ��ǰ ���</a> </li>
        <li> <a href="auction_history.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-folder"></i> ��� ����</a> </li>
        <li> <a href="report.jsp?strUsername=<%=strUsername%>&intAccount=<%=intAccount%>">
            <i class="fa fa-fw fa-twitter"></i> �Ű��ϱ�</a> </li>
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

    <!--������ ����--> 
    
    <div class="form">
        <div class="form-panel one">
            <div class="form-header">
                <h3>Q&A</h3>
            </div>
            <ul class="accordion">
                <li>
                    <a>Q. ��Ŵ� � ������� �̷��������?</a>
                    <p>
                        A. Auction�� ������ ������ ���� ������ �ϳ��� �ΰ� ���ѵ� �ð��ȿ� �ǽð����� ���� ����ڵ��� 
                        ��ſ� �����ϴ� ������� �̷�����ϴ�. ���ǵ��� ��� ������ ��� ��ǰ ��ϼ����� 
                        ����Ǹ� ��Ŵ� ������ 1,000���������� ���۵˴ϴ�. ��Ű� ���۵� �Ŀ��� �����ϱ� ��ư��
                        ���� 1,000���� �������� �ö󰡰� �Ǹ� ���ÿ� ��� ���� �ð��� 10�� �߰��˴ϴ�. ��� ���� �ð���
                        �� �� �� ���� �ְ� �������� ������ ����ڰ� ������ �ްԵǸ� �� ���ǿ� ���� �ŷ� ������ ��� �˴ϴ�.
                        �� �Ŀ� �Ǹ��ڿ� ��� �����ڰ� �����Ͽ� ���������� ������ �ŷ��� �̷������ �����Դϴ�.
                        <br>
                        <br>
                        �ŷ� ���� : ��ǰ ��� �� ��� �� ���� �� �ŷ� Ȯ�� �� �Ǹſ� ����
                    </p>
                </li>
                <li>
                    <a>Q. �ܾ� ������ ��� �ϳ���?</a>
                    <p>
                        A. ȸ������ �� �� �Է��ߴ� ���¸� �̿��Ͽ� 123-45678-99-4989 �������� �Ա����ֽø� 
                        �Ա��� �ݾ׸�ŭ ������ �帳�ϴ�. 
                    </p>
                </li>
                <li>
                    <a>Q. �Ű� ó���� ��� �̷��������?</a>
                    <p>
                        A. �Ű��ϱ� ���������� �Ű� ����ڿ� �Ű����� �ۼ��Ͽ� ���� ���ֽø� �����ڰ� �Ǵ��Ͽ� 
                        �Ű� ����ڿ��� ������ ���ϰų� ���� ��ġ�� ���ص帳�ϴ�.
                    </p>
                </li>
            </ul>
            <div>
                �ٸ� ���� ������ �ִٸ� tvstar1448@gmail.com �� ���� �ֽñ� �ٶ��ϴ�.
            </div>
        </div>
    </div>

    <!--���ڵ�� �Խ���-->

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
    
    /********�޴� ������ ���ϸ��̼�*********/
    
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