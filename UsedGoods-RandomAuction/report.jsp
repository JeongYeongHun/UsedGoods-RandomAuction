<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
<meta charset="EUC-KR">

<title>�Ű� �ϱ�</title>

<link rel="stylesheet" href="frame.css">
<link rel="stylesheet" href="form.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

<style>
    .noresize 
    {
        resize: none;       /* ũ�� ���� ���� �Ұ� */
        resize: vertical;   /* ���ϸ� ���� */
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

    <!--�Ű� �ϱ� ������ ����--> 
    
    <div class="form">
        <div class="form-panel one">
            <div class="form-header">
                <h3>�Ű� �ϱ�</h3>
            </div>
        <div class="form-content">
            <form name = "report" action = "report_submit.jsp" method="POST">
                <div class="form-group">
                    <label for="target_username">�Ű��� �����</label>
                    <input type="text" id="target_username" name="target_username" required="required" placeholder="���̵� �Է��� �ּ���" autocomplete="off">
                </div>
                <div class="form-group">
                    <label for="contents">�Ű� ����</label>
                    <textarea class = "noresize" rows="5" cols = "30" id="contents" name="contents" required="required"></textarea>
                </div>
                <div>
                    <input type="hidden" id="username" name="username" value="<%=strUsername%>">
                </div>
                <!--�Ű�����??-->
                <br>
                <br>
                <div class="form-group">
                    <button type="submit">�Ű�</button> <!--�Ű��� ����-->
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
    
    /********�޴� ������ Ŭ���� ��ȯ*********/
    
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