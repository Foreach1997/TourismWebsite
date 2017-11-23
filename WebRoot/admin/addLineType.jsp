<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%String path=request.getContextPath();%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>
�����·����ҳ��
</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /><style type="text/css">

<style type="text/css">

* {
	padding: 0;
	margin: 0;
	font-family: "Microsoft YaHei";
	font-size: 14px;
}
#hides{display: none;}
a {
	text-decoration: none;
}

li {
	list-style-type: none;
}

#pageAll {
	width: 100%;
	overflow: hidden;
}

#pageAll .page {
	width: 96%;
	margin: 0px auto;
}

.pageTop {
	width: 100%;
	height: 45px;
	line-height: 45px;
	background-color: #f2f2f2;
}

.pageTop span {
	margin-left: 15px;
}

.pageTop a {
	color: #3695cc;
}

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-size: 14px;
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
 <script src="<%=path%>/js/jquery-1.3.2.min.js" type="text/javascript"></script>
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
	        var  suffixArray=["png","gif","jpg","jpeg","bmp"];
	        var flag=false;
	       for(var i=0;i<suffixArray.length;i++){
	            if(suffixArray[i].toUpperCase()==name.toUpperCase()){
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
			    
			    required: true,
			    suffix:$("#pic1").val()
			}
			
		},
		
		messages: {
			typeName: {
				required: '��������·����',
				minlength: '����������3���ַ�',
				maxlength: '���������8���ַ�'
			},
			icon: {required: '��ѡ���ϴ����ļ�'
			      
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
 
 </script>
<body>
	<div class="pageTop">
		<div class="page">
			<img src="<%=path%>/admin/img/coin02.png" /><span><a href="#">��ҳ</a>&nbsp;-&nbsp;<a
				href="#">��·���͹���</a>&nbsp;-</span>&nbsp;�����·����
		</div>
	</div>
	<form action="<%=path%>/AdminManagerServlet?flag=_addType" enctype="multipart/form-data" method="post"  id="commentForm">
    	<table width="800px"  align="center"height="144" border="0" cellpadding="0" cellspacing="0">
        	<tr>
            	<td width="50%"><span class="_text">��·��������&nbsp;<input type="text" name="typeName" value="${line.lineName}"></span></td>
            	<td>  <input type="submit"  onclick="test()" value="���"></td>
            	<td><span class="_text">${msg}</span></td>
          	</tr>
           	<tr>
            	<td>
              		<span class="_text"> �����·����ͼ��</span>
             	</td>
             	<td>
              		<p>
               			<span class="_text"><input type="file" id="pic1" name="icon"></span>
              		</p>
             	</td>     
           </tr>
        </table>
	</form>
</body>
