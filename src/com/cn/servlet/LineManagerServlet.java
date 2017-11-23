package com.cn.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cn.dao.LineDao;
import com.cn.dao.LineTypeDao;
import com.cn.dao.PictureDao;
import com.cn.dao.TouristDao;
import com.cn.pojo.Line;
import com.cn.pojo.LineType;
import com.cn.pojo.Picture;
import com.cn.utils.PagingUitls;
import com.cn.utils.TypeEnum;

public class LineManagerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	         String  flag=request.getParameter("flag");
	         System.out.println(flag);
	          if("_showLine".equals(flag)){
	        	 
	        	 this.showLine(request, response);
	         }else if("_partLine".equals(flag)){
	        	 
	        	 this.showPartLine(request, response);
	        	 
	         }else if("_specific".equals(flag)){
	        	 this.showSpecificLine(request, response);
	        	 
	         }else if("_hot".equals(flag)){
	        	 
	        	 this.showAllHotLine(request, response);
	         }else if("_allLine".equals(flag)){
	        	 
	        	 this.showLineTypeOfLine(request, response);
	         }else if("_team".equals(flag)){
	        	 
	        	 this.showLineTypeOfTeamBuyLine(request, response);
	         }
	}
	//��ʾ��ҳ����·���ͼ����ͼ������е���·
	public void  showLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
            //��ѯ�ܳ�������
		    int  touristCount=new TouristDao().findAllTouristCount();
		    LineDao lineDao=new LineDao();
		    LineTypeDao lineTypeDao=new LineTypeDao();
		    List<LineType> listLineType=lineTypeDao.findTopLine(5);;
		    //��ʾ��ҳ���β�Ʒ�����ǰ5���������Ͷ�Ӧ����·
		   // Map<LineType,List<Line>> lineListMap=new HashMap<LineType,List<Line>>();
		    List<List<Line>> listLineList=new ArrayList<List<Line>>();
		    for(LineType lineType:listLineType){
		    	
		    	List<Line> lineList=lineDao.findLine(lineType.getLineTypeID(),6);
		        listLineList.add(lineList);
		    }
		    request.setAttribute("listType", listLineType);
		    request.setAttribute("llList",listLineList);
		    request.setAttribute("ltl", listLineType);
		    //��ѯ��ʾҳ��ǰ�������Ź�
		   // List<Line> teamBuylineList=lineDao.findLine(1, 1, 4);
		   // request.setAttribute("tbList", teamBuylineList);
		    //һ����
		    List<Line>  oneDaysLineList=lineDao.findLineByDays(1, 9);
		    //������
		    List<Line>  twoDasyLineList=lineDao.findLineByDays(2, 9);
		    //������
		    List<Line>  threeDasyLineList=lineDao.findLineByDays(3, 9);
		    request.setAttribute("odll", oneDaysLineList);
		    request.setAttribute("tdll", twoDasyLineList);
		    request.setAttribute("thdll",threeDasyLineList);
			//�����ŵ�ǰ3����·
		    List<Line> hostLineList=lineDao.findAllHotLine(3);
		    PictureDao pictureDao=new PictureDao();
            List<Picture> hotLinePicList=new ArrayList<Picture>();
	        //��ȡ�����ŵ�������·��ͼƬ
	        for(Line line:hostLineList){
	        	hotLinePicList.add(pictureDao.findPictrue(line.getLineID()).get(0));
	        }
	        request.setAttribute("hpicList", hotLinePicList);
	        request.setAttribute("hostLineList",hostLineList);
	        //��ѯ�Ź���������ǰ4�����Ź���·
	        List<Line> top4TeamLineList=lineDao.queryTeamBuyLineList(0,4,1);	
	        List<Picture> picList=new ArrayList<Picture>();
	        
	        for(Line line:top4TeamLineList){
	        	   picList.add(pictureDao.findPictrue(line.getLineID()).get(0));
	        }
	        request.setAttribute("picList", picList);
	        request.setAttribute("t4tll", top4TeamLineList);
	        request.setAttribute("count", touristCount);
		    request.getRequestDispatcher("./main.jsp").forward(request, response);
	
	}
	//��ʾ��ҳ��������������ʾ��Ϣ
	public void  showPartLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		   LineTypeDao lineTypeDao=new LineTypeDao();
		   List<LineType> listLineType=lineTypeDao.findTopLine(4);
		   //��ȡ��·����ID
	       String  lineTypeID=request.getParameter("lineTypeID");
		   LineDao lineDao=new LineDao();
		   List<Line> partLineList=lineDao.findLine(lineTypeID, 6);
		   List<Integer> countList=new ArrayList<Integer>();
		   TouristDao  touristDao=new TouristDao();
		   for(Line line:partLineList){
			   //����ѯ����ÿ����·�ĳ������������countListԪ����
			   countList.add(touristDao.findTouristCount(line.getLineID()));
		   }
		    List<Picture> picList=new ArrayList<Picture>();
	        PictureDao pictureDao=new PictureDao();
	        for(Line line:partLineList){
	        	   picList.add(pictureDao.findPictrue(line.getLineID()).get(0));
	        }
	        request.setAttribute("picList", picList);
		   request.setAttribute("countList", countList);
		   request.setAttribute("pll", partLineList);
		   request.setAttribute("llt",listLineType); 
		   request.getRequestDispatcher("./linetype.jsp").forward(request, response);
    }
	//��ʾ������·����
	public void  showSpecificLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LineDao lineDao=new LineDao();
	    LineTypeDao lineTypeDao=new LineTypeDao();
	    List<LineType> listLineType=lineTypeDao.findTopLine(5);
	    //��ʾ��ҳ���β�Ʒ�����ǰ5���������Ͷ�Ӧ����·
	      request.setAttribute("ltl", listLineType);
		  String   lineId=request.getParameter("lineId");
          Line line=lineDao.findLineById(lineId);
          request.setAttribute("line", line);
          PictureDao pictureDao=new PictureDao();
          List<Picture> pictureList=pictureDao.findPictrue(lineId);
          request.setAttribute("picList",pictureList);
          TouristDao  touristDao=new TouristDao();
          //��ѯ������·����������
          int count=touristDao.findTouristCount(lineId);
          request.setAttribute("count", count);
          request.getRequestDispatcher("./checkline.jsp").forward(request, response);
	}
	//��ʾ������·����������ǰ5��·�ߺ͵�ǰ�鿴��·����������·ǰ10��
	public  void  showAllHotLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		    String    lineTypeID=request.getParameter("lineTypeId");
		    LineDao lineDao=new LineDao();
		    String typeName=request.getParameter("typeName");
		    List<Line> hostLineList=lineDao.findAllHotLine(5);
	        request.setAttribute("hostLineList",hostLineList);
	        request.setAttribute("lineTypeId", lineTypeID);
	        request.setAttribute("typeName", typeName);
			//��ѯĳһ��·�����е�������·��ǰ10������
		    List<Line> hotLineOfTypeList=lineDao.findHotLnie(lineTypeID, 10);
		    //��ȡ��ǰ������·ǰ10����·������ͼƬ�ĵ�һ�Ŵ�ŵ�picList��
		    List<Picture> picList=new ArrayList<Picture>();
		    PictureDao picDao=new PictureDao();
		    for(Line line:hotLineOfTypeList){
		    	picList.add(picDao.findPictrue(line.getLineID()).get(0));
		    	
		    }
		    this.showLineTypeOfTeamBuyLine(request, response);
		    LineTypeDao lineTypeDao=new LineTypeDao();
            List<LineType> listLineType=lineTypeDao.findTopLine(4);
    	    request.setAttribute("ltl", listLineType);
		    request.setAttribute("picList",picList);
		    request.setAttribute("htpLineList", hotLineOfTypeList);
	        request.getRequestDispatcher("./lineclassify.jsp").forward(request, response);
	}
	//��ʾĳһ��·����ȫ����·
	public  void  showLineTypeOfLine(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		  String   lineTypeID=request.getParameter("lineTypeId");
		  LineDao lineDao=new LineDao();
		  String currentPage=request.getParameter("currentPage");

		   int totalRecords=lineDao.findTypeLineCount(lineTypeID);
		   PagingUitls pagingUitls=new PagingUitls();
		   pagingUitls.executePaging(currentPage, totalRecords, 8);
		    //��ǰ��·����������·
		   List<Line> lineList=lineDao.findLineByLineTypeID(lineTypeID,pagingUitls.beginSize(), 8);
		   List<Picture> picList=new ArrayList<Picture>();
		   PictureDao picDao=new PictureDao();
		    for(Line line:lineList){
		    	picList.add(picDao.findPictrue(line.getLineID()).get(0));
		    	
		    }
		   request.setAttribute("picList",picList);
		   request.setAttribute("currentPage",pagingUitls.getCurrentPage());
	       request.setAttribute("lineList",   lineList);
	       request.setAttribute("bottomPage", pagingUitls.getTotalPages());
	       request.setAttribute("lineTypeId", lineTypeID);
	       request.getRequestDispatcher("./linetypeinner.jsp").forward(request, response);
	}
	
	
	//��ʾĳһ��·�����Ź���·
		public  void  showLineTypeOfTeamBuyLine(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			  String   lineTypeID=request.getParameter("lineTypeId");
			  LineDao lineDao=new LineDao();
			  String currentPage=request.getParameter("currentPage");
			   int totalRecords=lineDao.findTeamTypeLineCount(lineTypeID, 1);
			   PagingUitls pagingUitls=new PagingUitls();
			   pagingUitls.executePaging(currentPage, totalRecords, 3);
			    //��ǰ��·���������Ź���·
			   List<Line> teamLineList=lineDao.findLine(lineTypeID, 1, pagingUitls.beginSize(), 3);	
			   System.out.println(teamLineList);
			   List<Picture> picList=new ArrayList<Picture>();
			   PictureDao picDao=new PictureDao();
			   for(Line line:teamLineList){
			    	picList.add(picDao.findPictrue(line.getLineID()).get(0));
			    	
			   }
			   request.setAttribute("pList",picList);
		       request.setAttribute("currentPage",pagingUitls.getCurrentPage());
		       request.setAttribute("tlList",   teamLineList);
		       request.setAttribute("bottomPage", pagingUitls.getTotalPages());
		       request.setAttribute("lineTypeId", lineTypeID);
		     
		}
		
	
		
				

}
