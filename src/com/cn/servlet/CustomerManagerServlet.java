package com.cn.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cn.dao.CarDao;
import com.cn.dao.CustomerDao;
import com.cn.pojo.Customer;

public class CustomerManagerServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	    String  flag=request.getParameter("flag");
	    System.out.println(flag);
	    if("_login".equals(flag)){	    
	    	this.login(request, response);
	    }else if("_register".equals(flag)){
	    	this.register(request, response);
	    }
	}
	//��¼
	public void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		   String account=request.getParameter("account");
		   String password=request.getParameter("password");
		   String timeout=request.getParameter("timeout");
		   CustomerDao  customerDao=new CustomerDao();
		   Customer customer=customerDao.findCustomer(account, password);
		   //�˺�������ȷ
		   if(customer!=null){
			     HttpSession session=request.getSession();
			     session.setAttribute("account",account);
			     session.setAttribute("customerID",customer.getCustomerID());
				 //String timeout=request.getParameter("timeout");
			     if("on".equals(timeout)){
			    	 //������Cookie����
				     Cookie cookie1=new Cookie("account",account);
				     Cookie cookie2=new Cookie("password",password);
				     //���ÿ��Ի�ȡcookie��·��
				     cookie1.setPath("/");
				     cookie2.setPath("/");
				     cookie1.setMaxAge(60*60*24*30);
				     cookie2.setMaxAge(60*60*24*30);
				     response.addCookie(cookie1);
				     response.addCookie(cookie2);
			     }
			   CarDao carDao=new CarDao();
			   //��ȡ��ǰ�û����ﳵ��������·��������
			   int carLineCount=carDao.count(customer.getCustomerID());
			   session.setAttribute("clc", carLineCount);
			   request.getRequestDispatcher("LineManagerServlet?flag=_showLine").forward(request, response);
		   }else{
			   
			   request.setAttribute("msg","�Բ����˺Ż���������");
			   request.getRequestDispatcher("./login.jsp").forward(request, response);
		   }
	}
	//ע��
	public  void register(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String  account=request.getParameter("account");
		CustomerDao customerDao=new CustomerDao();
		Customer customer=customerDao.findCustomer(account, null);
		//���˺Ų�����
		if(customer==null){//
			String  password=request.getParameter("password");
			String  realName=request.getParameter("realname");
			String  IDCard=request.getParameter("IdCard");
			//��ȡ���ύ���Ա�
			String  gender=request.getParameter("gender");
			String tel=request.getParameter("tel");
			//��ȡ�������֤��
			String  code=request.getParameter("code");
			//��ȡSession�б������֤��
			String sessionCode=(String)request.getSession().getAttribute("safeCode");
			//�ж��û��������֤���Ƿ���ȷ
			if(sessionCode.equals(code)){
				 customer=new Customer();
				 customer.setAccount(account);
				 customer.setPassword(password);
				 customer.setGender(gender);
				 customer.setIdentityID(IDCard);
				 customer.setTel(tel);
				 customer.setName(realName);
				 customerDao.addCustomer(customer);
				 request.setAttribute("msg","ע��ɹ�");
				
			}else{
				request.setAttribute("msg","��֤�벻��ȷ");
			}
			
		}else{//���˺��Ѿ���ע��
			request.setAttribute("msg","���˺��Ѵ���");
		}
		request.getRequestDispatcher("./register.jsp").forward(request, response);
		
	}
	
	

}
