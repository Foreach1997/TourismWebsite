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

</head>

<body>
  <div id="con-2meun">
<ul>
 
  <c:forEach var="llt" items="${llt}">
      <li><a href="<%=path%>/LineManagerServlet?lineTypeID=${llt.lineTypeID}&flag=_partLine">${llt.typeName}</a></li>
  </c:forEach>
</ul>
</div>
<c:forEach var="line" items="${pll}" varStatus="num">
  <div class="con-2inf">
<ul>
<li class="w130"><a href="<%=path%>/LineManagerServlet?lineId=${line.lineID}&flag=_specific" target="_blank"><img src="<%=path%>/upload/${line.lineID}/${picList.get(num.index).name}" width="120" height="75" /></a> 
  ��Ʒ��ţ�${fn:substring(line.lineID,0,(fn:indexOf(line.lineID,'-')-2))}</li>
<li class="w440"><div class="w440lx"><a href="<%=path%>/LineManagerServlet?lineId=${line.lineID}&flag=_specific" target="_blank">[${line.days}����] &nbsp;&nbsp;${line.lineName}  &nbsp;&nbsp;��ͨ���� -(${line.vehicle})</a></div>
<div class="w440xx"><a href="#">���:${fn:substring(line.introduction,0,45)}...</a><br />
������·����&nbsp;&nbsp;&nbsp;&nbsp;<span>${countList.get(num.index)}</span>&nbsp;&nbsp;&nbsp;&nbsp; �˳���</a> &nbsp;&nbsp;</div></li>
<li  style="position: relative;top:30px; color:#F30;font-family:'΢���ź�';font-size:17px"><a href="#"></a>
<span>��<c:out value="${fn:substring(line.price,0,fn:indexOf(line.price,'.'))}"/></span>Ԫ/ÿ��<br /></li>
</ul>
</div>
</c:forEach>

</body>
</html>