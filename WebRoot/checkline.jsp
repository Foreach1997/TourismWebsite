<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>�ޱ����ĵ�</title>
<link href="<%=path%>/css/layout.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/css/prompt.css" rel="stylesheet" type="text/css"/>
<link href="<%=path%>/css/nf.lightbox.css" rel="stylesheet" type="text/css" media="screen" />
<script src="<%=path%>/js/jquery-1.3.1.js" type="text/javascript"></script>
<script src="<%=path%>/js/NFLightBox.js" type="text/javascript"></script>
 <style type="text/css">
        #gallery
        {
    
            padding: 10px;
          
        }
        #gallery ul
        {   margin-left:20px;
            background:red;
            list-style: none;
        }
        #gallery ul li
        {
            float: left;
            list-style:none;
            margin-right:28px;
        }
        #gallery ul img
        {
          
           
            border: 1px solid orange;
            border-width: 1px 1px 1px;
        }
        #gallery ul a:hover img
        {
            border-width: 1px 1px 10px;
         
        }
        #gallery ul a:hover
        {
            color: #orange;
        }
 </style>
<style>
#BgDiv{background-color:#e3e3e3; position:absolute; z-index:99; left:0; top:0; display:none; width:100%; height:1000px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
#DialogDiv{position:absolute;width:400px; left:50%; top:50%; margin-left:-200px; height:auto; z-index:100;padding:1px;}
#DialogDiv h2{ height:25px; font-size:14px; background-color:#8FA4F5; position:relative; padding-left:10px; line-height:25px;}
#DialogDiv h2 a{position:absolute; right:5px; font-size:12px; color:#000000}
#DialogDiv .form{padding:10px;}
</style>
 <script>
       $(function() {
     
        var settings = { containerResizeSpeed: 350
            };
            $('#gallery a').lightBox(settings);
        });
           
</script>
<script>

    function ShowDIV(thisObjID) {
    $("#BgDiv").css({ display: "block", height: $(document).height() });
    $("#" + thisObjID ).css("top", "100px");
    $("#" + thisObjID ).css("display", "block");
    document.documentElement.scrollTop = 0;
   }

   function closeDiv(thisObjID) {
    $("#BgDiv").css("display", "none");
    $("#" + thisObjID).css("display", "none");
   }
     //��ӹ��ﳵ���ж��û��Ƿ��¼���δ��¼�����㣬��ʾ�û���Ҫ��¼
    function addCar(id){
	   
        var  account="<%=session.getAttribute("account")%>";
	    if(account=="null"){
	        ShowDIV('DialogDiv');
	    }else{
	         window.location.href="<%=path%>/ShoppingCarManagerServlet?flag=_addCar&lineId="+id;
	    }
    }
    //���㣬�ж��û��Ƿ��¼���δ��¼�����㣬��ʾ�û���Ҫ��¼
    function accounting(id){
      var  account="<%=session.getAttribute("account")%>";
      if(account=="null"){
	        ShowDIV('DialogDiv');
	  }else{
	       window.location.href="<%=path%>/OrderManagerServlet?flag=_place&target=lineOrder&lineId="+id;
	  }
    }
    //�鿴���ﳵ,�ж��û��Ƿ��¼���δ��¼�����㣬��ʾ�û���Ҫ��¼
     function seeCar(){
        var  account="<%=session.getAttribute("account")%>";
        
        if(account=="null"){
           
            ShowDIV('DialogDiv');
        
        }else{
            window.location.href="<%=path%>/ShoppingCarManagerServlet?flag=_seeCar";
        }
     }
    
    window.onload=function(){
          var isHave="<%=request.getAttribute("isHave")%>";
          
          if(isHave!="null"){
            alert(isHave);
          }
    };
    
</script>
</head>

<body>
<!--ͷ��-->
<div id="top-cont">
<div id="top-min">
<div id="min-left"></div>
<div id="min-right"></div>
</div>
</div>
<!--����-->
<div id="menu">
<div id="menu-m">
<ul>
<li><a href="<%=path%>/LineManagerServlet?flag=_showLine">��ҳ</a></li>
<li style="width:8px;"><img src="<%=path%>/images/t1.jpg" width="8" height="42" /></li>
 <c:forEach var="llm" items="${ltl}" begin="0" end="2"  >
           <li><a href="<%=path%>/LineManagerServlet?typeName=${llm.typeName}&flag=_hot&lineTypeId=${llm.lineTypeID}">${llm.typeName}</a></li>
           <li style="width:8px;"><img src="<%=path%>/images/t1.jpg" width="8" height="42" /></li>
  </c:forEach>
<li><a href="<%=path%>/TeamBuyManagerServlet?flag=_hundredRegiments">�Ź�</a></li>
<li><a href="javascript:seeCar()"><img src="<%=path%>/images/che.jpg" width="176" height="42" /></a></li>
</ul>
</div>
</div>
<!--���λͼƬ-->
<div id="banner"><img src="<%=path%>/images/banner.jpg" width="1003" height="93" /></div>

<!--�������ݵ�һ���ֿ�ʼ-->
<div class="jindck">
<c:choose>
<c:when test="${line.teamBuy==1}">
<div class="jindck-meun" style=" background:url(<%=path%>/images/gty.jpg) top right no-repeat; height:63px; font-size:22px;
 font-family:'΢���ź�'; color:#090; font-weight:bold; padding-left:20px; line-height:60px; ">[�Żݶ��+������+���ʷ���]&nbsp;&nbsp;${line.lineName}
</div>
</c:when>
<c:otherwise>
<div class="jindck-meun" style="height:63px; font-size:22px;
 font-family:'΢���ź�'; color:#090; font-weight:bold; padding-left:20px; line-height:60px; ">[�Żݶ��+������+���ʷ���]&nbsp;Ʒ��ȫ&nbsp;${line.lineName}
</div>
</c:otherwise>

</c:choose>

<div class="jin2">
<div class="jin2-left" id="gallery"><img src="<%=path%>/upload/${line.lineID}/${picList.get(0).name}" width="400" height="250" style='padding-bottom: 10px' />
   <ul>
            <c:forEach  var="pic" items="${picList}" begin="1" end="3">
             <li>
                <a href="<%=path%>/upload/${line.lineID}/${pic.name}" title="${pic.introduction}">
                    <img src="<%=path%>/upload/${line.lineID}/${pic.name}" width="100" alt="${pic.introduction}" />
                </a>
             </li>
            </c:forEach>
         
           
        </ul>
</div>
<div class="jin2-right">
<ul>
<c:choose>
<c:when test="${line.teamBuy==1}">
<li>;���мۣ���<c:out value="${fn:substring(line.price,0,fn:indexOf(line.price,'.'))}"/>Ԫ</li>
</c:when>
 <c:otherwise>
 <li>;���мۣ�<strong>��<c:out value="${fn:substring(line.price,0,fn:indexOf(line.price,'.'))}"/>Ԫ</strong></li>
 </c:otherwise>
</c:choose>
<li>���ι��ߣ�${line.vehicle}</li>
<c:if test="${line.teamBuy==1}">
<li>�Ź��ۣ�<strong><c:out value="${fn:substring(line.teamBuyPrice,0,fn:indexOf(line.teamBuyPrice,'.'))}"/>Ԫ</strong></li>
<li>�Żݣ�<strong><c:out value="${fn:substring(line.price-line.teamBuyPrice,0,fn:indexOf(line.price-line.teamBuyPrice,'.'))}"/>Ԫ</strong></li>
</c:if>
<li>����������${line.days}��</li>
<li>��������������<span>${count}</span>�˳��δ���·</li>
<li>��ǰ������������ǰһ�챨��</li>

<li style="margin-top:18px">
 <a href="javascript:addCar('${line.lineID}')"><img src="<%=path%>/images/jgwc.jpg" width="122" height="42" /></a>
 <a href="javascript:accounting('${line.lineID}')"><img src="<%=path%>/images/js.jpg" width="123" height="43" style="margin-left:100px"/></a>
</li>
</ul>
</div>
</div>
<div class="tuijian">
<div class="tuijian-m">�Ƽ�����</div>
<div class="tuijian-inf">
<ul>
<li>${line.reason}</li>
</ul>
</div>
<div class="tuijian-t">�г̰���</div>
<div class="tuijian-inf">
<ul>
<li>${line.arrange}</li>
</ul>
</div>
</div>
<div class="jianjie">
<div class="jianjie-m">��·���</div>
<div>${line.introduction}</div>
</div>
<div class="tuijian">
  <div class="tuijian-m">��ܰ��ʾ</div>
  <div class="tuijian-inf">
    <ul>
      <li> �ڳ���ʱ���ܺø��˵�Ǯ�ƣ�֤��ע������ȫ </li>
      <li> ���ع���ʱ�����ؿ��ǣ����պ�������۸������Ҫ��Ʊ�� </li>
      <li> ����֪ͨ�����ڳ���ǰ1�췢�ͣ�������ǰȷ�������ǽ����һʱ��֪ͨ���� </li>
      <li> ���ι����У�������˷���������˷���Ŀ�������ۿۼ�Ϊ���ݣ������Թ��Ƽ�Ϊ׼�� </li>
      <li> �������������Ե�����Ʊ����ͨ�۸�ȣ����������ʵ�ʼ۸���㡣 </li>
    </ul>
  </div>
</div>
</div>
<!--�������ݵ�һ���ֽ���-->
<!--�ײ�-->
<div id="foot">
<div id="foot-t"><p>���֤��ţ�WE125482154 ��ICP��125478966</p>
<p><a href="#">��˽����</a> | <a href="#">��ƸӢ��</a> | <a href="#">��������</a> | <a href="#">��վ��ͼ</a> | <a href="#">��������</a> | <a href="#">�������</a></p>
</div>
</div>
<div id="BgDiv"></div>
  <!--���ֲ���ʾ��DIV1-->
  <div id="DialogDiv" style="display:none">
    <div class="box6">
         <div onclick="closeDiv('DialogDiv')" style="position:relative;left:266px">�ر�</div>
       <h1>������ϵͳ��ܰ��ʾ��</h1>   
       <img src="<%=path%>/images/alter.jpg"/>
       <p>�Բ��𣬵�¼�����ſ���ʹ�ù��ﳵ����</p>
       <div class="box6_corner_lf"></div>
       <div class="box6_corner_rt"></div>
    </div>   
  </div>
</body>
</html>
