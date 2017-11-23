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
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>���ﳵ</title>
<link href="<%=path%>/css/layout.css" rel="stylesheet" type="text/css"/>
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
 <c:forEach var="llm" items="${llt}" begin="0" end="2"  >
           <li><a href="<%=path%>/LineManagerServlet?typeName=${llm.typeName}&flag=_hot&lineTypeId=${llm.lineTypeID}">${llm.typeName}</a></li>
           <li style="width:8px;"><img src="<%=path%>/images/t1.jpg" width="8" height="42" /></li>
  </c:forEach>
<li><a href="<%=path%>/TeamBuyManagerServlet?flag=_hundredRegiments">�Ź�</a></li>
<li><a href="javascript:seeCar()"><img src="<%=path%>/images/che.jpg" width="176" height="42" /></a></li>
</ul>
</div>
</div>

<!--ע����-->
<div id="shop">
<div id="shop-t">
<div id="shop-l"><img src="<%=path%>/images/sh.jpg" width="74" height="67" /></div>
<div id="shop-r">�ҵĹ��ﳵ</div>
</div>

<div id="shop-inf">
<ul>
<li class="xh">���</li>
<li class="lx">·������</li>
<li class="rs">����</li>
<li class="dj">�µ�</li>
<li class="cz">����</li>
</ul>
</div>
<c:forEach  var="line" items="${carLineList}" varStatus="calc">
<div id="shop-xx">
<ul>
<li class="xh">${(currentPage-1)*5+calc.count}</li>
<li class="lx">
<div id="luxian">
<ul>
<li><a href="#"><img src="<%=path%>/upload/${line.lineID}/${picList.get(calc.index).name}" width="87" height="58" /></a></li>
<li><a href="#">��Ʒ���:${fn:substring(line.lineID,0,fn:indexOf(line.lineID,'-'))}&nbsp;��·��:${line.lineName}����ͨ����+${line.vehicle}��</a></li>
</ul></div>
</li>
 <c:choose>
   <c:when test="${line.teamBuy==1}">

     <li class="rs">��<c:out value="${fn:substring(line.teamBuyPrice,0,fn:indexOf(line.teamBuyPrice,'.'))}"/>Ԫ</li>
   </c:when>
   <c:otherwise>
         <li class="rs">��<c:out value="${fn:substring(line.price,0,fn:indexOf(line.price,'.'))}"/>Ԫ</li>
   </c:otherwise>
</c:choose>
<li class="rs">
  <a href="<%=path%>/OrderManagerServlet?flag=_place&target=carOrder&target=carOrder&lineId=${line.lineID}&carId=${carList.get(calc.count-1).carID}"><span style="color:#F60; text-decoration:underline;">�µ�</span></a>
</li>
<li class="cz"><a href="<%=path%>/ShoppingCarManagerServlet?flag=_remove&currentPage=${currentPage}&carID=${carList.get(calc.count-1).carID}"><span style="color:#F60; text-decoration:underline;">ɾ��</span></a></li>
</ul>
</div>
</c:forEach>
<div id="fanye">
   <a href="<%=path%>/ShoppingCarManagerServlet?flag=_seeCar&currentPage=1">��ҳ</a> 
   <a href="<%=path%>/ShoppingCarManagerServlet?flag=_seeCar&currentPage=${currentPage<=1?currentPage:currentPage-1}">��һҳ</a>
   <a href="<%=path%>/ShoppingCarManagerServlet?flag=_seeCar&currentPage=${currentPage<bottomPage?currentPage+1:bottomPage}">��һҳ</a> 
   <a href="<%=path%>/ShoppingCarManagerServlet?flag=_seeCar&currentPage=${bottomPage}">βҳ</a></div>
</div>


<!--�ײ�-->
<div id="foot">
<div id="foot-t"><p>���֤��ţ�WE125482154 ��ICP��125478966</p>
<p><a href="#">��˽����</a> | <a href="#">��ƸӢ��</a> | <a href="#">��������</a> | <a href="#">��վ��ͼ</a> | <a href="#">��������</a> | <a href="#">�������</a></p>
</div>
</div>
</body>
</html>
