package com.cn.pojo;


//�ͻ�������ϸ��
public class OrderDetail {
	private String odID;//�������
	private int customerID;//�ͻ����
	private String  lineName;//��·��
	private double  price;//�۸�
	private  String  orderDate;//����ʱ��
	private  double total;//�ܼ�
	private  String  lineID;//��·ID
	private  int state;//״̬
	private  String  travelDate;//����ʱ��
	
	public String getOdID() {
		return odID;
	}
	public void setOdID(String odID) {
		this.odID = odID;
	}
	public int getCustomerID() {
		return customerID;
	}
	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}
	public String getLineName() {
		return lineName;
	}
	public void setLineName(String lineName) {
		this.lineName = lineName;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public String getLineID() {
		return lineID;
	}
	public void setLineID(String lineID) {
		this.lineID = lineID;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getTravelDate() {
		return travelDate;
	}
	public void setTravelDate(String travelDate) {
		this.travelDate = travelDate;
	}
	
	
	
	
	
}
