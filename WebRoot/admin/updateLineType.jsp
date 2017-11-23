<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%String path=request.getContextPath();%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="<%=path%>/images/admin/images/skin.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /><style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #EEF2FB;
}
span{
font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #666;

}
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
       
 	
	  $.validator.addMethod("decimal", function (value, element) {    
      var decimal = /^(:?(:?\d+.\d+)|(:?\d+))$/;  
      return this.optional(element) || (decimal.test(value));  
      },'�۸���������');  
	  
       $.validator.addMethod("options", function (value, element) {    
       return  value!="sel";
      },'��ѡ��'); 
      
      $.validator.addMethod("suffix", function (value, element) {    
            var reg = /(\\+)/g;
	        var pfn =value.replace(reg, "#");
	        var arrpfn = pfn.split("#");
	        var fn = arrpfn[arrpfn.length - 1];
	        var arrfn = fn.split(".");
	        var name=arrfn[arrfn.length - 1];
	        var  suffixArray=["png","gif","jpg","jpeg","bmp",""];
	        var flag=false;
	       for(var i=0;i<suffixArray.length;i++){
	            if(suffixArray[i]==name){
	               flag=true;
	               return true;
	            }
	            if(flag){
	                 flag=false;
	                 return true;
	            }
	       
	       }
	       return false;
            
      },'�ļ���׺Ϊֻ����[jpg,jpeg,bmp,gif]');
      
      
      
     
 
	$("#commentForm").validate({
		rules: {
			typeName: {
				required: true,
				minlength: 3,
				maxlength:8
			},
			icon:{
			    suffix:$("#icon").val()
			}
		},
		
		messages: {
			typeName: {
				required: '��������·����',
				minlength: '����������3���ַ�',
				maxlength: '���������8���ַ�'
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
  
  function sub(){
       var  icon=$("#icon").attr("cont")+"-"+getName($("#icon").val());
       var  td=$("#td");
       td.append("<input type='hidden' name='hid' value='"+icon+"'>");
  }

  function getName(value){
            var reg = /(\\+)/g;
	        var pfn =value.replace(reg, "#");
	        var arrpfn = pfn.split("#");
	        var fn = arrpfn[arrpfn.length - 1];
	        return fn;
  }

 </script>
<body>
<form action="<%=path%>/admin/AdminManagerServlet?flag=_updateType&typeId=${lineType.lineTypeID}" enctype="multipart/form-data" method="post"  id="commentForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="17" valign="top" background="<%=path%>/images/admin/images/mail_leftbg.gif"><img src="<%=path%>/images/admin/images/left-top-right.gif" width="17" height="29" /></td>
    <td valign="top" background="<%=path%>/images/admin/images/content-bg.gif"><table width="100%" height="31" border="0" cellpadding="0" cellspacing="0" class="left_topbg" id="table2">
      <tr>
        <td height="31"><div class="titlebt"><span>�����޸�</span></div></td>
      </tr>
    </table></td>
    <td width="16" valign="top" background="<%=path%>/images/admin/images/mail_rightbg.gif">
    <img src="<%=path%>/images/admin/images/nav-right-bg.gif" width="16" height="29" /></td>
  </tr>
  <tr>
    <td valign="middle" background="<%=path%>/images/admin/images/mail_leftbg.gif">&nbsp;</td>
    <td valign="top" bgcolor="#F7F8F9"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
     
      <tr>
        <td width="40%">
         <table width="800px"  align="center"height="144" border="0" cellpadding="0" cellspacing="0">
          <tr>
              <td width="50%"><span class="_text">��·��������&nbsp;<input type="text" name="typeName" value="${lineType.typeName}"></span></td>
                <td>
                   <input type="submit" onclick="sub()"" value="�޸���·������Ϣ">
                </td>
               
          </tr>
          <tr>
                <td><span class="_text">��·����ͼ��</span></td>
                <td><img  src="<%=path%>/upload/${lineType.lineTypeID}/${lineType.icon}"></td> 
          </tr>
          <tr>
                <td><span class="_text">��������ͼ��</span></td>
                <td><input type="file" id="icon" name="icon" cont="${lineType.lineTypeID}"></td> 
          </tr>
          <tr>
                <td><span class="_text">�Ƿ���ǰ̨����ʾ</span></td>
                <td>
                  <span class="_text"> ��<input type="checkbox" name="yes" value="yes"></span>
                </td> 
          </tr>
      
          <tr>
              <td id="td">      
              </td>
          </tr>
        </table>
       </td>
      </tr>
      <tr>
        <td valign="top"><table width="100%" height="144" border="0" cellpadding="0" cellspacing="0">
          <tr></tr>
        </table></td>
      </tr>
      <tr>
        <td height="40" colspan="4"><table width="100%" height="1" border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
          <tr>
            <td></td>
          </tr>
        </table></td>
      </tr>
     
    </table></td>
    <td background="<%=path%>/images/admin/images/mail_rightbg.gif">&nbsp;</td>
  </tr>
  <tr>
    <td valign="bottom" background="<%=path%>/images/admin/images/mail_leftbg.gif"><img src="<%=path%>/images/admin/images/buttom_left2.gif" width="17" height="17" /></td>
    <td background="<%=path%>/images/admin/images/buttom_bgs.gif"><img src="<%=path%>/images/admin/images/buttom_bgs.gif" width="17" height="17"></td>
    <td valign="bottom" background="<%=path%>/images/admin/images/mail_rightbg.gif"><img src="<%=path%>/images/admin/images/buttom_right2.gif" width="16" height="17" /></td>
  </tr>
</table>
</form>
</body>
