<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%String path=request.getContextPath();%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<style type="text/css">

* {
	padding: 0;
	margin: 0;
	font-family: "Microsoft YaHei";
	font-size: 14px;
}

#hides {
	display: none;
}

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

span {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #666;
}

em {
	font-weight: bold;
	padding-right: 1em;
	vertical-align: top;
}

em.error {
	background: url("<%=path%>/admin/img/no.png") no-repeat
		0px 0px;
	padding-left: 16px;
}

em.success {
	background: url("<%=path%>/admin/img/ok.png") no-repeat
		0px 0px;
	padding-left: 16px;
}
</style>
<script src="<%=path%>/admin/js/jquery-1.3.1.js" type="text/javascript"></script>
<script src="<%=path%>/admin/js/jquery.validate.js"
	type="text/javascript"></script>
<script src="<%=path%>/admin/js/date.js" type="text/javascript"></script>

<script>
 $(document).ready(function(){
       
 	
	  $.validator.addMethod("decimal", function (value, element) {    
      var decimal = /^(:?(:?\d+.\d+)|(:?\d+))$/;  
      return this.optional(element) || (decimal.test(value));  
      },'�۸���������');  
	  
      $.validator.addMethod("options", function (value, element) {    
       return  value!="sel";
      },'��ѡ��'); 
      //�Ƚ��Ź��۸��·�߼۸�Ĵ�С
      $.validator.addMethod("comparePrice", function (value, element) {    
          var price=parseInt($("#price").val());//�õ���·�۸�
          var tp=parseInt(value);
          return   tp>price?false:true;
       
      },'�Ź�����С����·��'); 
      
      
      
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
			lineName: {
				required: true,
				minlength: 4,
				maxlength:12
			},
			price:{
			    required: true,
			    decimal:$("#price").val(),
			    maxlength:7
			    
			},
			vehicle:{
			   options:$("#vehicle").val()
			},
			days:{
			   options:$("#days").val()
			},
			lineType:{
			   options:$("#lineType").val()
			},
			pic1:{
			    
		
			    suffix:$("#pic1").val()
			},
			pic2:{
			    
			  
			    suffix:$("#pic2").val()
			},
			pic3:{
			    
			
			    suffix:$("#pic3").val()
			},
			pic4:{
			    
			
			    suffix:$("#pic4").val()
			},
			picIntroduction:{
			   required: true,
			   minlength: 2,
			   maxlength:12
			},
			teamprice:{
			  required: true,
			  maxlength:7,
			  decimal:$("#teamprice").val(),
			  comparePrice:$("#teamprice").val()
			}
			
		},
		
		messages: {
			lineName: {
				required: '��������·����',
				minlength: '��������4���ַ�',
				maxlength: '���������12���ַ�'
			},
			price: {
				required: '�۸���Ϊ��',
				maxlength:'���Ȳ��ܳ���7λ'
			},
			
			picIntroduction:{
			   required: '������ͼƬ˵��',
			   minlength: '��������Ϊ2���ַ�',
			   maxlength:'���Ȳ��ܳ���12���ַ�'
			},
			teamprice:{
			   required:'�������Ź��۸�',
			   maxlength:'���Ȳ��ܳ���7λ'
			},
			beginTime:{
			   required:'������ʱ��'
			},
			endTime:{
			  required:'������ʱ��'
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
  $(function(){
         var  sel= $('#days option:selected');
          var options=$('#days option');
         
          options.each(function(i,n){
               if($(n).val()!="sel"){
                   if(sel.val()==$(n).val()){
           
                   $("#days option[index="+(i+1)+"]").remove();     
                     return false;
                   }
               }
          
          })
         
  
  });
  
   $(function(){
         var  tool= $('#vehicle option:selected');
          var toolOptions=$('#vehicle option');
          toolOptions.each(function(i,n){
               if($(n).val()!="sel"){
                   if(tool.val()==$(n).val()){
           
                   $("#vehicle option[index="+(i+1)+"]").remove();     
                     return false;
                   }
               }
          
          })
         
  
  });
  
   $(function(){
         var  lineType= $('#lineType option:selected');
          var lineTypeOptions=$('#vehicle option');
          lineTypeOptions.each(function(i,n){
               if($(n).val()!="sel"){
                   if(lineType.val()==$(n).val()){
           
                   $("#lineType option[index="+(i+1)+"]").remove();     
                     return false;
                   }
               }
          
          })

  });
  function sub(){
       var  hVal1=$("#pic1").attr("cont")+"-"+getName($("#pic1").val());
       var  hVal2=$("#pic2").attr("cont")+"-"+getName($("#pic2").val());
       var  hVal3=$("#pic3").attr("cont")+"-"+getName($("#pic3").val());
       var  hVal4=$("#pic4").attr("cont")+"-"+getName($("#pic4").val());
 

       var  td=$("#td");
       td.append("<input type='hidden' name='hid' value="+hVal1+">");
       td.append("<input type='hidden' name='hid' value="+hVal2+">");
       td.append("<input type='hidden' name='hid' value="+hVal3+">");
       td.append("<input type='hidden' name='hid' value="+hVal4+">");
      
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
	<form
		action="<%=path%>/AdminManagerServlet?flag=_update&lineID=${line.lineID}"
		enctype="multipart/form-data" method="post" id="commentForm">
		<div class="pageTop">
			<div class="page">
				<img src="<%=path%>/admin/img/coin02.png" /><span><a
					href="#">��ҳ</a>&nbsp;-&nbsp;<a href="#">������Ϣ</a>&nbsp;-</span>&nbsp;������·��Ϣ
			</div>
		</div>
		<div style="margin-left:20px">
		<table width="800px" align="center" height="144" border="0"
			cellpadding="0" cellspacing="0">
			<tr>
				<td width="50%"><span class="_text">��·����&nbsp;<input
						type="text" name="lineName" value="${line.lineName}"></span></td>
				<td width="50%" class="_text"><span>��·�۸�&nbsp;<input
						type="text" name="price" id="price" value="${line.price}"></span></td>
				<td><input type="submit" onclick="sub()" " value="�޸���·��Ϣ">
				</td>
			</tr>
			<tr>
				<td width="50%"><span class="_text">�������� <select
						name="days" id="days">
							<option selected="selected" value="sel">==��ѡ���������==</option>
							<c:if test="${line.days==1}">
								<option value="1" selected="selected" />1��</option>
							</c:if>
							<option value="1" />1��
							</option>
							<c:if test="${line.days==2}">
								<option value="2" selected="selected" />2��</option>
							</c:if>
							<option value="2" />2��
							</option>
							<c:if test="${line.days==3}">
								<option value="3" selected="selected" />3��</option>
							</c:if>
							<option value="3" />3��
							</option>
							<c:if test="${line.days==4}">
								<option value="4" selected="selected" />4��</option>
							</c:if>
							<option value="4" />4��
							</option>
							<c:if test="${line.days==5}">
								<option value="5" selected="selected" />5��</option>
							</c:if>
							<option value="5" />5��
							</option>
							<c:if test="${line.days==6}">
								<option value="6" selected="selected" />6��</option>
							</c:if>
							<option value="6" />6��
							</option>
							<c:if test="${line.days==7}">
								<option value="7" selected="selected" />7��</option>
							</c:if>
							<option value="7" />7��
							</option>
							<c:if test="${line.days==8}">
								<option value="8" selected="selected" />8��</option>
							</c:if>
							<option value="8" />8��
							</option>
							<c:if test="${line.days==9}">
								<option value="9" selected="selected" />9��</option>
							</c:if>
							<option value="9" />9��
							</option>
							<c:if test="${line.days==10}">
								<option value="10" selected="selected" />10��</option>
							</c:if>
							<option value="10" />10��
							</option>

					</select></span></td>

			</tr>
			<tr>
				<td width="50%"><span class="_text">��ͨ���� <select
						name="vehicle" id="vehicle">
							<option selected="selected" value="sel">==��ѡ��ͨ����==</option>
							<c:if test="${line.vehicle=='�ɻ�'}">
								<option value="�ɻ�" selected="selected" />�ɻ�</option>
							</c:if>
							<option value="�ɻ�">�ɻ�</option>

							<c:if test="${line.vehicle=='��'}">
								<option value="��" selected="selected" />��</option>
							</c:if>
							<option value="��">��</option>

							<c:if test="${line.vehicle=='����'}">
								<option value="����" selected="selected" />����</option>
							</c:if>
							<option value="����">����</option>

							<c:if test="${line.vehicle=='�ִ�'}">
								<option value="�ִ�" selected="selected" />�ִ�</option>
							</c:if>
							<option value="�ִ�">�ִ�</option>


					</select></span></td>
				<td width="50%"><span class="_text">·������ <select
						name="lineType" id="lineType">
							<option selected="selected" value="sel">==��ѡ��·������==</option>
							<c:forEach var="lineType" items="${lineTypeList}">
								<c:if test="${line.lineTypeID==lineType.lineTypeID}">
									<option value="${lineType.lineTypeID}" selected="selected" />${lineType.typeName}</option>
								</c:if>
								<option value="${lineType.lineTypeID}">${lineType.typeName}</option>
							</c:forEach>

					</select>
				</span></td>


			</tr>
		</table>
		<div>
			<script charset="utf-8" src="<%=path%>/admin/js/kindeditor-min.js"></script>
			<script charset="utf-8" src="<%=path%>/admin/js/lang/zh_CN.js"></script>
			<script>
			KindEditor.ready(function(K) {
				K.each({
					'plug-align' : {
						name : '���뷽ʽ',
						method : {
							'justifyleft' : '�����',
							'justifycenter' : '���ж���',
							'justifyright' : '�Ҷ���'
						}
					},
					'plug-order' : {
						name : '���',
						method : {
							'insertorderedlist' : '���ֱ��',
							'insertunorderedlist' : '��Ŀ���'
						}
					},
					'plug-indent' : {
						name : '����',
						method : {
							'indent' : '��������',
							'outdent' : '��������'
						}
					}
				},function( pluginName, pluginData ){
					var lang = {};
					lang[pluginName] = pluginData.name;
					KindEditor.lang( lang );
					KindEditor.plugin( pluginName, function(K) {
						var self = this;
						self.clickToolbar( pluginName, function() {
							var menu = self.createMenu({
									name : pluginName,
									width : pluginData.width || 100
								});
							K.each( pluginData.method, function( i, v ){
								menu.addItem({
									title : v,
									checked : false,
									iconClass : pluginName+'-'+i,
									click : function() {
										self.exec(i).hideMenu();
									}
								});
							})
						});
					});
				});
				K.create('#reason', {
					themeType : 'qq',
					items : [
						'bold','italic','underline','fontname','fontsize','forecolor','hilitecolor','plug-align','plug-order','plug-indent','link'
					]
				});
				K.create('#arrange', {
					themeType : 'qq',
					items : [
						'bold','italic','underline','fontname','fontsize','forecolor','hilitecolor','plug-align','plug-order','plug-indent','link'
					]
				});
				
				K.create('#introduction', {
					themeType : 'qq',
					items : [
						'bold','italic','underline','fontname','fontsize','forecolor','hilitecolor','plug-align','plug-order','plug-indent','link'
					]
				});
			});
		</script>

			<table width="100%">
				<tr>
					<td align="center" width="33%" align="center"><span
						class="_text">�Ƽ�����</span></td>
					<td align="center" width="34%" align="center"><span
						class="_text">�г̰���</span></td>
					<td align="center" width="33%" align="center"><span
						class="_text">·�߼��</span></td>
				</tr>
				<tr>
					<td><textarea id="reason" name="reason" cols="40">${line.reason}</textarea></td>
					<td><textarea id="arrange" name="arrange" cols="40">${line.arrange}</textarea></td>
					<td><textarea id="introduction" name="introduction" cols="40">${line.introduction}</textarea></td>
				</tr>
			</table>

			<table>
				<tr>
					<td><span class="_text">���ͼƬ</span></td>
				</tr>
				<tr>
					<c:forEach var="pic" items="${picList}">
						<td><img width="250px" height="240px"
							src="<%=path%>/upload/${line.lineID}/${pic.name}"></td>
					</c:forEach>


				</tr>

				<tr>
					<c:forEach var="pic" items="${picList}" varStatus="num">
						<td align="center"><span class="_text">ͼƬ����: <input
								style="width:190px;" type="text" id="i${num.count}"
								name="picIntroduction" value="${pic.introduction}">
						</span></td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach var="pic" items="${picList}" varStatus="num">
						<td align="center"><span class="_text"> <input
								type="file" id="pic${num.count}" name="pic${num.count}"
								value="${pic.pictureID}" cont="${pic.pictureID}"
								explain="${pic.introduction}">
						</span></td>

					</c:forEach>
				</tr>
			</table>
		</div>
	</form>
</body>
