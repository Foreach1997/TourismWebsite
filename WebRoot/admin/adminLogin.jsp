<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>;���к�̨�����¼</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/admin/css/public.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/admin/css/page.css" />
<script type="text/javascript" src="<%=path%>/admin/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/admin/js/public.js"></script>

<script type="text/javascript">
	
	function replaceImage(){
          var imgObj=document.getElementById("codePic");
          imgObj.src="<%=path%>/VerificationCode?ran="+Math.random();
      }
 
</script>

</head>
<body>

	<!-- ��¼ҳ��ͷ�� -->
	<div class="logHead">
		<img src="<%=path%>/admin/img/logo.jpg" />
	</div>
	<!-- ��¼ҳ��ͷ������ -->

	<!-- ��¼body -->
	<form action="<%=path%>/AdminManagerServlet?flag=adminLogin"" method="post">
	<div class="logDiv">
		<img class="logBanner" src="<%=path%>/admin/img/timg.jpg" />
		<div class="logGet">
			<!-- ͷ����ʾ��Ϣ -->
			<div class="logD logDtip">
				<p class="p1">;���к�̨����ϵͳ</p>
			</div>
			<!-- ����� -->
			<div class="lgD">
				<img class="img1" src="<%=path%>/admin/img/logName.png" /><input type="text"
					placeholder="�����û���" name="username"/>
			</div>
			<div class="lgD">
				<img class="img1" src="<%=path%>/admin/img/logPwd.png" /><input type="password"
					placeholder="�����û�����" name="password"/>
			</div>
			<div class="lgD logD2">
				<input class="getYZM" type="text" name="verifycode" value="" maxLength=4/>
				<div class="logYZM">
					<img class="yzm" src="<%=path%>/VerificationCode" id="codePic" onclick="replaceImage()"/> 
					
				</div>
				<br/><span style="color:red;font-size:14px">${msg}</span>
			</div>
		
			<div class="logC">
				<button>�� ¼</button>
			</div>
			
		</div>
	</div>
	</form>
	<!-- ��¼body  end -->

	<!-- ��¼ҳ��ײ� -->
	<div class="logFoot">
		<p class="p1">��Ȩ���У���������Ƽ����޹�˾</p>
		<p class="p2">������������Ƽ����޹�˾ �Ǽ���ţ���ICP��11003578��-2</p>
	</div>
	<!-- ��¼ҳ��ײ�end -->
</body>
</html>
