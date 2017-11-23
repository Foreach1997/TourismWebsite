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
<title>��ҳ</title>
<link href="<%=path%>/css/layout.css" rel="stylesheet" type="text/css"/>
<link href="<%=path%>/css/prompt.css" rel="stylesheet" type="text/css"/>
<!--�������ֲ�-->
<style>
#BgDiv{background-color:#e3e3e3; position:absolute; z-index:99; left:0; top:0; display:none; width:100%; height:1000px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
#DialogDiv{position:absolute;width:400px; left:50%; top:50%; margin-left:-200px; height:auto; z-index:100; padding:1px;}
#DialogDiv h2{ height:25px; font-size:14px; background-color:#8FA4F5; position:relative; padding-left:10px; line-height:25px;}
#DialogDiv h2 a{position:absolute; right:5px; font-size:12px; color:#000000}
#DialogDiv .form{padding:10px;}
</style>
<script src="<%=path%>/js/jquery-1.3.1.js" type="text/javascript"></script>
<script src="<%=path%>/js/index.js" type="text/javascript"></script>
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

function seeCar(){
	   
    var  account="<%=session.getAttribute("account")%>";
    if(account=="null"){
        ShowDIV('DialogDiv');
    }else{
        window.location.href="<%=path%>/ShoppingCarManagerServlet?flag=_seeCar";
    }
 }
 function historyOrder(){
	    var  account="<%=session.getAttribute("account")%>";
	    if(account=="null"){
	        ShowDIV('DialogDiv');
	    }else{
	        window.location.href="<%=path%>/OrderManagerServlet?flag=_history";
	    }
	 
 }
</script>
</head>

<body >
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
<div id="banner"> <img src="<%=path%>/images/banner.jpg" width="1003" height="93" /></div>

<!--�������ݵ�һ���ֿ�ʼ-->
<div id="content1">
<!--���-->
<div id="con1-left">
<div class="con1-1"><a href="<%=path%>/LineManagerServlet?typeName=${ltl.get(0).typeName}&flag=_hot&lineTypeId=${ltl.get(0).lineTypeID}">${ltl.get(0).typeName}</a></div>
<div class="cs">
<ul>
<c:forEach var="line" items="${llList.get(0)}">
<li><a href="LineManagerServlet?lineId=${line.lineID}&flag=_specific">${line.lineName}</a></li>
</c:forEach>
</ul>
</div>
<div class="con1-2"><a href="<%=path%>/LineManagerServlet?typeName=${ltl.get(1).typeName}&flag=_hot&lineTypeId=${ltl.get(1).lineTypeID}">${ltl.get(1).typeName}</a></div>
<div class="cs">
<ul>
<c:forEach var="line" items="${llList.get(1)}">
<li><a href="LineManagerServlet?lineId=${line.lineID}&flag=_specific">${line.lineName}</a></li>
</c:forEach>
</ul>
</div>
<div class="con1-3"><a href="<%=path%>/LineManagerServlet?typeName=${ltl.get(2).typeName}&flag=_hot&lineTypeId=${ltl.get(2).lineTypeID}">${ltl.get(2).typeName}</a></div>
<div class="cs">
<ul>
<c:forEach var="line" items="${llList.get(2)}">
<li><a href="<%=path%>/LineManagerServlet?lineId=${line.lineID}&flag=_specific">${line.lineName}</a></li>
</c:forEach>
</ul>
</div>
<div class="con1-4"><a href="<%=path%>/LineManagerServlet?typeName=${ltl.get(3).typeName}&flag=_hot&lineTypeId=${ltl.get(3).lineTypeID}">${ltl.get(3).typeName}</a></div>
<div class="cs">
<ul>
<c:forEach var="line" items="${llList.get(3)}">
<li><a href="<%=path%>/LineManagerServlet?lineId=${line.lineID}&flag=_specific">${line.lineName}</a></li>
</c:forEach>
</ul>
</div>
</div>
<!--�Ҳ�-->
<div id="con1-right">
<div id="right-top">
<div class="banner"><img src="<%=path%>/images/tg.jpg" width="540" height="240" /></div>
<div class="zcdl">
<ul>
<li style="margin-right:3px;"><a href="<%=path%>/login.jsp">
   <img src="<%=path%>/images/dl.jpg" width="85" height="36" /></a></li>
<li><a href="<%=path%>/register.jsp"><img src="<%=path%>/images/zc.jpg" width="85" height="36" /></a></li>
</ul>
</div>
<div class="my">
<ul>
<li><span class="myd">100%</span></li>
<li class="xt">����<span class="rs"><font size="4">${count}</font></span>��ͨ��;���г���</li>
<li class="cls"><a href="javascript:historyOrder()">�鿴��ʷ����</a></li>
</ul>
</div>
</div>
<div id="right-btm">
<div class="tgj"><span></span></div>
<div class="tgjlx">
<ul style="width:1446px">
<c:forEach  var="teamLine" items="${t4tll}" varStatus="timmer">
  <li><a href="<%=path%>/LineManagerServlet?lineId=${teamLine.lineID}&flag=_specific">
  <img src="<%=path%>/upload/${teamLine.lineID}/${picList.get(timmer.index).name}" width="160" height="88" />
     ${teamLine.lineName}</a><br />
  <span>��<c:out value="${fn:substring(teamLine.teamBuyPrice,0,fn:indexOf(teamLine.teamBuyPrice,'.'))}"/>Ԫ
  </span>ԭ��<c:out value="${fn:substring(teamLine.price,0,fn:indexOf(teamLine.price,'.'))}"/>Ԫ</li>
</c:forEach>
</ul>
</div>
</div>
</div>
</div>
<!--�������ݵ�һ���ֽ���-->
<!--�������ݵڶ����ֿ�ʼ-->
<div id="con-2">
<!--��࿪ʼ-->
<div id="con-2left">
<div id="con-2left1">
<div class="con-21"></div>
<div class="jingdian">
<ul>
<c:forEach  var="line" items="${odll}">
<li><a href="<%=path%>/LineManagerServlet?lineId=${line.lineID}&flag=_specific">${line.lineName}</a></li>
</c:forEach>
</ul>
</div>
<div class="con-22"></div>
<div class="jingdian">
<ul>
<c:forEach  var="line" items="${tdll}">
<li><a href="<%=path%>/LineManagerServlet?lineId=${line.lineID}&flag=_specific">${line.lineName}</a></li>
</c:forEach>
</ul>
</div>
<div class="con-23"></div>
<div class="jingdian">
<ul>
<c:forEach  var="line" items="${thdll}">
<li><a href="<%=path%>/LineManagerServlet?lineId=${line.lineID}&flag=_specific">${line.lineName}</a></li>
</c:forEach>
</ul>
</div>
<c:forEach var="line" items="${hostLineList}" varStatus="timmer">
<div class="picj">
  
   <div  onmouseover="this.style.cursor='pointer'" onclick="window.location.href='<%=path%>/LineManagerServlet?lineId=${line.lineID}&flag=_specific'" 
   style="width:248px;height:94px;background:url('<%=path%>/upload/${line.lineID}/${hpicList.get(timmer.index).name}')">
  
       <div style="width:100px;height:45px;background:green;position:relative;left:147px;top:52px">
           <div style="position:relative;left:10px;top:-5px;padding-top:2px">
             <span style="font-size:16px;color:yellow;">
              ${line.lineName}
              <strong><c:out value="${fn:substring(line.price,0,fn:indexOf(line.price,'.'))}"/></strong>
             </span>
             <span style="color:yellow;">Ԫ/ÿ��</span>
          </div>
       </div>
   </div>
 
</div>
</c:forEach>
</div>
</div>
<!--������-->
<!--�Ҳ࿪ʼ-->
<div id="con-2right">
    <c:forEach var="ltl" items="${ltl}" begin="0" end="1">
           <c:set  var="id" value="${ltl.lineTypeID}"/>
    </c:forEach>
   <iframe src="LineManagerServlet?lineTypeID=<c:out value="${id}"/>&flag=_partLine" width="720px" height="705px" frameborder="0"></iframe>
</div>
</div>
<!--�������ݵڶ����ֽ���-->
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
       <h1>;������������ܰ��ʾ��</h1>   
       <img src="<%=path%>/images/alter.jpg"/>
       <p>�Բ��𣬵�¼�����ſ���ʹ�ôι���</p>
       <div class="box6_corner_lf"></div>
       <div class="box6_corner_rt"></div>
    </div>   
  </div>
</body>
</html>
