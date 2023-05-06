
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: 11px}
      h1 { color: black; font-family: arial; font-size: 16px}
    </style> 
  </head>

    <%-- PPPM.ORG, the OpenSource PPM (Portfolio, Project and Program management) system --%>
    <%-- Copyright (C) 2012  Olivier Moulin --%>

    <%-- This program is free software: you can redistribute it and/or modify --%>
    <%-- it under the terms of the GNU General Public License as published by --%>
    <%-- the Free Software Foundation, version 3 of the License. --%>

    <%-- This program is distributed in the hope that it will be useful, --%>
    <%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
    <%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
    <%-- GNU General Public License for more details. --%>

    <%-- You should have received a copy of the GNU General Public License --%>
    <%-- along with this program.  If not, see http://www.gnu.org/licenses/. --%>


  <%@ page import = "java.sql.*" %>
  <%@ page import = "java.util.*" %>
  <%@ page import = "java.util.Date" %>
  <%@ page import = "java.util.Calendar" %>
  <%@ page import = "java.text.SimpleDateFormat" %>
  <%@ page import = "java.util.GregorianCalendar" %>
  <%@ page import = "java.text.DateFormat" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>
  <%@ page import = "fr.pppm.*" %>

  <body background="images/fond.gif">
    <script language="JavaScript" src="javascript/calendar_db.js"></script>
    <link rel="stylesheet" href="javascript/calendar.css">
    <%
      // session attributes
      String Userlogin = (String)session.getAttribute("LOGIN");


      if (Userlogin==null) {
        out.print("<script language=\"JavaScript\">");
        out.print("top.location='index.jsp?TIMEOUT=TRUE';");
        out.print("</script>");
      } else {
        String POOLNAME=(String)session.getAttribute("POOLNAME");

        // database connection
        Context initCtx = new InitialContext();
        DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
        Connection Conn = ds.getConnection();

        // JSP parameters
        String act = request.getParameter("TODO");
        String PROJECTID = request.getParameter("PROJECTID");
        String REQTYPE = request.getParameter("REQTYPE");
        String PRODUCTID = request.getParameter("PRODUCTID");
        String PROGRAMID = request.getParameter("PROGRAMID");
      	boolean isthereaction = false;
    	if (act.equals("APPROVECLOSE")) {
          REQTYPE = request.getParameter("REQTYPE");   
          if (REQTYPE.equals("PROJECT")) {
            PROJECTID = request.getParameter("PROJECTID");
            String PHASETEMPLATE  = request.getParameter("PHASETEMPLATE");
            String CT = request.getParameter("CAPACITYTRIANGLE");
            String CAPACITYTRIANGLE = CT.substring(0,1);
            Project p = new Project(Conn,PROJECTID);
            p.defineTemplate(PHASETEMPLATE,CAPACITYTRIANGLE);
          } else {
            if (REQTYPE.equals("PRODUCT")) {
              PRODUCTID = request.getParameter("PRODUCTID");
              String PHASETEMPLATE  = request.getParameter("PHASETEMPLATE");
              Product p = new Product(Conn,PRODUCTID);
              p.defineTemplate(PHASETEMPLATE);
            } else {
              PROGRAMID = request.getParameter("PROGRAMID");
              String PHASETEMPLATE  = request.getParameter("PHASETEMPLATE");
              Program p = new Program(Conn,PROGRAMID);
              p.defineTemplate(PHASETEMPLATE);
            }                    
          }
  		  out.print("<script language=\"JavaScript\">");
  	  	  out.print("window.close();"); 
  		  out.print("</script");
  		  isthereaction=true;
    	}
    	
  	  	if (act.equals("CLOSE")) {
    	  out.print("<script language=\"JavaScript\">");
    	  out.print("window.close();"); 
          out.print("</script");  	
          isthereaction=true;
    	}
  	  	if (!isthereaction) {
  	  	
    	  if (REQTYPE.equals("PROJECT")) {
            if (act.equals("PORTADD")) {
              String PORTFOLIOID  = request.getParameter("PORTFOLIOID");
              Project p = new Project(Conn,PROJECTID);
              p.addRequestPortfolio(PORTFOLIOID);
            }
            if (act.equals("PORTDEL")) {
              String PORTFOLIOID  = request.getParameter("PORTFOLIOID");
              Project p = new Project(Conn,PROJECTID);
              p.delRequestPortfolio(PORTFOLIOID);
            }
          } else {
            if (REQTYPE.equals("PRODUCT")) {
              if (act.equals("PORTADD")) {
                String PORTFOLIOID  = request.getParameter("PORTFOLIOID");
                Product p = new Product(Conn,PRODUCTID);
                p.addRequestPortfolio(PORTFOLIOID);
              }
              if (act.equals("PORTDEL")) {
                String PORTFOLIOID  = request.getParameter("PORTFOLIOID");
                Product p = new Product(Conn,PRODUCTID);
                p.delRequestPortfolio(PORTFOLIOID);
              }
            } else {
              if (act.equals("PORTADD")) {
                String PORTFOLIOID  = request.getParameter("PORTFOLIOID");
                Program p = new Program(Conn,PROGRAMID);
                p.addRequestPortfolio(PORTFOLIOID);
              }
              if (act.equals("PORTDEL")) {
                String PORTFOLIOID  = request.getParameter("PORTFOLIOID");
                Program p = new Program(Conn,PROGRAMID);
                p.delRequestPortfolio(PORTFOLIOID);
              }
            }
          }
          out.print("<hr>");
          if (REQTYPE.equals("PROJECT")) {
            out.print("<form name=\"formFILTER\" method=\"post\" action=\"approverequest.jsp?TODO=APPROVECLOSE&PROJECTID="+PROJECTID+"&REQTYPE="+REQTYPE+"\" target=\"_top\">");
            out.print("<table>");
            out.print("<tr><td>Do you want this request to be transformed into a project and become active</td></tr>");
            out.print("<tr><td>Capacity triangle assignment</td><td><select name=\"CAPACITYTRIANGLE\">");
            out.print("<option>Local</option>");
            out.print("<option>Global</option>");
            out.print("</select></td></tr>");
            out.print("<tr><td>Planning type to apply to the project : </td><td><select name=\"PHASETEMPLATE\">");
            Statement STR01 = Conn.createStatement();
            String QR01 = "SELECT DISTINCT(TEMPLATE) FROM PHASE_TEMPLATE";
            ResultSet R01 = STR01.executeQuery(QR01);
            while (R01.next()) {
              out.print("<option");
              out.print(">"+R01.getString("TEMPLATE")+"</option>");        
            }
            STR01.close();
            out.print("</select></td></tr>");
            out.print("</table><br><br>");
            out.print("<table><tr><td><h2><strong>Portfolios(s) on which the project will be added</strong></h2></center></td>");
            out.print("<td><A HREF=\"pickrequestportfolio.jsp?TODO=ADD&PROJECTID="+PROJECTID+"&REQTYPE="+REQTYPE+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
            out.print("<td>&nbsp;</td>");
            out.print("</tr></table>");
            out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
            out.print("<tr>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
            out.print("</tr>");
            Statement STR02 = Conn.createStatement();
            String QR02 = "SELECT ID,NAME FROM PORTFOLIO WHERE ID IN (SELECT PORTFOLIOID FROM PRJPOR WHERE PROJECTID='"+PROJECTID+"')";
            ResultSet R02 = STR02.executeQuery(QR02);
            while(R02.next()) {
              out.print("<tr>");
              out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("ID")+"</center></td>");
              out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("NAME")+"</center></td>");
              out.print("<td><center><A HREF=\"deleterequestportfolio.jsp?TODO=DELETE&PORTFOLIOID="+R02.getString("ID")+"&PROJECTID="+PROJECTID+"&REQTYPE="+REQTYPE+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
              out.print("</tr>");
            }
            STR02.close();
          } else {
            if (REQTYPE.equals("PRODUCT")) {
              out.print("<form name=\"formFILTER\" method=\"post\" action=\"approverequest.jsp?TODO=APPROVECLOSE&PRODUCTID="+PRODUCTID+"&REQTYPE="+REQTYPE+"\" target=\"_top\">");
              out.print("<table>");
              out.print("<tr><td>Do you want this request to be transformed into a project and become active</td></tr>");
              out.print("<tr><td>Planning type to apply to the project : </td><td><select name=\"PHASETEMPLATE\">");
              Statement STR01 = Conn.createStatement();
              String QR01 = "SELECT DISTINCT(TEMPLATE) FROM PHASE_TEMPLATE";
              ResultSet R01 = STR01.executeQuery(QR01);
              while (R01.next()) {
                out.print("<option");
                out.print(">"+R01.getString("TEMPLATE")+"</option>");        
              }
              STR01.close();
              out.print("</select></td></tr>");
              out.print("</table><br><br>");
              out.print("<table><tr><td><h2><strong>Portfolios(s) on which the project will be added</strong></h2></center></td>");
              out.print("<td><A HREF=\"pickrequestportfolio.jsp?TODO=ADD&PRODUCTID="+PRODUCTID+"&REQTYPE="+REQTYPE+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
              out.print("<td>&nbsp;</td>");
              out.print("</tr></table>");
              out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
              out.print("<tr>");
              out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
              out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
              out.print("</tr>");
              Statement STR02 = Conn.createStatement();
              String QR02 = "SELECT ID,NAME FROM PORTFOLIO WHERE ID IN (SELECT PORTFOLIOID FROM PRDPOR WHERE PRODUCTID='"+PRODUCTID+"')";
              ResultSet R02 = STR02.executeQuery(QR02);
              while(R02.next()) {
                out.print("<tr>");
                out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("ID")+"</center></td>");
                out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("NAME")+"</center></td>");
                out.print("<td><center><A HREF=\"deleterequestportfolio.jsp?TODO=DELETE&PORTFOLIOID="+R02.getString("ID")+"&PRODUCTID="+PRODUCTID+"&REQTYPE="+REQTYPE+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
                out.print("</tr>");
              }
              STR02.close();
            } else {
              out.print("<form name=\"formFILTER\" method=\"post\" action=\"approverequest.jsp?TODO=APPROVECLOSE&PROGRAMID="+PROGRAMID+"&REQTYPE="+REQTYPE+"\" target=\"_top\">");
              out.print("<table>");
              out.print("<tr><td>Do you want this request to be transformed into a program and become active</td></tr>");
              out.print("</table><br><br>");
              out.print("<table><tr><td><h2><strong>Portfolios(s) on which the program will be added</strong></h2></center></td>");
              out.print("<td><A HREF=\"pickrequestportfolio.jsp?TODO=ADD&PROGRAMID="+PROGRAMID+"&REQTYPE="+REQTYPE+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
              out.print("<td>&nbsp;</td>");
              out.print("</tr></table>");
              out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
              out.print("<tr>");
              out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
              out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
              out.print("</tr>");
              Statement STR02 = Conn.createStatement();
              String QR02 = "SELECT ID,NAME FROM PORTFOLIO WHERE ID IN (SELECT PORTFOLIOID FROM PGMPOR WHERE PROGRAMID='"+PROGRAMID+"')";
              ResultSet R02 = STR02.executeQuery(QR02);
              while(R02.next()) {
                out.print("<tr>");
                out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("ID")+"</center></td>");
                out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("NAME")+"</center></td>");
                out.print("<td><center><A HREF=\"deleterequestportfolio.jsp?TODO=DELETE&PORTFOLIOID="+R02.getString("ID")+"&PROGRAMID="+PROGRAMID+"&REQTYPE="+REQTYPE+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
                out.print("</tr>");
              }
              STR02.close();
            }          
          }
          out.print("</table><br><br>");
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/approve.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"approverequest.jsp?TODO=CLOSE\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>"); 
          out.print("</table>");
          out.print("</form>");
        }
        Conn.close();
      }

    %>
  </body>
</html>
