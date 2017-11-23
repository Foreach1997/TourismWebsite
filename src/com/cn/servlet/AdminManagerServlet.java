package com.cn.servlet;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cn.dao.CustomerDao;
import com.cn.dao.LineDao;
import com.cn.dao.LineTypeDao;
import com.cn.dao.PictureDao;
import com.cn.pojo.Customer;
import com.cn.pojo.Line;
import com.cn.pojo.LineType;
import com.cn.pojo.Picture;
import com.cn.utils.FileUploadUtils;
import com.cn.utils.GeneralUtils;
import com.cn.utils.PagingUitls;
import com.jspsmart.upload.Request;


/**
 * ����Ա����
 *
 */
public class AdminManagerServlet extends HttpServlet {

	private static final long serialVersionUID = -8574004126323498963L;

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	    String  flag = request.getParameter("flag");
	    System.out.println(flag);
	    if("adminLogin".equals(flag)){
	    	
	    	this.adminLogin(request, response);	    	
	    }else if("_addLine".equals(flag)){
	    	
	    	this.addLine(request, response);
	    }else if("_showType".equals(flag)){
	    	
	    	this.seeLineType(request, response);
	    }else if("_showall".equals(flag)){
	    	
	    	this.queryAllLine(request, response);
	    }else if("_showone".equals(flag)){
	    	
	    	this.querySpecifyLine(request, response);
	    }else if("_update".equals(flag)){
	    	
	    	this.updateSpecifyLine(request, response);
	    }else if("_addType".equals(flag)){
	    	
	    	this.addLineType(request, response);
	    }else if("_seeType".equals(flag)){
	    	
	    	this.queryAllLine(request, response);
	    }else if("_seeOnetype".equals(flag)){
	    	
	    	this.querySpecifyLineLineType(request, response);
	    }else if("_updateType".equals(flag)){
	    	
	    	this.updateSpecifyLineType(request, response);
	    }else if("_seteam".equals(flag)){
	    	
	    	this.setTeamBuyInfo(request, response);
	    }else if("_seeTeam".equals(flag)){
	    	
	    	this.queryTeamBuy(request, response);
	    }else if("_logout".equals(flag)){
	    	
	    	this.adminLogout(request, response);
	    }
	}
	//����Ա��¼
	public void adminLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	      String account = request.getParameter("username");
	      String password = request.getParameter("passwrod");
	      String verifycode = request.getParameter("verifycode");
	      HttpSession  session = request.getSession();
	      //�ж���֤���Ƿ���ȷ
	      if(!(session.getAttribute("safeCode").equals(verifycode))){
	    	    request.setAttribute("msg","��֤�벻��ȷ");
	    	    request.getRequestDispatcher("./admin/adminLogin.jsp").forward(request, response);
	      }else{
	    	  CustomerDao customerDao = new CustomerDao();
	    	  Customer customer = customerDao.findCustomer(account, password);
	    	  if(customer!=null){
	    		  //�˺�������ȷ
	    		  if(customer.getType()==1){
		    		  //����Ա��¼
	    			  session.setAttribute("account", account);
	    			  request.setAttribute("msg", "��ϲ���¼�ɹ�");
		    		  response.sendRedirect("./admin/index.jsp");
		    	  }else {
		    		  //�ǹ����޷���¼��̨ϵͳ
		    		  request.setAttribute("msg", "���ǹ���Ա�޷���¼");
		    		  request.getRequestDispatcher("./admin/adminLogin.jsp").forward(request, response);
		    	  }
	    		  
	    		  
	    	  }else{
	    		  
	    		  request.setAttribute("msg", "�˺Ż����벻��ȷ");
	    		  request.getRequestDispatcher("./admin/adminLogin.jsp").forward(request, response);
	    	  }
	    	 
	    	  
	      }
	}
	//��ѯ������·����
	public void  seeLineType (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LineTypeDao  lineTypeDao = new LineTypeDao();
		List<LineType> lineTypeList = lineTypeDao.findTopLine(0);
		request.setAttribute("lineTypeList" ,lineTypeList);
		String  target = request.getParameter("target");
		if("_up".equals(target)){
			
			request.getRequestDispatcher("./admin/updateLine.jsp").forward(request, response);
		}else if("_team".equals(target)){
			

			request.getRequestDispatcher("./admin/setTeambuyInfo.jsp").forward(request, response);
		}
		else{
			
			request.getRequestDispatcher("./admin/addLine.jsp").forward(request, response);
		}
	
	  }
		
	
	
   //����Ա�������·��
	public void addLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String no = GeneralUtils.getUUID();
		FileUploadUtils fileUploadUtils = new FileUploadUtils();
		fileUploadUtils.init(this, request, response,no);
		boolean flag = fileUploadUtils.upload();
		if(flag){
			Request req = fileUploadUtils.getRequest();
			String lineName = req.getParameter("lineName");
			String   lineTypeId = req.getParameter("lineType");
			int  days = Integer.parseInt(req.getParameter("days"));
			double price = Double.parseDouble(req.getParameter("price"));
			String vehicle = req.getParameter("vehicle");
			String reason = req.getParameter("reason");
			String arrange = req.getParameter("arrange");
			String introduction = req.getParameter("introduction");
			String onTime = GeneralUtils.dateConvertString(new Date(), GeneralUtils.DATEFORMAT_YMDHMS);
			Line line = new Line();
			line.setOnTime(onTime);
			line.setArrange(arrange);
			line.setLineID(no);
			line.setPrice(price);
			line.setIntroduction(introduction);
			line.setVehicle(vehicle);
			line.setLineName(lineName);
			line.setReason(reason);
			line.setDays(days);
			line.setIntroduction(introduction);
			line.setLineTypeID(lineTypeId);
			LineDao lineDao = new LineDao();
	
			//�����·��
			lineDao.addLine(line);
			String[] picIntorductions = req.getParameterValues("picIntroduction");
            List<Picture> pictureList = new ArrayList<Picture>();
			for(int i=0;i<picIntorductions.length;i++){
				Picture picture = new Picture();
				picture.setIntroduction(picIntorductions[i]);
				picture.setName(fileUploadUtils.getFileNames().get(i));
				picture.setNo(no);
				PictureDao pictureDao=new PictureDao();
				//�����·��Ӧ��ͼƬ��Ϣ
				pictureList.add(picture);
				pictureDao.addPicture(picture);
			}
			request.setAttribute("msg","��·��ӳɹ�");
			request.setAttribute("line", line);
			request.setAttribute("pList", pictureList);

		}
		request.getRequestDispatcher("AdminManagerServlet?flag=_showType").forward(request, response);
		
	}
	
	//����Ա�鿴����·��
	public void  queryAllLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		   LineDao  lineDao = new LineDao();
		   String currentPage = request.getParameter("currentPage");
		   int totalRecords = lineDao.queryAllLineCount();
		   PagingUitls pagingUitls = new PagingUitls();
		   pagingUitls.executePaging(currentPage, totalRecords, 5);
	       List<Line> lineList = lineDao.queryAllLine(pagingUitls.beginSize(), 5);
	       request.setAttribute("currentPage",pagingUitls.getCurrentPage());
	       request.setAttribute("lineList",   lineList);
	       request.setAttribute("bottomPage", pagingUitls.getTotalPages());
	       request.getRequestDispatcher("./admin/inner.jsp").forward(request, response);
	}
	//�����޸�·��ǰ�Ȳ鿴ָ��·��
	public  void  querySpecifyLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 String op = request.getParameter("op");
		 String  lineId = request.getParameter("no");
		 LineDao lineDao = new LineDao();
		 Line  line = lineDao.findLineById(lineId); 
		 PictureDao  pictureDao = new PictureDao();
		 //��ȡ��·�߶�Ӧ��ͼƬ
		 List<Picture>  pictureList = pictureDao.findPictrue(lineId);
		 line.setVehicle(line.getVehicle().trim());
		 if(line.getBeginTime()!=null){
			 line.setBeginTime(GeneralUtils.dateConvertString(GeneralUtils.StringConvertDate(line.getBeginTime(), GeneralUtils.DATEFORMAT_YMD), GeneralUtils.DATEFORMAT_YMD));
		 }
		 if(line.getEndTime()!=null){
			 line.setEndTime(GeneralUtils.dateConvertString(GeneralUtils.StringConvertDate(line.getEndTime(), GeneralUtils.DATEFORMAT_YMD), GeneralUtils.DATEFORMAT_YMD)); 
			 
		 }
	

		 request.setAttribute("line", line);
		 request.setAttribute("picList",pictureList);
		 LineTypeDao  lineTypeDao = new LineTypeDao();
	     List<LineType> lineTypeList = lineTypeDao.findTopLine(0);
	     request.setAttribute("lineTypeList" ,lineTypeList);
		 if("team".equals(op)){//���noֵΪteamΪ�����Ź���ת�������Ź�ҳ��
			 
			 request.getRequestDispatcher("./admin/setTeambuyInfo.jsp").forward(request, response);
				
			 
		 }else{//������ת���޸���·ҳ��
			 request.getRequestDispatcher("./admin/updateLine.jsp").forward(request, response);
				
			 
		 }
		 
		
	}
	//����Ա�޸���·��Ϣ
	public  void  updateSpecifyLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String  lineId = request.getParameter("lineID");
		FileUploadUtils fileUploadUtils = new FileUploadUtils();
		fileUploadUtils.init(this, request, response,lineId);
		boolean flag = fileUploadUtils.upload();
		if(flag){
			Request req = fileUploadUtils.getRequest();
			String lineName = req.getParameter("lineName");
			String  lineTypeId = req.getParameter("lineType");
			int  days=Integer.parseInt(req.getParameter("days"));
			double price=Double.parseDouble(req.getParameter("price"));
			String vehicle = req.getParameter("vehicle");
			String reason = req.getParameter("reason");
			String arrange = req.getParameter("arrange");
			String introduction = req.getParameter("introduction");
			Line line = new Line();
			line.setArrange(arrange);
			line.setLineID(lineId);
			line.setPrice(price);
			line.setIntroduction(introduction);
			line.setVehicle(vehicle);
			line.setLineName(lineName);
			line.setReason(reason);
			line.setDays(days);
			line.setIntroduction(introduction);
			line.setLineTypeID(lineTypeId);
			LineDao lineDao = new LineDao();
            lineDao.updateLine(line);
            //��ȡ��������Ϊhid������
            String[] picIdAndNames = req.getParameterValues("hid");
			PictureDao  pictureDao = new PictureDao();
            try {
    			for(String idName:picIdAndNames){
    				 String[]  str = idName.split("-");
    				 if(str.length>1){
    					 int  id = Integer.parseInt(str[0]);//�õ�ͼƬ pictureID
    					 String name = str[1];//ͼƬ����
    					 Picture  picture = new Picture();
    					 picture.setPictureID(id);
    					 picture.setName(name);
    				     //�޸���·��Ϣ
    					 pictureDao.updatePicture(picture); 
    				 }
    			}
    			
    			//�޸ļ��
    			String[] picIntroductions=req.getParameterValues("picIntroduction");
    			for(int i=0;i<picIntroductions.length;i++){
    				int id=Integer.parseInt(picIdAndNames[i].split("-")[0]);//��ȡͼƬ���
    				Picture picture=new Picture();
    				picture.setPictureID(id);
    				picture.setIntroduction(picIntroductions[i]);
    				pictureDao.updatePicture(picture);
    			}
    			List<Picture> picList=new PictureDao().findPictrue(lineId);
    			request.setAttribute("picList", picList);
    			request.setAttribute("line", line);
    			
    			
			} catch (Exception e) {
				e.printStackTrace();
			} finally{
				request.getRequestDispatcher("AdminManagerServlet?flag=_showType&target=_up").forward(request, response);
			}
		}			
	}
	//����Ա�����·����
    public  void  addLineType(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 String lineTypeId="";
	     for(int i=0;i<5;i++){
				
				lineTypeId+=GeneralUtils.getUUID().split("-")[i];
	     }
		 FileUploadUtils fileUploadUtils=new FileUploadUtils();

	     fileUploadUtils.init(this, request, response,lineTypeId);
		 boolean flag=fileUploadUtils.upload();
		 if(flag){
				Request req=fileUploadUtils.getRequest();
				String typeName=req.getParameter("typeName");
				String ontime=GeneralUtils.dateConvertString(new Date(), GeneralUtils.DATEFORMAT_YMDHMS);
				LineType lineType=new LineType();
				lineType.setTypeName(typeName);
				lineType.setOntime(ontime);
			    lineType.setIcon(fileUploadUtils.getFileNames().get(0));
				lineType.setLineTypeID(lineTypeId);
				LineTypeDao lineTypeDao=new LineTypeDao();
				lineTypeDao.addLineType(lineType);
				request.setAttribute("lineType", lineType);
				request.setAttribute("msg", "��ӳɹ�");
					
		 }
		 request.getRequestDispatcher("./admin/addLineType.jsp").forward(request, response);
	}
   //����Ա�鿴������·����
    public void  queryAllLineType(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		   LineTypeDao  lineTypeDao=new LineTypeDao();
		   String currentPage=request.getParameter("currentPage");
		   int totalRecords=lineTypeDao.queryLineTypeCount();
		   PagingUitls pagingUitls=new PagingUitls();
		   pagingUitls.executePaging(currentPage, totalRecords, 5);
	       List<LineType> lineTypeList=lineTypeDao.queryAllLineType(pagingUitls.beginSize(), 5);
	       request.setAttribute("currentPage",pagingUitls.getCurrentPage());
	       request.setAttribute("lineTypeList",   lineTypeList);
	       request.setAttribute("bottomPage", pagingUitls.getTotalPages());
	       request.getRequestDispatcher("./admin/innerType.jsp").forward(request, response);
	}
    
    //����鿴ָ����·����
    public void  querySpecifyLineLineType(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    	 String  lineTypeId=request.getParameter("id");
		 LineTypeDao lineTypeDao=new LineTypeDao();
		 LineType  lineType=lineTypeDao.queryLineType(lineTypeId);
		 System.out.println(lineType);
		 request.setAttribute("lineType", lineType);
		 request.getRequestDispatcher("./admin/updateLineType.jsp").forward(request, response);
    }
    //�����޸���·������Ϣ
  	public  void  updateSpecifyLineType(HttpServletRequest request, HttpServletResponse response)
  			throws ServletException, IOException {
  		String  typeId=request.getParameter("typeId");
  		FileUploadUtils fileUploadUtils=new FileUploadUtils();
  		fileUploadUtils.init(this, request, response,typeId);
  		boolean flag=fileUploadUtils.upload();
  		if(flag){
  			Request req=fileUploadUtils.getRequest();
  			String typeName=req.getParameter("typeName");
  			String idIcon=req.getParameter("hid");
  			String yes=req.getParameter("yes");
            String[]  idIcons=idIcon.split("-");
            LineType lineType=new LineType();
            lineType.setTypeName(typeName);
            lineType.setLineTypeID(typeId);
            if("yes".equals(yes)){
            	//����������˸�ѡ��˵����LineType���е�timeʱ���޸�Ϊ��ǰʱ��
            	lineType.setOntime(GeneralUtils.dateConvertString(new Date(), GeneralUtils.DATEFORMAT_YMDHMS));
            }
            if(idIcons.length>1){
            	String icon=idIcons[1];
            	lineType.setIcon(icon);
            }
  	        LineTypeDao lineTypeDao=new LineTypeDao();
  	        lineTypeDao.updateLineType(lineType);
  	        LineType type=lineTypeDao.queryLineType(typeId);
  	        request.setAttribute("msg", "�޸ĳɹ�");
  	        request.setAttribute("lineType", type);
  		}
  	  request.getRequestDispatcher("./admin/updateLineType.jsp").forward(request, response);
  	
  	}
  	//�����Ź���Ϣ
	public  void  setTeamBuyInfo(HttpServletRequest request, HttpServletResponse response)
  			throws ServletException, IOException {
		
		String  lineId=request.getParameter("lineID");
		FileUploadUtils fileUploadUtils=new FileUploadUtils();
		fileUploadUtils.init(this, request, response,lineId);
		boolean flag=fileUploadUtils.upload();
		if(flag){
			Request req=fileUploadUtils.getRequest();
			String lineName=req.getParameter("lineName");
			String  lineTypeId=req.getParameter("lineType");
			int  days=Integer.parseInt(req.getParameter("days"));
			double price=Double.parseDouble(req.getParameter("price"));
			//��ȡ�Ź��۸�
			double teamPrice=Double.parseDouble(req.getParameter("teamprice"));
			//��ȡ����ʱ��
			String beginTime=req.getParameter("beginTime");
			//��ȡ����ʱ��
			String endTime=req.getParameter("endTime");
			String vehicle=req.getParameter("vehicle");
			String reason=req.getParameter("reason");
			String arrange=req.getParameter("arrange");
			String introduction=req.getParameter("introduction");
			Line line= new Line();
			line.setTeamBuy(1);//1Ϊ�Ź�
			line.setTeamBuyPrice(teamPrice);
			line.setBeginTime(beginTime);
			line.setEndTime(endTime);
			line.setArrange(arrange);
			line.setLineID(lineId);
			line.setPrice(price);
			line.setIntroduction(introduction);
			line.setVehicle(vehicle);
			line.setLineName(lineName);
			line.setReason(reason);
			line.setDays(days);
			line.setIntroduction(introduction);
			line.setLineTypeID(lineTypeId);
			LineDao lineDao=new LineDao();
            lineDao.updateTeamLine(line);
			String[] picIdAndNames=req.getParameterValues("hid");
			PictureDao  pictureDao=new PictureDao();
			if(picIdAndNames!=null){
				
				for(String idName:picIdAndNames){
					 String[]  str=idName.split("-");
					 if(str.length>1){
						 int  id=Integer.parseInt(str[0]);//�õ�ͼƬ pictureID
						 String name=str[1];//ͼƬ����
						 Picture  picture=new Picture();
						 picture.setPictureID(id);
						 picture.setName(name);
					
						 pictureDao.updatePicture(picture); 
					 }
				}
			}
			
			//�޸ļ��
			String[] picIntroductions=req.getParameterValues("picIntroduction");
			if(picIntroductions!=null){
			for(int i=0;i<picIntroductions.length;i++){
				int id=Integer.parseInt(picIdAndNames[i].split("-")[0]);//��ȡͼƬ���
				Picture picture=new Picture();
				picture.setPictureID(id);
				picture.setIntroduction(picIntroductions[i]);
				pictureDao.updatePicture(picture);
			}}
			List<Picture> picList=new PictureDao().findPictrue(lineId);
			request.setAttribute("picList", picList);
			request.setAttribute("line", line);
			
			
		
		}
		request.getRequestDispatcher("AdminManagerServlet?flag=_showType&target=_team").forward(request, response);
		
	}
  	
	//����Ա�鿴�����Ź���·
	public  void  queryTeamBuy(HttpServletRequest request, HttpServletResponse response)
		  throws ServletException, IOException {
		   LineDao  lineDao = new LineDao();
		   String currentPage = request.getParameter("currentPage");
		   //��ѯ�����Ź�����
		   int totalRecords = lineDao.queryTeamBuyCount(1);
		   PagingUitls pagingUitls = new PagingUitls();
		   pagingUitls.executePaging(currentPage, totalRecords, 5);
		   //��ѯ�����Ź�����·
	       List<Line> lineList = lineDao.findTeamBuyLine(pagingUitls.beginSize(), 5, 1);
	       request.setAttribute("currentPage",pagingUitls.getCurrentPage());
	       request.setAttribute("lineList",   lineList);
	       request.setAttribute("bottomPage", pagingUitls.getTotalPages());
	       request.getRequestDispatcher("./admin/innerTeam.jsp").forward(request, response);
	}
     //����Ա�˳�����
	public void  adminLogout(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException,IOException{
		HttpSession session=request.getSession();
		session.removeAttribute("account");//�Ƴ��Ự�е�account����
		session.invalidate();//����ǰ�ỰsessionʧЧ
		response.setCharacterEncoding("GBK");
		response.getWriter().write("<script>alert('���Ѱ�ȫ�˳���̨����ϵͳ��');window.top.location.href='" + getServletContext().getContextPath() + "/admin/adminLogin.jsp';</script>");
	} 
	
	
}
