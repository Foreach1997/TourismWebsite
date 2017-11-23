<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%String path=request.getContextPath();%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="/WEB-INF/fn.tld"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>��ѯ������·</title>
<style type="text/css">
	html, body, div, span, object, iframe,
	h1, h2, h3, h4, h5, h6, p, blockquote, pre,
	abbr, address, cite, code,
	del, dfn, em, img, ins, kbd, q, samp,
	small, strong, sub, sup, var,
	b, i,
	dl, dt, dd, ol, ul, li,
	fieldset, form, label, legend,
	table, caption, tbody, tfoot, thead, tr, th, td {
		margin:0;
		padding:0;
		border:0;
		outline:0;
		font-size:100%;
		vertical-align:baseline;
		background:transparent;
	}
	
	body {
		margin:0;
		padding:0;
		font:12px/15px "Helvetica Neue",Arial, Helvetica, sans-serif;
		color: #555;
		border:0;
	}
	
	a {color:#666;text-decoration:none;}
	
	#content {width:65%; max-width:690px; margin:6% auto 0;}
	
	table {
		overflow:hidden;
		border:1px solid #d3d3d3;
		background:#fefefe;
		width:800px;
		margin:5% auto 0;
		-moz-border-radius:5px; /* FF1+ */
		-webkit-border-radius:5px; /* Saf3-4 */
		border-radius:5px;
		-moz-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
		-webkit-box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
	}
	
	th, td {padding:18px 28px 18px; text-align:center; }
	
	th {padding-top:22px; text-shadow: 1px 1px 1px #fff; background:#e8eaeb;}
	
	td {border-top:1px solid #e0e0e0; border-right:1px solid #e0e0e0;}
	
	tr.odd-row td {background:#f6f6f6;}
	
	td.first, th.first {text-align:left}
	
	td.last {border-right:none;}
	
	td {
		background: -moz-linear-gradient(100% 25% 90deg, #fefefe, #f9f9f9);
		background: -webkit-gradient(linear, 0% 0%, 0% 25%, from(#f9f9f9), to(#fefefe));
	}
	
	tr.odd-row td {
		background: -moz-linear-gradient(100% 25% 90deg, #f6f6f6, #f1f1f1);
		background: -webkit-gradient(linear, 0% 0%, 0% 25%, from(#f1f1f1), to(#f6f6f6));
	}
	
	th {
		background: -moz-linear-gradient(100% 20% 90deg, #e8eaeb, #ededed);
		background: -webkit-gradient(linear, 0% 0%, 0% 20%, from(#ededed), to(#e8eaeb));
	}
	
	tr:first-child th.first {
		-moz-border-radius-topleft:5px;
		-webkit-border-top-left-radius:5px;
	}
	
	tr:first-child th.last {
		-moz-border-radius-topright:5px;
		-webkit-border-top-right-radius:5px; 
	}
	
	tr:last-child td.first {
		-moz-border-radius-bottomleft:5px;
		-webkit-border-bottom-left-radius:5px;
	}
	
	tr:last-child td.last {
		-moz-border-radius-bottomright:5px;
		-webkit-border-bottom-right-radius:5px;
	}
	ul li{list-style: none;display:inline;margin-left:12px;font-size:13px;}

</style>
<style>
tr.even{
    background:#9C6
}
tr.odd {
    background:#fff;
}
tr.on{
    background:#FC6
}
</style>
</head>
<body>
<center>
<div id="content"  style="margin-top:0px;margin-left:150px">
    <table cellspacing="0">
         <tr>
            <th>���</th>
            <th>��·����</th>
            <th>��������</th>
            <th>��·�۸�</th>
              <th>
             <c:choose>
                   <c:when test="${param.op=='team'}">
                                                         �Ƿ�Ϊ�Ź���·
                   </c:when>
                   <c:otherwise>
                                                  ��ͨ����                       
                   </c:otherwise>
               </c:choose>
             </th>
            <th>��·����</th>
            <th>����</th>
         </tr>
        <c:forEach var="line" items="${lineList}"  varStatus="num">
         <tr>
            <td>${(currentPage-1)*5+num.count}</td>
            <td>${line.lineName}</td>
            <td>${line.days}��</td>
            <td>${fn:substring(line.price,0,fn:indexOf(line.price,'.'))}&nbsp;Ԫ</td>
           
             <c:choose>
                   <c:when test="${param.op=='team'}">
                                                        <td>
                    <c:choose>
                      <c:when test="${line.teamBuy==1}">
                       <font color='red'>�Ź�</font>
                     </c:when>
                    <c:otherwise>
                                                 ���Ź�
                   </c:otherwise>
               </c:choose>
                        </td>
                   </c:when>
                  
                   <c:otherwise>
                       <td>${line.vehicle}</td>                 
                   </c:otherwise>
               </c:choose>
          
           
            <td>${line.typeName}</td>
            <c:choose>
               <c:when test="${param.op=='team'}">
                   <td><a href="<%=path%>/AdminManagerServlet?flag=_showone&no=${line.lineID}&op=${param.op}" target="main">�����Ź���Ϣ</a></td>
               </c:when>
               <c:otherwise>
                   <td><a href="<%=path%>/AdminManagerServlet?flag=_showone&no=${line.lineID}" target="main">�޸�</a></td>
               </c:otherwise>
            </c:choose>
          
         </tr>
         
        </c:forEach>
        <tr>
           <td colspan="7">
               <ul>
                 <li><a href="<%=path%>/AdminManagerServlet?flag=_showall&op=${param.op}&currentPage=1">��ҳ</a> </li>
                 <li><a href="<%=path%>/AdminManagerServlet?flag=_showall&op=${param.op}&&currentPage=${currentPage<=1?currentPage:currentPage-1}">��һҳ</a> </li>
                 <li><a href="<%=path%>/AdminManagerServlet?flag=_showall&op=${param.op}&currentPage=${currentPage<bottomPage?currentPage+1:bottomPage}">��һҳ</a></li>
                 <li><a href="<%=path%>/AdminManagerServlet?flag=_showall&op=${param.op}&currentPage=${bottomPage}">βҳ</a></li>
              </ul>
            </td>
         </tr>
    </table>
</div>
</center>
</body>
</html>