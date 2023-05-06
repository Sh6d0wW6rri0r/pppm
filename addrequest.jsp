
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
        String PROJECTID = request.getParameter("PROJECTID");
        String PRODUCTID = request.getParameter("PRODUCTID");
        String PROGRAMID = request.getParameter("PROGRAMID");
        String REQTYPE = request.getParameter("REQTYPE");
        String REQ = request.getParameter("REQ");
        
        PPPMTools pt = new PPPMTools(); 
      	boolean isthereaction = false;
    	if(act.equals("ADDCLOSE")) {
          REQTYPE = request.getParameter("REQTYPE");         
          if (REQTYPE.equals("PROJECT")) {
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
              Project p = new Project(Conn);
              p.setName(pt.checkStr(request.getParameter("NAME")));
              p.setDescription(pt.checkStr(request.getParameter("DESCRIPTION")));
              p.setFownerid(FOWNERID);
              p.setDatestart(request.getParameter("DATE_START"));
              p.setDateend(request.getParameter("DATE_END"));
            }
          } else {
            if (REQTYPE.equals("PRODUCT")) {
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
                Product p = new Product(Conn);
                p.setName(pt.checkStr(request.getParameter("NAME")));
                p.setDescription(pt.checkStr(request.getParameter("DESCRIPTION")));
                p.setFownerid(FOWNERID);
                p.setDatestart(request.getParameter("DATE_START"));
                p.setDateend(request.getParameter("DATE_END"));
              }
            } else {
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
                Program p = new Program(Conn);
                p.setName(pt.checkStr(request.getParameter("NAME")));
                p.setDescription(pt.checkStr(request.getParameter("DESCRIPTION")));
                p.setFownerid(FOWNERID);
                p.setDatestart(request.getParameter("DATE_START"));
                p.setDateend(request.getParameter("DATE_END"));
              }
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
          String NAME = "";
          String FOWNERID = "";
          String DESCRIPTION = "";
          Calendar rn= Calendar.getInstance();
          String DATE_START = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
          String DATE_END = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
          if (act.equals("ADD")) {
            out.print("<form name=\"formFILTER\" method=\"post\" action=\"addrequest.jsp?TODO=ADDCLOSE\" target=\"_top\">");
          } else {
            if (REQ.equals("Y")) {
              if (REQTYPE.equals("PROJECT")) {
                out.print("<form name=\"formFILTER\" method=\"post\" action=\"requestdetails.jsp?TODO=PRJMOD&PROJECTID="+PROJECTID+"\" target=\"_top\">");
              } else {
                if (REQTYPE.equals("PRODUCT")) {
                  out.print("<form name=\"formFILTER\" method=\"post\" action=\"requestproductdetails.jsp?TODO=PRDMOD&PRODUCTID="+PRODUCTID+"\" target=\"_top\">");
                } else {
                  out.print("<form name=\"formFILTER\" method=\"post\" action=\"requestprogramdetails.jsp?TODO=PGMMOD&PROGRAMID="+PROGRAMID+"\" target=\"_top\">");
                }
              }
            } else {
              if (REQTYPE.equals("PROJECT")) {
                out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectdetails.jsp?TODO=PRJMOD&PROJECTID="+PROJECTID+"\" target=\"_top\">");
              } else {
                if (REQTYPE.equals("PRODUCT")) {
                  out.print("<form name=\"formFILTER\" method=\"post\" action=\"productdetails.jsp?TODO=PRDMOD&PRODUCTID="+PRODUCTID+"\" target=\"_top\">");
                } else {
                  out.print("<form name=\"formFILTER\" method=\"post\" action=\"programdetails.jsp?TODO=PGMMOD&PROGRAMID="+PROGRAMID+"\" target=\"_top\">");
                }
              }
            }          
          }
          if (act.equals("MOD")) {
            if (REQTYPE.equals("PROJECT")) {
              Statement STR01 = Conn.createStatement();
              String QR01 = "SELECT ID,NAME,FOWNERID,DESCRIPTION,DATE_START,DATE_END FROM PROJECT WHERE ID='"+PROJECTID+"'";
              ResultSet R01 = STR01.executeQuery(QR01);
              if (R01.next()) {
                NAME=R01.getString("NAME");
                FOWNERID=R01.getString("FOWNERID");
                DESCRIPTION=R01.getString("DESCRIPTION");
                DATE_START=R01.getString("DATE_START");
                DATE_END=R01.getString("DATE_END");
              }
              STR01.close();
            } else {
              if (REQTYPE.equals("PRODUCT")) {
                Statement STR01 = Conn.createStatement();
                String QR01 = "SELECT ID,NAME,FOWNERID,DESCRIPTION,DATE_START,DATE_END FROM PRODUCT WHERE ID='"+PRODUCTID+"'";
                ResultSet R01 = STR01.executeQuery(QR01);
                if (R01.next()) {
                  NAME=R01.getString("NAME");
                  FOWNERID=R01.getString("FOWNERID");
                  DESCRIPTION=R01.getString("DESCRIPTION");
                  DATE_START=R01.getString("DATE_START");
                  DATE_END=R01.getString("DATE_END");
                }
                STR01.close();
              } else {
                Statement STR01 = Conn.createStatement();
                String QR01 = "SELECT ID,NAME,FOWNERID,DESCRIPTION,DATE_START,DATE_END FROM PROGRAM WHERE ID='"+PROGRAMID+"'";
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
            }
          }
          out.print("<table>");
          if (!act.equals("MOD")) {
            out.print("<tr><td>Request type : </td><td><select name=\"REQTYPE\">");
            out.print("<option selected>PROJECT</option>");
            out.print("<option>PRODUCT</option>");
            out.print("<option>PROGRAM</option>");
            out.print("</select></td></tr>");
          }
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
            out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
            out.print("<td><A HREF=\"addrequest.jsp?TODO=CLOSE\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
          } else {
            if (REQTYPE.equals("PROJECT")) {  
              out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
              out.print("<td><A HREF=\"requestdetails.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
            } else {
              if (REQTYPE.equals("PRODUCT")) {
                out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
                out.print("<td><A HREF=\"requestproductdetails.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
              } else {
                out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
                out.print("<td><A HREF=\"requestprogramdetails.jsp?TODO=NONE&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
              }  
            }
          }
          out.print("</table>");
          out.print("</form>");
        }
        Conn.close();
      }

    %>
  </body>
</html>
