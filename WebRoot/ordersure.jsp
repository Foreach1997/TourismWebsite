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
<title>����</title>
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

.txt{
     border:0px;

}
</style>
<script src="<%=path%>/js/jquery-1.3.1.js" type="text/javascript"></script>
<script src="<%=path%>/js/jquery.validate.js" type="text/javascript"></script>
<script src="<%=path%>/js/date.js" type="text/javascript"></script>
<script>
   //����ο���Ϣ
   var  count=1;
   function addInfo(){
      count++;
      $("#info").append($("<div class='dingdan-mm' id='"+(count)+"'><div class='dingdan-x'>�ο���Ϣ</div>"+
                        " <div class='youke'><ul><li><span>*</span> ��ʵ����"+
                        "<input name='realName' type='text' id='name"+(count)+"' size='20'  class='txt'/>"+
                        "</li><li><span>*</span> �ֻ� <input name='tel'class='txt' type='text' id='tel"+count+"' size='20' />"+
                        "</li><li><span>*</span> �� �� ֤&nbsp;<input name='IdCard' class='txt' type='text' id='IdCard"+count+"' size='20'/>"+
                        "</li><li><span onclick='addInfo()'>+����ο���Ϣ</span> "+
                        " <span onclick='removeInfo("+count+")'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-�Ƴ�����Ϣ�� </span></li></ul></div>'"));
     
   }
   //�Ƴ��ο���Ϣ
   function  removeInfo(id){
         $("#"+id).remove();
   
   }
  
</script>
<script>
  $(document).ready(function(){
  //����validatorΪ����ģʽ���ύ��
    //У�����֤
    $.validator.addMethod("regIdCard", function (value, element) {    
       // ���֤����Ϊ15λ����18λ��15λʱȫΪ���֣�18λǰ17λΪ���֣����һλ��У��λ������Ϊ���ֻ��ַ�X 
       var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
       return reg.test(value);
    },'���֤�Ÿ�ʽ����');  
     //У���������,�������ڱ�����ڽ���
    $.validator.addMethod("ckDate", function (value, element) {  
       var  date=new Date();  
       var  time=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
       var time1 = new Date(time.replace("-", "/").replace("-", "/"));
       var time2 = new Date(value.replace("-", "/").replace("-", "/"));
       return (time2>time1);
    },'��ѡ����ڽ���ĳ�������');  
    //У��绰
    $.validator.addMethod("regTel", function (value, element) {    
       var reg =  /^0?(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}$/;  
       return reg.test(value);
    },'�ֻ����������');  
   
 	
 	
 	
	$("#commentForm").validate({
		rules: {
			realName:{
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
			
			},td:{
			  required:true,
			  ckDate:$("#td").val()
			}
			
		},
		
		messages: {
			
			realName:{
			    required: '��������Ϊ��',
			    minlength:'���Ȳ�����2λ',
				maxlength:'���Ȳ�����6λ'
			},
			IdCard:{
			   required:'���֤�Ų�Ϊ��'
			},
			tel:{
			   required: '�ֻ����벻Ϊ��'
			},
			td:{
			  required:'����ʱ�䲻Ϊ��'
			}
			
		},	
		
		errorElement: "em",				//��������������ʾ��Ϣ��ǩ
		success: function(label) {			//��֤�ɹ����ִ�еĻص�����
			//labelָ�������Ǹ�������ʾ��Ϣ��ǩem
			label.text(" ").addClass("success");	//�����Զ����success��
				
		}
        
	  });
	
  }); 
  
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
<!--����-->
<div id="menu">
<div id="menu-m">
<ul>
<li><a href="#">��ҳ</a></li>
<li style="width:8px;"><img src="<%=path%>/images/t1.jpg" width="8" height="42" /></li>
<li><a href="#">������</a></li>
<li style="width:8px;"><img src="<%=path%>/images/t1.jpg" width="8" height="42" /></li>
<li><a href="#">������</a></li>
<li style="width:8px;"><img src="<%=path%>/images/t1.jpg" width="8" height="42" /></li>
<li><a href="#">������</a></li> 
<li style="width:8px;"><img src="<%=path%>/images/t1.jpg" width="8" height="42" /></li>
<li><a href="#">�Ź�</a></li>
<li><a href="#"><img src="<%=path%>/images/che.jpg" width="176" height="42" /></a></li>
</ul>
</div>
</div>
<!--���λͼƬ-->
<div id="banner"><img src="<%=path%>/images/banner.jpg" width="1003" height="93" /></div>
<!--�������ݵ�һ���ֿ�ʼ-->
<div class="dingdan">
<div class="dingdan-m">
<ul>
<li><img src="<%=path%>/images/n11.jpg" width="205" height="62"  id="one"/></li>
<li><img src="<%=path%>/images/jt21.jpg" width="44" height="60"  id="oneNext"/></li>
<li><img src="<%=path%>/images/n2.jpg" width="205" height="62" id="two"/></li>
<li><img src="<%=path%>/images/jt2.jpg" width="44" height="60" id="twoNext"/></li>
<li><img src="<%=path%>/images/n33.jpg" width="205" height="62" id="three"/></li>
<li></li>
</ul>
</div>
<form action="<%=path%>/OrderManagerServlet?flag=_confirm" method="post" id="commentForm">
<div class="dingdan-inf" >
<div class="dingdan-infm">��·��Ϣ</div>
<div class="dingdan-mm">
<div class="dingdan-x">��·��Ϣ</div>
<div class="dingdan-lx">
<ul>
<li class="ds">��·���</li>
<li class="ds">��·����</li>
<li class="ds">����</li>
<li class="ds">���й���</li>
<li>${fn:substring(lineId,0,fn:indexOf(lineId,'-'))}</li>
<li>
${lineName}
   <input type="hidden" name="lineName" value="${lineName}"/>
   <input type="hidden" name="lineId" value="${lineId}"/>
   <input type="hidden" name="price" value="${price}"/>
   <input type="hidden" name="vehicle" value="${vehicle}"/>
   <input type="hidden" name="carId" value="${carId}"/>
   <input type="hidden" name="target" value="${target}"/>
</li>
 <li>��${price}Ԫ</li>
 <li>
${vehicle}

</li>
</ul>
</div>
</div>
<div class="dingdan-infm">��д�ο���Ϣ&nbsp;&nbsp;&nbsp;&nbsp;<span>��׼ȷ��д�ο���Ϣ��</span>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;<span style="color:red">*</span>
  <span style="color:black">����ʱ��
  <input type="text" class="txt" size="10" name="td" id="td" value="${td}" onclick="SelectDate(this)" readonly="readonly"></input>
  </span>
</div>
<c:forEach  items="${rNames}" varStatus="calc">
<div class="dingdan-mm">
  <div class="dingdan-x">�ο���Ϣ</div>
  <div class="youke">
  <ul>
  <li>
      <span>*</span> ��ʵ���� 
      <input name="realName" type="text" value="${rNames[calc.index]}" id="realName"  class="txt" size="20" />
  </li>
   <li>
         <span>*</span> �ֻ� 
          <input name="tel" type="text"  value="${tels[calc.index]}" id="tel" size="20"   class="txt" />
   </li>
   <li>
     <span>*</span> �� �� ֤&nbsp;
     <input name="IdCard" type="text"  value="${IdCards[calc.index]}" id="IdCard"   class="txt" size="20" />
   </li>
   <li>
      <span onclick="addInfo()">+����ο���Ϣ </span>
   </li>
    </ul>
  </div>
</div>
</c:forEach>
<div id="info">

</div>


<div class="xyb">
  <input name="button" type="image" id="button" onclick="next();" value="�ύ" src="<%=path%>/images/xyb2.jpg" />
</div>
</div>
</form>
</div>

<!--�������ݵ�һ���ֽ���-->
<!--�ײ�-->
<div id="foot">
<div id="foot-t"><p>���֤��ţ�WE125482154 ��ICP��125478966</p>
<p><a href="#">��˽����</a> | <a href="#">��ƸӢ��</a> | <a href="#">��������</a> | <a href="#">��վ��ͼ</a> | <a href="#">��������</a> | <a href="#">�������</a></p>
</div>
</div>
</body>
</html>
