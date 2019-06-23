<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
    <meta charset="EUC-KR">

    <title>물품 등록</title>

    <link rel="stylesheet" href="frame.css">
    <link rel="stylesheet" href="form.css">
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
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
    
    <!--매뉴 아이콘-->
    <div id="page-content-wrapper">
      <button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas"> 
        <span class="hamb-top"></span> 
        <span class="hamb-middle"></span> 
        <span class="hamb-bottom"></span> 
      </button>
    </div>    
  </div>

  <!--물품 등록 폼 --> 
	<div class="form">
		<div class="form-panel one">
		  <div class="form-header">
  			<h3>물품 등록</h3>
		  </div>
		  <div class="form-content">
        <form action="register_stuff_submit.jsp" method="POST">   
			    <div class="form-group">
				    <label for="username">물품 이름</label>
				    <input type="text" id="name" name="name" required="required" autocomplete="off">
			    </div>
			    <div class="form-group">
            <label for="info">물품 설명</label>
            <textarea rows="5" cols = "30" id="val" name="val" required="required" placeholder="물품에 대해 간단한 설명을 해주세요"></textarea>
			    </div>
			    <br>
			    <br>
			    <div class="form-group">
            <input type="hidden" id="strUsername" name="strUsername" value="<%=strUsername%>">
				    <button type="submit">등록</button>
			    </div>
			  </form>
		  </div>
		</div>
  </div>
      
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