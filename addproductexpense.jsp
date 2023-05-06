
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
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>

  <body>
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
        String PRODUCTID = request.getParameter("PRODUCTID");
        String EXPENSEID = request.getParameter("EXPENSEID");      	
        if (act.equals("ADD")) {  
          out.print("<center><table><tr><td><img border=0 src=\"icons/financials.png\"></td><td><strong><h1>Add actual</h1></strong></td></tr></table></center><hr>");
        } else {
          out.print("<center><table><tr><td><img border=0 src=\"icons/financials.png\"></td><td><strong><h1>Modify actual</h1></strong></td></tr></table></center><hr>");
        }
        out.print("<hr>");
        String DESCRIPTION = "";
        String TYPE = "";
        String AMOUNT = "";
        String INVOICE = "";
        String VENDORID = "";
        Calendar rn= Calendar.getInstance();
        String DATEEXP = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
        if (act.equals("ADD")) {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"productbudget.jsp?TODO=EXPADD&PRODUCTID="+PRODUCTID+"\" target=\"_top\">");
        } else {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"productbudget.jsp?TODO=EXPMOD&PRODUCTID="+PRODUCTID+"&EXPENSEID="+EXPENSEID+"\" target=\"_top\">");
        }
        if (act.equals("MOD")) {
          Statement STR01 = Conn.createStatement();
          String QR01 = "SELECT ID,DESCRIPTION,TYPE,AMOUNT,DATEEXP,INVOICE,VENDORID FROM PRODUCT_EXPENSE WHERE PRODUCTID='"+PRODUCTID+"' AND ID="+EXPENSEID;
          ResultSet R01 = STR01.executeQuery(QR01);
          if (R01.next()) {
            DESCRIPTION=R01.getString("DESCRIPTION");
            TYPE=R01.getString("TYPE");
            AMOUNT=R01.getString("AMOUNT");
            DATEEXP=R01.getString("DATEEXP");
            INVOICE=R01.getString("INVOICE");
            VENDORID=R01.getString("VENDORID");
          }
          STR01.close();
        }
        out.print("<table>");
        out.print("<tr><td>Description : </td><td><textarea name=\"DESCRIPTION\" cols=\"60\" rows=\"5\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");
        out.print("<tr><td>Type : </td><td><select name=\"TYPE\">");
        out.print("<option");
        if (TYPE.equals("C")) {
          out.print(" selected ");
        }
        out.print(">C - CAPITAL</option>");
        out.print("<option");
        if (TYPE.equals("E")) {
          out.print(" selected ");
        }
        out.print(">E - EXPENSE</option>");
        out.print("</select></td></tr>");
        out.print("<tr><td>Amount : </td><td><input name=\"AMOUNT\" type=\"text\" size=\"50\" value=\""+AMOUNT+"\"></td></tr>");
        out.print("<tr><td>Vendor : </td><td><select name=\"VENDORID\">");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT * FROM VENDOR";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<option");
          if (VENDORID.equals(R02.getString("ID"))) {
            out.print(" selected ");
          }
          out.print(">"+R02.getString("ID")+" - "+R02.getString("NAME")+"</option>");
        }
        STR02.close();
        out.print("</select></td></tr>");
        out.print("<tr><td>Invoice # : </td><td><input name=\"INVOICE\" type=\"text\" size=\"50\" value=\""+INVOICE+"\"></td></tr>");
        out.print("<tr><td>Date of actual : </td><td><input name=\"DATEEXP\" type=\"text\" size=\"50\" value=\""+DATEEXP+"\" readonly=\"readonly\">");  
        out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATEEXP'}); </script></td></tr>");
        if (act.equals("ADD")) {
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"productbudget.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        } else {  
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"productbudget.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        }
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }

    %>
  </body>
</html>
