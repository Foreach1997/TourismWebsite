<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ע��ҳ��</title>
<link href="<%=path%>/css/layout.css" rel="stylesheet" type="text/css"/>
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
   
    $.validator.addMethod("compare", function (value, element) {    
       var repass=$("#password").val();
       return (value==repass);  
    },'���������������벻ͬ');  
    //У�����֤
    $.validator.addMethod("regIdCard", function (value, element) {    
       // ���֤����Ϊ15λ����18λ��15λʱȫΪ���֣�18λǰ17λΪ���֣����һλ��У��λ������Ϊ���ֻ��ַ�X 
       var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
       return reg.test(value);
    },'���֤�Ÿ�ʽ����ȷ');  
    //У��绰
    $.validator.addMethod("regTel", function (value, element) {    
       var reg =  /^0?(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}$/;  
       return reg.test(value);
    },'�ֻ������ʽ����ȷ');  
    
   
 
 
	$("#commentForm").validate({
		rules: {
			account: {
				required: true,
				minlength:6,
				maxlength:12
			},
			password:{
			    
			    required: true,
			    minlength:6,
				maxlength:12
			},
			repass:{
			  compare:$("#repass").val()
			},
			realname:{
			    required: true,
			    minlength:2,
				maxlength:6
			},
			IdCard:{
			   required: true,
			   regIdCard:$("#IdCard").val()
			
			},
			tel:{
			   required: true,
			   regTel:$("#tel").val()
			
			},
			code:{
			  required:true,
			  minlength:4,
			  maxlength:4
			}
			
		},
		
		messages: {
			account: {
				required: '�˺Ų���Ϊ��',
				minlength:'�˺ų��Ȳ�����6λ',
				maxlength: '�˺ų��Ȳ�����12λ'
			},
			password: {
				required: '���벻��Ϊ��',
			    minlength:'���볤�Ȳ�����6λ',
				maxlength: '���볤�Ȳ�����12λ'
			},
			realname:{
			    required: '��������Ϊ��',
			    minlength:'�������Ȳ�����2λ',
				maxlength:'�������Ȳ�����6λ'
			},
			IdCard:{
			   required:'���֤�Ų���Ϊ��'
			},
			tel:{
			   required: '�ֻ����벻��Ϊ��'
		
			
			},
			code:{
			     required: '��֤�벻��Ϊ��',
			    minlength: '��֤�볤Ϊ4λ',
				maxlength: '��֤�볤Ϊ4λ'
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
  
  
  function replaceImage(){
          var imgObj=document.getElementById("codePic");
          imgObj.src="<%=path%>/VerificationCode?ran="+Math.random();
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

<!--ע����-->
<div id="reg">
<div id="reg-top">&nbsp;&nbsp;&nbsp;&nbsp;��Աע��</div>
<div id="reg-mleft">
<form  action="<%=path%>/CustomerManagerServlet?flag=_register"  method="post" id="commentForm">
<ul>
<li class="m">�û��˻� </li>
<li class="r"><input name="account" type="text" class="box" id="account" /></li>
<li class="m">�������� </li>
<li class="r"><input name="password" type="password" class="box" id="password" /></li>
<li class="m">ȷ������ </li>
<li class="r"><input name="repass" type="password" class="box" id="repass" /></li>
<li class="m">�û����� </li>
<li class="r"><input name="realname" type="text" class="box" id="realname" /></li>
<li class="m">���֤�� </li>
<li class="r"><input name="IdCard" type="text" class="box" id="IdCard" /></li>
<li class="m">�� �� </li>
<li class="r">
    <input name="gender" type="radio" id="radio" value="��" checked="checked" /> 
    ��
    <input type="radio" name="gender" id="radio2" value="Ů" /> 
    Ů
</li>
<li class="m">�ֻ����� </li>
<li class="r"><input name="tel" type="text" class="box" id="tel" /></li>
<li class="m">У���� </li>
<li class="r"><input name="code" type="text" class="box" id="code" size="15" /> 
<img id="codePic" src="<%=path%>/VerificationCode"   style="vertical-align:top;"/>
  �����壿<a href="javascript:replaceImage()">��һ��</a></li>
 
<li class="r">
    <input name="button" type="image" id="button" value="�ύ" src="<%=path%>/images/but2.jpg" />
</li>
  <li class="m"> </li>
<li class="r">
    <input name="checkbox" type="checkbox" id="checkbox" checked="checked" />
��ʤ����������Ա������� <img src="images/jt.jpg" width="13" height="12" /></li>
</ul>
</form>
</div>

<div id="reg-right">
<div><img src="<%=path%>/images/kf.jpg" width="230" height="150" /></div>
<div id="kf2"><a href="<%=path%>/login.jsp">�����˻���������¼</a></div>
<div id="zcdt">��ӭע���Ϊ��Ա</div>
<div id="dt">
<ul>
   <li><font color='red' size="6">${msg}</font></li>
</ul>
</div>
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
