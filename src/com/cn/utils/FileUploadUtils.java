package com.cn.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspsmart.upload.File;
import com.jspsmart.upload.Files;
import com.jspsmart.upload.Request;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

public class FileUploadUtils {
	private  Request req;
    private  SmartUpload smartUpload;
	private  String path;
	private  HttpServletRequest request;
	private  List<String> fileNames=new ArrayList<String>();

    public   Request getRequest(){
    	return this.req;
    }
    public void init(HttpServlet servlet,HttpServletRequest request,HttpServletResponse response,String dir) throws ServletException{
    	path=this.getRootPath()+"/"+servlet.getServletConfig().getInitParameter("SAVEPATH")+"/"+dir+"/";
        this.request=request;
		/*ʵ����JspSmartUpload����е�SmartUpload����
		   ��������������ʵ���ϴ�*/
	    smartUpload = new SmartUpload();
		//smartUpload������г�ʼ��
		smartUpload.initialize(servlet.getServletConfig(), request, response);
		
		//���������ϴ��ļ��ܵĴ�С
		smartUpload.setTotalMaxFileSize(1024*1024*10*4);
		//���õ����ϴ��ļ��Ĵ�СΪ
		smartUpload.setMaxFileSize(1024*1024*10);
    }
	public  boolean  upload() throws IOException, ServletException {
		
		try {

			//����upload����ʵ���ļ�
			smartUpload.upload();
			this.req=smartUpload.getRequest();
			//��ȡ�����б��ύ���ϴ������ļ�������
			Files files=smartUpload.getFiles();
			for(int j=0;j<files.getCount();j++){
			//����JspSmartUpload�����File��ÿһ��file�������һ��form�����ļ���
			  File file=files.getFile(j);
			  //��ȡ�ϴ��ļ����ļ���
			  String fileName=file.getFileName();
			  if(fileName==null || "".equals(fileName)){
				  
				  continue;
			  }
			  
			  this.fileNames.add(fileName);
			  //���ϴ����ļ����б��浽ָ��λ����
			  createFolder(path);
			  file.saveAs(path+fileName);
			  
			  request.setAttribute("msg", "�ļ��ϴ��ɹ�");
			
			}
			return true;
		}catch (SmartUploadException e) {
			e.printStackTrace();
		}catch(SecurityException e){
			/*�������ļ���չ�����������ļ���С��
			   �����ᶼ�����SecurityException
			  ���Ƕ����쳣��Ϣ����״̬�벻ͬ����
			  ����Ҫ��ȡ�쳣��Ϣ��õ�״̬������ж�*/
		   String code=	returnException(e);
		   String Msg=null;
		   //��չ��������
		   if("1015".equals(code)){
			   Msg="�ϴ��ļ���չ������";
			  
		   }//�ļ���С����
		   else if("1105".equals(code)){
			   Msg="�ϴ��ļ���С����";
		   }
		   request.setAttribute("msg", Msg);
		
		}
		
		return false;
	  
	}
	//�������ͼƬ���ļ���
	private   void  createFolder(String  folderName){
		
		  java.io.File  file=new  java.io.File(folderName);
		  if(!file.exists()){//�ж��ļ����Ƿ����
			    //��������ڴ���Ŀ¼
			   file.mkdirs();
		  }
	}
	//��ȡ�������µ�ǰ��Ŀ�ĸ�Ŀ¼
	private  String  getRootPath(){
		
		String path=this.getClass().getResource("/").toString();
		return GeneralUtils.getString(GeneralUtils.getString(path, "file:/", "%20", " ", 1),"WEB-INF/classes/", null, null, 0); 

	}
	/*�ж�״̬��
	 *״̬��1015Ϊ��չ��������Ҫ��
	 *״̬��1105Ϊ�ļ���С������Ҫ��
	 **/
	private    String    returnException(Exception e){
		
		 //��ȡ�쳣��Ϣ����  
		 String exceptionMsg=e.getMessage();
		 //��ȡ��һ"("λ��
		 int bIndx=exceptionMsg.indexOf("(");
		 //��ȡ���һ��")"λ��
		 int eIndex=exceptionMsg.indexOf(")");
		 //��ȡ״̬��
		 String code=exceptionMsg.substring(bIndx+1, eIndex);
		 return code;
		 
	}
//	//ɾ���ļ�����
//	private void  removeFile(java.io.File  fileList){
//		  java.io.File[] files= fileList.listFiles();
//		  if(files.length>0){
//			  for(java.io.File file:files){
//				  
//				   file.delete();
//			  }
//			  
//		  }
//
//	}
	public  List<String> getFileNames(){
		
		return this.fileNames;
	}
}
