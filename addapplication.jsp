
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
  
  <body>
    <script language="JavaScript" src="javascript/calendar_db.js"></script>
    <link rel="stylesheet" href="javascript/calendar.css">
    <script>

    </script>
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
        String APPLICATIONID = request.getParameter("APPLICATIONID");
        String REQ = request.getParameter("REQ");
        
        PPPMTools pt = new PPPMTools(); 
      	boolean isthereaction = false;
    	if (act.equals("ADDCLOSE")) {
          int DDAY=0;
          int DMONTH=0;
          int DYEAR=0;
          boolean are_date_valid = true;
          try { 
            DateFormat formatter ; 
            Date date ; 
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            date = (Date)formatter.parse(request.getParameter("DATE_START")); 
            date = (Date)formatter.parse(request.getParameter("DATE_END")); 
          } catch (Exception e) { 
            are_date_valid = false; 
          }
          if (!are_date_valid) {
            out.print("<HR>ERROR - DATE INVALID, PLEASE RE-ENTER THE DATA ! <HR>");
          } else {
            String fowneridtmp = request.getParameter("FOWNERID");
            String FOWNERID = fowneridtmp.substring(0,fowneridtmp.indexOf("-")-1);
            Application p = new Application(Conn);
            p.setName(pt.checkStr(request.getParameter("NAME")));
            p.setDescription(pt.checkStr(request.getParameter("DESCRIPTION")));
            p.setFownerid(FOWNERID);
            p.setDatestart(request.getParameter("DATE_START"));
            p.setDateend(request.getParameter("DATE_END"));
            String PHASETEMPLATE  = request.getParameter("PHASETEMPLATE");
            p.defineTemplate(PHASETEMPLATE);
            String PORTFOLIOIDtmp  = request.getParameter("PORTFOLIOID");
            String PORTFOLIOID = PORTFOLIOIDtmp.substring(0,PORTFOLIOIDtmp.indexOf("-")-1);
            p.addApplicationPortfolio(PORTFOLIOID);
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
        if (act.equals("PORTADD")) {
          String PORTFOLIOID  = request.getParameter("PORTFOLIOID");
          Application p = new Application(Conn,APPLICATIONID);
          p.addApplicationPortfolio(PORTFOLIOID);
        }
        if (act.equals("PORTDEL")) {
          String PORTFOLIOID  = request.getParameter("PORTFOLIOID");
          Application p = new Application(Conn,APPLICATIONID);
          p.delApplicationPortfolio(PORTFOLIOID);
        }
    	if (!isthereaction) {
          String NAME = "";
          String FOWNERID = "";
          String DESCRIPTION = "";
          Calendar rn= Calendar.getInstance();
          String DATE_START = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
          String DATE_END = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
          if (act.equals("ADD")) {
            out.print("<form name=\"formFILTER\" method=\"post\" action=\"addapplication.jsp?TODO=ADDCLOSE\" target=\"_top\">");
          } else {
            out.print("<form name=\"formFILTER\" method=\"post\" action=\"applicationdetails.jsp?TODO=MOD&APPLICATIONID="+APPLICATIONID+"\" target=\"_top\">");
          }
          if (act.equals("MOD")) {
          	Statement STR01 = Conn.createStatement();
            String QR01 = "SELECT ID,NAME,FOWNERID,DESCRIPTION,DATE_START,DATE_END FROM APPLICATION WHERE ID='"+APPLICATIONID+"'";
            ResultSet R01 = STR01.executeQuery(QR01);
            if (R01.next()) {
              NAME=R01.getString("NAME");
              FOWNERID=R01.getString("FOWNERID");
              DESCRIPTION=R01.getString("DESCRIPTION");
              DATE_START=R01.getString("DATE_START");
              DATE_END=R01.getString("DATE_END");
            }
            STR01.close();
          }
          out.print("<table>");
          out.print("<tr><td>Name : </td><td><input name=\"NAME\" type=\"text\" size=\"50\" value=\""+NAME+"\"></td></tr>");
          out.print("<tr><td>Description : </td><td><textarea name=\"DESCRIPTION\" cols=\"60\" rows=\"5\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");
          out.print("<tr><td>Functional ownership : </td><td><select name=\"FOWNERID\">");
          Statement STR02 = Conn.createStatement();
          String QR02 = "SELECT ID,NAME FROM FOWNER";
          ResultSet R02 = STR02.executeQuery(QR02);
          while(R02.next()) {
            out.print("<option");
            if (FOWNERID.equals(R02.getString("ID"))) {
              out.print(" selected ");
            }
            out.print(">"+R02.getString("ID")+" - "+R02.getString("NAME")+"</option>");
          }
          STR02.close();
          out.print("</select></td></tr>");
          out.print("<tr><td>Date start : </td><td><input name=\"DATE_START\" type=\"text\" size=\"50\" value=\""+DATE_START+"\" readonly=\"readonly\">");
          out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_START'}); </script>");
          out.print("</td></tr>");
          out.print("<tr><td>Date end : </td><td><input name=\"DATE_END\" type=\"text\" size=\"50\" value=\""+DATE_END+"\" readonly=\"readonly\">");  
          out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_END'}); </script>");
          out.print("</td></tr></table>");
          if (act.equals("ADD")) {
            out.print("<tr><td>Initial Portfolio: </td><td><select name=\"PORTFOLIOID\">");
            Statement STR03 = Conn.createStatement();
            String QR03 = "SELECT ID,NAME FROM PORTFOLIO";
            ResultSet R03 = STR03.executeQuery(QR03);
            while(R03.next()) {
              out.print("<option");
              if (FOWNERID.equals(R03.getString("ID"))) {
                out.print(" selected ");
              }
              out.print(">"+R03.getString("ID")+" - "+R03.getString("NAME")+"</option>");
            }
            STR03.close();
            out.print("</select></td></tr>");
            out.print("<tr><td>Planning type to apply to the application : </td><td><select name=\"PHASETEMPLATE\">");
            Statement STR011 = Conn.createStatement();
            String QR011 = "SELECT DISTINCT(TEMPLATE) FROM PHASE_TEMPLATE";
            ResultSet R011 = STR011.executeQuery(QR011);
            while (R011.next()) {
              out.print("<option");
              out.print(">"+R011.getString("TEMPLATE")+"</option>");        
            }
            STR011.close();
            out.print("</select></td></tr>");
          }
          if (act.equals("MOD")) {
            out.print("</table><br><br>");
            out.print("<table><tr><td><h2><strong>Portfolios(s) on which the application will be added</strong></h2></center></td>");
            out.print("<td><A HREF=\"pickapplicationportfolio.jsp?TODO=ADD&APPLICATIONID="+APPLICATIONID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
            out.print("<td>&nbsp;</td>");
            out.print("</tr></table>");
            out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
            out.print("<tr>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
            out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
            out.print("</tr>");
            Statement STR021 = Conn.createStatement();
            String QR021 = "SELECT ID,NAME FROM PORTFOLIO WHERE ID IN (SELECT PORTFOLIOID FROM APPPOR WHERE APPLICATIONID='"+APPLICATIONID+"')";
            ResultSet R021 = STR021.executeQuery(QR021);
            while(R021.next()) {
              out.print("<tr>");
              out.print("<td bgcolor=#FFFFFF><center>"+R021.getString("ID")+"</center></td>");
              out.print("<td bgcolor=#FFFFFF><center>"+R021.getString("NAME")+"</center></td>");
              out.print("<td><center><A HREF=\"deleteapplicationportfolio.jsp?TODO=DELETE&PORTFOLIOID="+R021.getString("ID")+"&APPLICATIONID="+APPLICATIONID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
              out.print("</tr>");
            }
            STR021.close();
          }
          if (act.equals("ADD")) {
            out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
            out.print("<td><A HREF=\"addrequest.jsp?TODO=CLOSE\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
          } else {
            out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
            out.print("<td><A HREF=\"applicationdetails.jsp?TODO=NONE&APPLICATIONID="+APPLICATIONID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
          }
          out.print("</table>");
          out.print("</form>");
        }
        Conn.close();
      }

    %>
  </body>
</html>
