package com.cn.utils;



public class PagingUitls {
	
	//��ѯ��¼��
	 private int totalRecords;
	
	//�ڼ�ҳ
	 private int currentPage;
	
	//ÿҳ��������¼
	 private int pageSize;
	
	//��ҳ��
	 public int getTotalPages(){
	    
		 return totalRecords%pageSize==0?totalRecords/pageSize:(totalRecords/pageSize+1);
	    	
	   
	 }
	
	 //��ʼ����
	 public int  beginSize(){
		 int a=(this.currentPage-1)*pageSize;
		  return a;
	 }

	 public   void  executePaging(String currentPage,int totalRecords,int pageSize){
		   this.currentPage=currentPage==null?1:Integer.parseInt(currentPage);
		   this.totalRecords=totalRecords;
		   this.pageSize=pageSize;
	 }

	
	
	
	 public int getTotalRecords() {
	    return totalRecords;
     }
	 
	 public int getCurrentPage() {
	   return currentPage;
	 }
	
	 public int getPageSize() {
	   return pageSize;
	 }
	
	

}
