<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>��ʷ������¼</title>
<link href="<%=path%>/css/layout.css" rel="stylesheet" type="text/css" />
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

<!--ע����-->
<div id="shop">
<div id="shop-t">
<div id="shop-ls"><img src="<%=path%>/images/ls.jpg" width="92" height="67" /></div>
<div id="shop-lsm">��ʷ������¼</div>
</div>

<div id="shop-inf">
<ul>
<li class="xh">���</li>
<li class="lx">������ż�·������</li>
<li class="rs">��������</li>
<li class="dj">�ܼ�</li>
<li class="cz">����</li>
</ul>
</div>
<c:forEach  var="order" items="${odList}" varStatus="timmer">
<div id="shop-xx">
<ul>
<li class="xh">${(currentPage-1)*3+timmer.count}</li>
<li class="lx">
<div id="luxian">
<ul>
<li><a href="#"><img src="<%=path%>/upload/${order.lineID}/${picList.get(timmer.index).name}" width="87" height="58" /></a></li>
<li><span style="font-size:16px; font-family:'΢���ź�';color=#59ab00">�������:${fn:substring(order.odID,0,(fn:indexOf(order.odID,'-')-2))}&nbsp;��·����:${order.lineName}</span></li>
</ul></div>
</li>
<li class="rs">${fn:substring(order.travelDate,0,(fn:indexOf(order.travelDate,' ')))}</li>
<li class="dj">��${fn:substring(order.total,0,fn:indexOf(order.total,'.'))}Ԫ</li>
<li class="cz"><a href="<%=path%>/OrderManagerServlet?flag=_delete&odID=${order.odID}&currentPage=${currentPage}"><span style="color:#F60; text-decoration:underline;">ɾ��</span></a></li>
</ul>
</div>
</c:forEach>
<div id="fanye">
<a href="<%=path%>/OrderManagerServlet?flag=_history&currentPage=1">��ҳ</a>   
<a href="<%=path%>/OrderManagerServlet?flag=_history&currentPage=${currentPage<=1?currentPage:currentPage-1}">��һҳ</a>  
<a href="<%=path%>/OrderManagerServlet?flag=_history&currentPage=${currentPage<bottomPage?currentPage+1:bottomPage}">��һҳ</a>   
<a href="<%=path%>/OrderManagerServlet?flag=_history&currentPage=${bottomPage}">βҳ</a>
</div>
</div>

<!--�ײ�-->
<div id="foot">
<div id="foot-t"><p>���֤��ţ�WE125482154 ��ICP��125478966</p>
<p><a href="#">��˽����</a> | <a href="#">��ƸӢ��</a> | <a href="#">��������</a> | <a href="#">��վ��ͼ</a> | <a href="#">��������</a> | <a href="#">�������</a></p>
</div>
</div>
</body>
</html>

