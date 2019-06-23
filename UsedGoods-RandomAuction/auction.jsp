<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Auction</title>
    
    <link rel="stylesheet" href="frame.css">
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <style>
    
    .stuff
    {
        text-align: center;
        padding-top: 140px;
        margin-bottom: 140px;
        margin-top: -30px;
    }
    .stuff-status
    {
        font-size: 35px;
        color:white;
        text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px rgb(255, 170, 0),
             0 0 70px rgb(255, 170, 0), 0 0 80px rgb(255, 170, 0), 0 0 100px rgb(255, 180, 0), 0 0 150px rgb(255, 190, 0);
        margin-bottom: 10px;
    }
    .stuff-time
    {
        font-size: 25px;
        color:red;
        margin: 15px;
    }
    .stuff-image
    {
        margin: 20px;
        cursor: pointer;
        display:inline-block;
        opacity: 1;
        transition: 0.5s;
    }
    .stuff-image:hover
    {
        opacity: 1;
        transition: 0.5s;
    }
    .stuff-price
    {
        font-size: 40px;
        color:springgreen;
        margin-top: -5px;
    }
    h4
    {
        color:white;
        font-size: 20px;
    }
    h5
    {
        color:white;
        font-size: 18px;
        padding: 10px;
        background: linear-gradient(rgba(0,0,0,0.8), rgba(50,50,50,0.8));
        border-radius: 5px;
        border: 1px solid #444;
        display: inline-block;
    }

    /***********�����ϱ� ��ư****************/
    
    .bid 
    {
      text-align: center;
      margin: 20px;
    }
  
    .bid form {
      display: inline-block;
    }
    
    .bid button {
      background: #111;
      background: linear-gradient(#1b1b1b, #111);
      box-sizing: content-box;
      border: 1px solid #444;
      border-radius: 5px;
      color: #fff;
      display: block;
      font-size: 18px;
      font-weight: 400;
      height: 38px;
      line-height: 40px;
      margin-bottom: -10px;
      padding: 20px;
      position: relative;
      text-shadow: 0 -1px 0 #000;
      width: 80px;
    }

    .bid button:hover
    {
      animation: glow 800ms ease-out infinite alternate;
      background: #222922;
      background: linear-gradient(#333933, #222922);
      border-color:rgb(255, 200, 0);
      box-shadow: 0 0 5px rgba(255, 200, 0, .2), inset 0 0 5px rgba(255, 200, 0, .1), 0 2px 0 #000;
      color: #efe;
      outline: none;
    }

    .bid button:focus
    {
      outline: none;
    }
    
    @keyframes glow   /*��ư hover�� ��¦�̴� ȿ��*/
    {
      0% 
      {
        border-color: rgb(255, 180, 0);
        box-shadow: 0 0 5px rgba(255, 255, 0, .2), inset 0 0 5px rgba(255, 255, 0, .1), 0 2px 0 #000;
      }
      100% 
      {
        border-color: rgb(255, 215, 0);
        box-shadow: 0 0 20px rgba(255, 255, 0, .6), inset 0 0 10px rgba(255, 255, 0, .4), 0 2px 0 #000;
      }
    }
    
    .nav-bottom
    {
      position: absolute;
      margin-bottom: 0;
      width: 100%;
      height: 150px;
      background-color:rgba(50,50,50,0.5);
      box-shadow:0px 1px 5px rgba(0,0,0,0.4);
      text-align: center;
      color: white;
    }
    
    .money-L
    {
      position: absolute;
      left: 670px;
      top : 500px;
      z-index: 1000;
      display: none;
    }

    .money-R
    {
      position: absolute;
      left: 1100px;
      top : 500px;
      z-index: 1000;
      display: none;
    }

    
    </style>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
    <script type="text/javascript">
      var auto_refresh = setInterval(function ()
      {
        $('#timer').load('auction.jsp #timer').fadeIn("slow");
        $('#price_div').load('auction.jsp #price_div').fadeIn("slow");
        $('#bid_div').load('auction.jsp #bid_div').fadeIn("slow");
      }, 1000); // ���ΰ�ħ �ð� 1000�� 1�ʸ� �ǹ��մϴ�.
    </script>
</head>
<body>
  <%
    String strBid=request.getParameter("bid");
    String strUsername=(String)session.getAttribute("strUsername");
    int intAccount = 0;
    String strName = "";

    int intTime = 0;    
    int price = 0;
    String bidID ="";
    
    int min = 0;
    int sec = 0;
    String fsec = "";

    Connection conn   = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try{
      //DB ������ ���� ���� ����
      String jdbcUrl  = "";
      String dbId  = "";
      String dbPass = "";
      
      Class.forName("oracle.jdbc.driver.OracleDriver");
      conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);

      //������ ������ �޾ƿ��� ���� ������
      String sql = "select id,name,balance from user_info";     
      pstmt = conn.prepareStatement(sql);  
      rs = pstmt.executeQuery();    
      
      while(rs.next()){    
          String rs_id = rs.getString("ID");
          strName = rs.getString("NAME");
          intAccount = rs.getInt("BALANCE");
          if(rs_id.equals(strUsername) == true){
              break;
          }
      }
      
      //�ð� ���� �޾ƿ��� ���� ������
      rs.close();
      pstmt.close();
      sql = "select * from time_info";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      rs.next();
      intTime = rs.getInt("TIMEINT");
      price = rs.getInt("PRICE");
      bidID = rs.getString("ID");
       
      min = intTime / 60;
      sec = intTime % 60;

      fsec = String.format("%02d",sec);
      try 
      {
        Thread.sleep(100);
      } 
      catch (InterruptedException ex) { } 
      
      //�����ϱ� ��ư�� ������ �� ���� ��������� �Ǵ�
      if(strBid.equals("1") && intAccount >= (price+1000)){
        //�����ϱ� ��ư�� ������ �� �ð� ������ ���� ������
        pstmt.close();
        sql = "update time_info set timeint = timeint+10,price = price+1000,id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1,strUsername);
        pstmt.executeUpdate();
        conn.commit();

        //�ٽ� �ð� ���� �޾ƿ����� ����
        rs.close();
        pstmt.close();
        sql = "select * from time_info";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
 
        strBid = "0";          
      }

      //�����ϱ� ��ư�� ������ �� ���� ������� ���� ���
      if(strBid.equals("1") && intAccount < (price+1000)){
        %>
        <script>
          var returnValue = alert("�ܾ��� �����մϴ�.");
          document.write(returnValue);
        </script>
       <%
        strBid = "0";
      }

      }catch(Exception e){
          e.printStackTrace();
      }finally{
          if(rs!=null)try{rs.close();}catch(SQLException sqle){}
          if(pstmt!=null)try{pstmt.close();}catch(SQLException sqle){}
          if(conn!=null)try{conn.close();}catch(SQLException sqle){}
      }
  %>

    <!--������ ����-->
    
    <!--��� ��-->

    <div class="nav-top">
      <ul>
        <li class="title"><button type="button" onclick="location.href='auction.jsp'">Auction</button></li>
        <li class="loginfo_id">���̵� : <%=strUsername%></li>
        <li class="loginfo_balance">�� �� : <%=intAccount%> ��</li>
        <li class="loginfo"><a href="index.html" target="_self">�α׾ƿ�</a></li>
      </ul>
    </div>

    <!--�޴� ��-->
    
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
  
    <!--�޴� ������-->
    <div id="page-content-wrapper">
      <button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas"> 
        <span class="hamb-top"></span> 
        <span class="hamb-middle"></span> 
        <span class="hamb-bottom"></span> 
      </button>
    </div> 

    <!--���� �������� ��� ��ǰ ����-->
   
    <div id="acutionName" class ="stuff">
      <div class="stuff-status">
        �����
      </div>
      <div id="bid_div">
        <h5>���� ������ : <%=bidID%></h5>
      </div>
      <div id="image_div" class="stuff-image">
        <a href="#" onclick="window.open('stuff_info.jsp','popup',
         'width=500,height=350,left=220,top=250, scrollbars=no, resizable=no, toolbars=no')">
         <img src="question_mark.gif" title ="��ǰ ���� ����"></a>
      </div>
      <div id="timer" class="stuff-time">
        ��� ������� <%=min%>:<%=fsec%>
      </div>
      <div>
        <h4>���� ������</h4>
      </div>
      <div id="price_div" class="stuff-price">
        <%=price%> ��
      </div>
      <div id="submit_div">
        <section class="bid">
          <form action="auction.jsp" method="POST">
            <input type="hidden" id="bid" name="bid" value="1"/>             
            <button type="submit">�����ϱ�</button>
          </form>
        </section>
      </div>
      <div>
        <h6 style = "color:rgb(255,200,0)">���� �������� 1,000���� ���� �����մϴ�</h6>
      </div>
    </div>

    <div class="money-L">
      <img src="money.gif" style="width:130px; height: 130px;">
    </div>
    <div class="money-R">
      <img src="money.gif" style="width:130px; height: 130px;">
    </div>

    <!--����Ʈ ������ ��Ÿ���� �ϴ� ��-->

    <div class = "nav-bottom">
      <br>
      &lt; SITE INFO &gt;
      <br>
      <br>
      Company : ������ & ������
      <br>
      TEL : 051 - 865 - 4989
      <br>
      Address : �λ걤���� �λ����� ������ 176 �������а� 916
    </div>

    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script> 
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> 
    <script>
  
    /*********�޴� ������ ���ϸ��̼�************/

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
      
      /****�����ϱ� �ִϸ��̼�****/
      
      moneyL = $('.money-L');
      moneyR = $('.money-R');
      var right = true;
    
      $('.bid button').click(function() 
      {
        if(right == true)
        {
          right = false;
          $('.money-R').animate(
          {
            moneyR : 'show',
            top : '200px'
          }, 
          {
            duration : 700,
            complete : function() { $('.money-R').animate( {moneyR : 'hide', top : '500px'},10 ); }
          });
          
        }
        else
        {
          right = true;
          $('.money-L').animate(
          {
            moneyL : 'show',
            top : '200px'
          }, 
          {
            duration : 700,
            complete : function() { $('.money-L').animate( {moneyL : 'hide', top : '500px'},10 ); }
          });
        }
      });
    });

    </script>
</body>
</html> 