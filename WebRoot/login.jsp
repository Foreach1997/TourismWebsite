<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>��¼ҳ��</title>
<link href="<%=path%>/css/layout.css" rel="stylesheet" type="text/css" />
<style>
em { font-weight: bold; padding-right: 1em; vertical-align: top; }
em.error {
  background:url("<%=path%>/images/admin/images/unchecked.gif") no-repeat 0px 0px;
  padding-left: 16px;
}
em.success {
  background:url("<%=path%>/images/admin/images/checked.gif") no-repeat 0px 0px;
  padding-left: 16px;
}
</style>
<script src="<%=path%>/js/jquery-1.3.1.js" type="text/javascript"></script>
<script src="<%=path%>/js/jquery.validate.js" type="text/javascript"></script>
<script>
 $(document).ready(function(){
	$("#commentForm").validate({
		rules: {
			account: {
				required: true,
				maxlength:12
			},
			password:{
			    
			    required: true,
				maxlength:12
			}
			
		},
		
		messages: {
			account: {
				required: '�˺Ų���Ϊ��',
				maxlength: '���Ȳ�����12λ'
			},
			password: {
				required: '���벻��Ϊ��',
			    maxlength: '���Ȳ�����12λ'
			}
			
		},	
		
		errorElement: "em",				//��������������ʾ��Ϣ��ǩ
		success: function(label) {			//��֤�ɹ����ִ�еĻص�����
			//labelָ�������Ǹ�������ʾ��Ϣ��ǩem
			label.text(" ")				//��մ�����ʾ��Ϣ
				.addClass("success");	//�����Զ����success��
		}


	  });
	
  }); 
  window.onload=function(){
   
      var  msg="<%=(String)request.getAttribute("msg")%>";
       if(msg!="null"){
      
         alert(msg);
       }
      
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

<!--���λͼƬ-->
<div id="banner"><img src="<%=path%>/images/banner.jpg" width="1003" height="93" /></div>

<!--��¼���-->
<div id="login-bg">
<div id="login-m">
<form  action="<%=path%>/CustomerManagerServlet?flag=_login"  method="post"  id="commentForm">
<ul>
<li>��¼��
    <input name="account" type="text" class="box" id="account" size="25" />
</li>
<li>��&nbsp;&nbsp;&nbsp;��
    <input name="password" type="password" class="box" id="password" size="25" style="width:155px" />
</li>
<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input name="timeout" type="checkbox" id="checkbox" checked="checked" />
  30�����Զ���¼</li>
  <li>
      <input name="button" type="image" id="button" value="�ύ" src="<%=path%>/images/login-b.jpg" />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <img  onclick="window.location.href='register.jsp'"      src="<%=path%>/images/login-c.jpg" />
  </li>
  
</ul>
</form>
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
