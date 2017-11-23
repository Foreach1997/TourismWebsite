package com.cn.servlet;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cn.dao.CarDao;
import com.cn.dao.LineDao;
import com.cn.dao.LineTypeDao;
import com.cn.dao.OTDetailDao;
import com.cn.dao.OrderDetailDao;
import com.cn.dao.PictureDao;
import com.cn.dao.TouristDao;
import com.cn.pojo.Car;
import com.cn.pojo.Line;
import com.cn.pojo.LineType;
import com.cn.pojo.OTDetail;
import com.cn.pojo.OrderDetail;
import com.cn.pojo.Picture;
import com.cn.pojo.Tourist;
import com.cn.utils.GeneralUtils;
import com.cn.utils.PagingUitls;

/**
 * ��������
 *
 */
public class OrderManagerServlet extends HttpServlet {

	private static final long serialVersionUID = 881438654110496887L;

	@Override
	public   void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		    
		String flag=request.getParameter("flag");
	
		System.out.println(flag);
		if("_place".equals(flag)){
			this.placeOrder(request, response);
		}else if("_set".equals(flag)){
			this.Ordersettlement(request, response);
		}else if("_history".equals(flag)){
			
			this.showHistoryOrder(request, response);
		}else if("_delete".equals(flag)){
			this.deleteOrder(request, response);
			
		}else if("_fill".equals(flag)){
			
			this.FillInOrder(request, response);
		}else if("_confirm".equals(flag)){
			
			this.ConfirmationOrder(request, response);
		}
	}
	//�¶���
	public   void placeOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		    LineDao lineDao=new LineDao();
		    LineTypeDao lineTypeDao=new LineTypeDao();
		    List<LineType> listLineType=lineTypeDao.findTopLine(5);
		    //��ʾ��ҳ���β�Ʒ�����ǰ5���������Ͷ�Ӧ����·
		     Map<String,List<Line>> lineListMap=new HashMap<String,List<Line>>();
		    
		     for(LineType lineType:listLineType){
		    	List<Line> lineList=lineDao.findLine(lineType.getLineTypeID(), 12);
		        lineListMap.put(lineType.getTypeName(), lineList);
		      }
		      request.setAttribute("lineListMap", lineListMap);
		      String  lineID=request.getParameter("lineId");
		      Line line=lineDao.findLineById(lineID);
		      //������carID������request��Χ��
		      String  target=request.getParameter("target");
		      if("carOrder".equals(target)){
		    	  //�ж������Ƿ�ӹ��ﳵ�б�ҳ�淢�͹���
		    	  //�����ﳵcarID��ӵ�request��Χ��
		    	   request.setAttribute("carId", Integer.parseInt(request.getParameter("carId")));
		    	   request.setAttribute("target",target);
		      }
		     
		      request.setAttribute("line",line);
		      request.getRequestDispatcher("./order.jsp").forward(request, response);
	}
	//��������
	public  void  Ordersettlement (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String  lineId=request.getParameter("lineId");
		String  lineName=request.getParameter("lineName");
		String  travelDate=request.getParameter("td");
		double  price=Double.parseDouble(request.getParameter("price"));
		//��ȡ�����������ο͵���ʵ����
		String[] realNames=request.getParameterValues("realName");
		//��ȡ�����������ο͵����֤��
		String[] idCards=request.getParameterValues("IdCard");
		//��ȡ�����������ο͵��ֻ�����
		String[] tels=request.getParameterValues("tel");
		OrderDetail  orderDetail=new OrderDetail();
		String odID=GeneralUtils.getUUID();
		orderDetail.setOdID(odID);
		orderDetail.setLineID(lineId);
		orderDetail.setCustomerID((Integer)request.getSession().getAttribute("customerID"));
		orderDetail.setLineName(lineName);
		orderDetail.setOrderDate(GeneralUtils.dateConvertString(new Date(), GeneralUtils.DATEFORMAT_YMDHMS));
		orderDetail.setPrice(price);
		orderDetail.setState(1);
		orderDetail.setTravelDate(travelDate);
		//���ö����ܼ�
		orderDetail.setTotal(price*idCards.length);
		OrderDetailDao  ordersDetailDao=new OrderDetailDao();
		ordersDetailDao.addOrderDetail(orderDetail);
		TouristDao  touristDao=new TouristDao();
		OTDetailDao  otDetailDao=new OTDetailDao();
		for(int i=0;i<realNames.length;i++){
			 Tourist tourist=new Tourist();
			 tourist.setIDCard(idCards[i]);
			 tourist.setRealName(realNames[i]);
			 String touristID=GeneralUtils.getUUID();
			 tourist.setTouristID(touristID);
			 tourist.setTel(tels[i]);
			 touristDao.addTourist(tourist);
			 OTDetail  otDetail=new OTDetail();
			 otDetail.setOdID(odID);
			 otDetail.setTouristID(touristID);
			 otDetailDao.addOTDetail(otDetail);
			 
		}
		
		String target=request.getParameter("target");
		//�ж϶����Ƿ�ӹ��ﳵҳ������ת����������Ƕ����γɺ���Ҫ��������еĸ���·�Ƴ�
		if("carOrder".equals(target)){
			int carID=Integer.parseInt(request.getParameter("carId"));
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
		}
		response.sendRedirect("./alert.jsp");
	}
	
	//�鿴��ʷ����
	public   void showHistoryOrder (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		   int customerId=(Integer)request.getSession().getAttribute("customerID");
	       OrderDetailDao  orderDetailDao=new OrderDetailDao(); 
		   String currentPage=request.getParameter("currentPage");
           int totalRecords=orderDetailDao.findOrderDetailByCustomerIdCount(customerId,1);
		   PagingUitls pagingUitls=new PagingUitls();
		   pagingUitls.executePaging(currentPage, totalRecords,3);
		   List<OrderDetail> orderDetailList=orderDetailDao.findOrderDetailByCustomerId(pagingUitls.beginSize(), 3, customerId,1); 
		   LineTypeDao lineTypeDao=new LineTypeDao();
		   List<Picture> picList=new ArrayList<Picture>();
		    //ʵ���ϵĶ���Ӧ��Ϊ�ڶ�������Ʒ�����µ�һ�ݿ��գ�����򻯴���û�аɵ�ʱ�¶�����·�ߵ�ͼƬ��������
			//������ʾ��ͼƬ���Ǹ���·�������µ�ͼƬ
		    PictureDao picDao=new PictureDao();
		    for(OrderDetail order:orderDetailList){
		    	picList.add(picDao.findPictrue(order.getLineID()).get(0));
		    	
		    }
		   request.setAttribute("picList",picList);
		   List<LineType> listLineType=lineTypeDao.findTopLine(5);
		    //��ʾ��ҳ���β�Ʒ�����ǰ5���������Ͷ�Ӧ����·
		   request.setAttribute("ltl", listLineType);
		   request.setAttribute("currentPage",pagingUitls.getCurrentPage());
	       request.setAttribute("odList",   orderDetailList);
	       request.setAttribute("bottomPage", pagingUitls.getTotalPages());
	       request.getRequestDispatcher("./historyorder.jsp").forward(request, response);
	}
    //ɾ������
	public   void deleteOrder (HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 //ɾ������ʵ��Ϊ��ɾ����ֻ���޸Ķ������state��״̬Ϊ0
		  String odID=request.getParameter("odID");
		  String currentPage=request.getParameter("currentPage");
		  OrderDetailDao  orderDetailDao=new OrderDetailDao();
		  OrderDetail  orderDetail=new OrderDetail();
		  orderDetail.setState(0);
		  orderDetail.setOdID(odID);
		  orderDetailDao.updateOrderDetatil(orderDetail);
		  response.sendRedirect("OrderManagerServlet?flag=_history&currentPage="+currentPage);	
   }
   //��д����
   public   void FillInOrder(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
	   String   lineName=request.getParameter("lineName");
	   String   lineId=request.getParameter("lineId");
	   String   price=request.getParameter("price");
	   String   vehicle=request.getParameter("vehicle");
	   String   carId=request.getParameter("carId");
	   String   target=request.getParameter("target");
	   String   travelDate=request.getParameter("td");//��ȡ��������
	   String[] realNames=request.getParameterValues("realName");
	   String[] tels=request.getParameterValues("tel");
	   String[] IdCards=request.getParameterValues("IdCard");
	   request.setAttribute("lineName", lineName);
	   request.setAttribute("lineId",lineId);
	   request.setAttribute("price", price);
	   request.setAttribute("rNames", realNames);
	   request.setAttribute("tels",tels);
	   request.setAttribute("IdCards", IdCards);
	   request.setAttribute("vehicle", vehicle);
	   request.setAttribute("target",target);
	   request.setAttribute("carId", carId);
	   request.setAttribute("td", travelDate);
	   request.getRequestDispatcher("./ordersure.jsp").forward(request, response);
		  
   }
  
 //ȷ�϶���
   public   void  ConfirmationOrder(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
	   String   lineName=request.getParameter("lineName");
	   System.out.println(lineName);
	   String   lineId=request.getParameter("lineId");
	   String   price=request.getParameter("price");
	   String   vehicle=request.getParameter("vehicle");
	   String[] realNames=request.getParameterValues("realName");
	   String   carId=request.getParameter("carId");
	   String   target=request.getParameter("target");
	   String   travelDate=request.getParameter("td");//��ȡ��������
	   String[] tels=request.getParameterValues("tel");
	   String[] IdCards=request.getParameterValues("IdCard");
	   System.out.println("�۸�:"+price);
	   int  totalsPrice=Integer.parseInt(price)*realNames.length;//�����������ܼ�
	   request.setAttribute("lineName", lineName);
	   request.setAttribute("lineId",lineId);
	   request.setAttribute("price", price);
	   request.setAttribute("rNames", realNames);
	   request.setAttribute("tels",tels);
	   request.setAttribute("IdCards", IdCards);
	   request.setAttribute("vehicle", vehicle);
	   request.setAttribute("totals",totalsPrice);
	   request.setAttribute("target",target);
	   request.setAttribute("carId", carId);
	   request.setAttribute("td", travelDate);
	   request.getRequestDispatcher("./settlement.jsp").forward(request, response);
		  
   }
  
   
 
   
	
}
