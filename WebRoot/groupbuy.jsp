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
<title>�Ź���Ϣ</title>
<link href="<%=path%>/css/layout.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/css/prompt.css" rel="stylesheet" type="text/css" />
<style>
#BgDiv{background-color:#e3e3e3; position:absolute; z-index:99; left:0; top:0; display:none; width:100%; height:1000px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
#DialogDiv{position:absolute;width:400px; left:50%; top:50%; margin-left:-200px; height:auto; z-index:100; padding:1px;}
#DialogDiv h2{ height:25px; font-size:14px; background-color:#8FA4F5; position:relative; padding-left:10px; line-height:25px;}
#DialogDiv h2 a{position:absolute; right:5px; font-size:12px; color:#000000}
#DialogDiv .form{padding:10px;}
</style>
<script src="<%=path%>/js/jquery-1.3.1.js" type="text/javascript"></script>
<script>
  function seeCar(){
	   
    var  account="<%=session.getAttribute("account")%>";
    if(account=="null"){
        ShowDIV('DialogDiv');
    }else{
        window.location.href="ShoppingCarManagerServlet?flag=_seeCar";
    }
 }
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
<div id="banner"><img src="<%=path%>/images/tgg1.jpg" width="1003" height="190" /></div>
<!--�������ݵ�һ���ֿ�ʼ-->
<div class="tuangouy" style="overflow: hidden">
<ul>
<c:forEach var="team" items="${atlList}" varStatus="timmer">
<li>
<div><a href="<%=path%>/LineManagerServlet?lineId=${team.lineID}&flag=_specific"><img src="<%=path%>/upload/${team.lineID}/${picList.get(timmer.index).name}" width="305" height="200" /></a></div>
<div class="tuangouy-m"><a href="#">[ȫ������]${team.lineName}</a>
<div>���:${fn:substring(team.introduction,0,15)}...</div>
<span>�żۣ�<c:out value="${fn:substring(team.teamBuyPrice,0,fn:indexOf(team.teamBuyPrice,'.'))}"/>Ԫ</span>&nbsp;&nbsp;ԭ&nbsp;�ۣ���${fn:substring(team.price,0,fn:indexOf(team.price,'.'))}Ԫ
</div>
<div class="fengsu">����${countList.get(timmer.index)}�˳���</div>
</li>
</c:forEach>

</ul>
</div>
<div class="tgfy">
  <a href="<%=path%>/TeamBuyManagerServlet?flag=_hundredRegiments&currentPage=1">��ҳ</a>   
  <a href="<%=path%>/TeamBuyManagerServlet?flag=_hundredRegiments&currentPage=${currentPage<=1?currentPage:currentPage-1}">��һҳ</a>  
  <a href="<%=path%>/TeamBuyManagerServlet?flag=_hundredRegiments&currentPage=${currentPage<bottomPage?currentPage+1:bottomPage}">��һҳ</a>   
  <a href="<%=path%>/TeamBuyManagerServlet?flag=_hundredRegiments&currentPage=${bottomPage}">βҳ</a>
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
