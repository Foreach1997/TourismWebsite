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

import com.cn.dao.CarDao;
import com.cn.dao.LineDao;
import com.cn.dao.LineTypeDao;
import com.cn.dao.PictureDao;
import com.cn.pojo.Car;
import com.cn.pojo.Line;
import com.cn.pojo.LineType;
import com.cn.pojo.Picture;
import com.cn.utils.GeneralUtils;
import com.cn.utils.PagingUitls;

/**
 * ���ﳵ����
 *
 */
public class ShoppingCarManagerServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	        String  flag=request.getParameter("flag");
	        System.out.println(flag);
	        if("_seeCar".equals(flag)){
	        	
	        	this.seeShoppingCar(request, response);
	        }else if("_addCar".equals(flag)){
	        	
	        	this.AddtoShoppingCar(request, response);
	        }else if("_remove".equals(flag)){
	        	
	        	this.removeLineFromCart(request, response);
	        }
	}
	
	//�鿴���ﳵ
	public  void  seeShoppingCar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  //��ȡ��ǰҳ
	      HttpSession  session=request.getSession();
          int customerID=(Integer)session.getAttribute("customerID");
		  CarDao  carDao=new CarDao();
		  //��ȡ��ǰ�û�������ǵڼ�ҳ
		  String currentPage=request.getParameter("currentPage");
		  //��ǰ��¼�û����ﳵ����·��������
		  int totalRecords=carDao.count(customerID);
          PagingUitls pagingUitls=new PagingUitls();
          //ִ�з�ҳ����
          pagingUitls.executePaging(currentPage, totalRecords, 5);
          LineDao lineDao=new LineDao();
          List<Car> carList=carDao.findCar(customerID, pagingUitls.beginSize(),5);
          List<Line> carLineList=new ArrayList<Line>();
          PictureDao pictureDao=new PictureDao();
          List<Picture> pictureList=new ArrayList<Picture>();
          for(Car car:carList){
        	  carLineList.add(lineDao.findLineById(car.getLineID()));
        	  pictureList.add(pictureDao.findPictrue(car.getLineID()).get(0));
         }
         LineTypeDao lineTypeDao=new LineTypeDao();
         List<LineType> listLineType=lineTypeDao.findTopLine(4);
         request.setAttribute("llt",listLineType); 
         request.setAttribute("picList",pictureList);
         request.setAttribute("carList",carList);
         request.setAttribute("currentPage",pagingUitls.getCurrentPage());
         request.setAttribute("carLineList", carLineList);
         request.setAttribute("bottomPage", pagingUitls.getTotalPages());
         request.getRequestDispatcher("./shoppingcart.jsp").forward(request, response);
         
	}
	
	//���빺�ﳵ
	public  void  AddtoShoppingCar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  //��ȡ�û����
          int customerID=((Integer)request.getSession().getAttribute("customerID"));
          String  lineID=request.getParameter("lineId");
          //��ȡ��������
          CarDao carDao=new CarDao();
          Line line=carDao.findCardLine(customerID, lineID);
          if(line!=null){//˵���������Ѿ����˸���·����Ҫ�ظ�����
        	  request.setAttribute("isHave","����·�Ѿ��ڹ��ﳵ��");
        	  request.getRequestDispatcher("LineManagerServlet?flag=_specific").forward(request, response);
          
          }else{//���ﳵ��û�д���·����ӵ����ﳵ��
        	  Car car=new Car();
              car.setCustomerID(customerID);
              car.setLineID(lineID);
              car.setTime(GeneralUtils.dateConvertString(new Date(), GeneralUtils.DATEFORMAT_YMDHMS));
              int flag=carDao.addCar(car);
              if(flag>0){//��ӳɹ�
            	  //��ѯ��ǰ�û����ﳵ����·��������
            	  HttpSession session =request.getSession();
            	  //��ȡ��ǰ�û����ﳵ����·����
            	  int CarLineCount=carDao.count(customerID);
            	  //��session�е�ǰ�û��Ĺ������·�������޸�Ϊ���µ�����
    			  session.setAttribute("clc", CarLineCount);
    			  request.setAttribute("msg","��ӳɹ�");
    			  request.getRequestDispatcher("LineManagerServlet?flag=_specific").forward(request, response);
              }else{//���ʧ��
            	  request.setAttribute("msg","���ʧ�ܣ��������");
            	  request.getRequestDispatcher("LineManagerServlet?flag=_specific").forward(request, response);
              }
          }
	}
	
	//������·�ߴӹ��ﳵ��ɾ��
	public  void  removeLineFromCart(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
		//��ȡ��ǰҳ
		int  currentPage=Integer.parseInt(request.getParameter("currentPage"));
		int  carID=Integer.parseInt(request.getParameter("carID"));
		Car car=new Car();
		car.setCarID(carID);
		CarDao carDao=new CarDao();
		carDao.deleteCar(car);
		HttpSession session =request.getSession();
		int customerID=((Integer)request.getSession().getAttribute("customerID"));
	   	//��ȡ��ǰ�û����ﳵ����·����
	    int CarLineCount=carDao.count(customerID);
	   	//����ǰ�û����ﳵ���������������޸�
	     session.setAttribute("clc", CarLineCount);
	     response.sendRedirect("ShoppingCarManagerServlet?flag=_seeCar&currentPage="+currentPage);
	  
	}
	

}
