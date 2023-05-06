
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: 11px}
      h1 { color: black; font-family: arial; font-size: 16px}
      h2 { color: black; font-family: arial; font-size: 13px}
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
        String RO = request.getParameter("RO");

        if (RO==null) {
          RO="NO";
        }
      	PPPMTools pt = new PPPMTools();
        Project prj = new Project(Conn,PROJECTID);
        if (act.equals("BUDADD")) {
          if (pt.checknum(request.getParameter("AMOUNT"))) {
            String AMOUNT = request.getParameter("AMOUNT");
            if (AMOUNT.equals("")) {
              AMOUNT="0";
            }
            String TYPETMP = request.getParameter("TYPE");
            String TYPE = TYPETMP.substring(0,TYPETMP.indexOf("-")-1);
            String DESCRIPTION=pt.checkStr(request.getParameter("DESCRIPTION"));
            String CER=pt.checkStr(request.getParameter("CER"));
            String DATEBUD=request.getParameter("DATEBUD");
            prj.addBudget(DESCRIPTION,TYPE,AMOUNT,CER,DATEBUD);
          } else {
            out.print("<HR>ERROR IN THE FORMAT OF THE NUMBER</HR>");
          }
        }
        if (act.equals("BUDMOD")) {
          if (pt.checknum(request.getParameter("AMOUNT"))) {
            String AMOUNT = request.getParameter("AMOUNT");
            if (AMOUNT.equals("")) {
              AMOUNT="0";
            }
            String BUDGETID=request.getParameter("BUDGETID");
            String TYPETMP = request.getParameter("TYPE");
            String TYPE = TYPETMP.substring(0,TYPETMP.indexOf("-")-1);
            String DESCRIPTION = pt.checkStr(request.getParameter("DESCRIPTION"));
            String CER = pt.checkStr(request.getParameter("CER"));
            String DATEBUD = request.getParameter("DATEBUD");
            prj.modifyBudget(BUDGETID,DESCRIPTION,TYPE,AMOUNT,CER,DATEBUD);
          } else {
            out.print("<HR>ERROR IN THE FORMAT OF THE NUMBER</HR>");
          }
        }
        if (act.equals("EXPADD")) {
          if (pt.checknum(request.getParameter("AMOUNT"))) {
            String AMOUNT = request.getParameter("AMOUNT");
            if (AMOUNT.equals("")) {
              AMOUNT="0";
            }
            String TYPETMP = request.getParameter("TYPE");
            String TYPE = TYPETMP.substring(0,TYPETMP.indexOf("-")-1);
            String VENDORTMP = request.getParameter("VENDORID");
            String VENDORID="NONE";
            if (VENDORTMP!=null) {
              VENDORID = VENDORTMP.substring(0,VENDORTMP.indexOf("-")-1);
            }
            String DESCRIPTION= pt.checkStr(request.getParameter("DESCRIPTION"));
            String DATEEXP = request.getParameter("DATEEXP");
            String INVOICE = pt.checkStr(request.getParameter("INVOICE"));
            prj.addExpense(DESCRIPTION,TYPE,AMOUNT,DATEEXP,VENDORID,INVOICE);
          } else {
            out.print("<HR>ERROR IN THE FORMAT OF THE NUMBER</HR>");
          }
        }
        if (act.equals("EXPMOD")) {
          if (pt.checknum(request.getParameter("AMOUNT"))) {
            String AMOUNT = request.getParameter("AMOUNT");
            if (AMOUNT.equals("")) {
              AMOUNT="0";
            }
            String EXPENSEID=request.getParameter("EXPENSEID");
            String TYPETMP = request.getParameter("TYPE");
            String TYPE = TYPETMP.substring(0,TYPETMP.indexOf("-")-1);
            String VENDORTMP = request.getParameter("VENDORID");
            String VENDORID="NONE";
            if (VENDORTMP!=null) {
              VENDORID = VENDORTMP.substring(0,VENDORTMP.indexOf("-")-1);
            }
            String DESCRIPTION = pt.checkStr(request.getParameter("DESCRIPTION"));
            String DATEEXP = request.getParameter("DATEEXP");
            String INVOICE = pt.checkStr(request.getParameter("INVOICE"));
            prj.modifyExpense(EXPENSEID,DESCRIPTION,TYPE,AMOUNT,DATEEXP,VENDORID,INVOICE);
          } else {
            out.print("<HR>ERROR IN THE FORMAT OF THE NUMBER</HR>");
          }
        }
        if (act.equals("BUDDELETE")) {
          String BUDGETID = request.getParameter("BUDGETID");
          prj.deleteBudget(BUDGETID);
        }
        if (act.equals("EXPDELETE")) {
          String EXPENSEID = request.getParameter("EXPENSEID");
          prj.deleteExpense(EXPENSEID);
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/financials.png\"></td><td><strong><h1>Project financials</h1></strong></td></tr></table></center><hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\" >");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"60%\" COLSPAN=2  background=\"images/fond_titre.jpg\"><center>Description</center></td>");
        out.print("<td width=\"10%\"  background=\"images/fond_titre.jpg\"><center>Date</center></td>");
        out.print("<td width=\"10%\"  background=\"images/fond_titre.jpg\"><center>Capital</center></td>");
        out.print("<td width=\"10%\"  background=\"images/fond_titre.jpg\"><center>Expense</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        long totalbudgetcapital=0;
        long totalbudgetexpense=0;
        long totalexpensecapital=0;
        long totalexpenseexpense=0;
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT SUM(AMOUNT) FROM PROJECT_BUDGET WHERE PROJECTID='"+PROJECTID+"' AND TYPE='C'";
        ResultSet r30 = st30.executeQuery(q30);
        if(r30.next()) {
          totalbudgetcapital=r30.getInt("SUM(AMOUNT)");
        }
        st30.close();
        st30 = Conn.createStatement();
        q30 = "SELECT SUM(AMOUNT) FROM PROJECT_BUDGET WHERE PROJECTID='"+PROJECTID+"' AND TYPE='E'";
        r30 = st30.executeQuery(q30);
        if(r30.next()) {
          totalbudgetexpense=r30.getInt("SUM(AMOUNT)");
        }
        st30.close();
        st30 = Conn.createStatement();
        q30 = "SELECT SUM(AMOUNT) FROM PROJECT_EXPENSE WHERE PROJECTID='"+PROJECTID+"' AND TYPE='C'";
        r30 = st30.executeQuery(q30);
        if(r30.next()) {
          totalexpensecapital=r30.getInt("SUM(AMOUNT)");
        }
        st30.close();
        st30 = Conn.createStatement();
        q30 = "SELECT SUM(AMOUNT) FROM PROJECT_EXPENSE WHERE PROJECTID='"+PROJECTID+"' AND TYPE='E'";
        r30 = st30.executeQuery(q30);
        if(r30.next()) {
          totalexpenseexpense=r30.getInt("SUM(AMOUNT)");
        }
        st30.close();
        out.print("<tr height=\"30\">");
        out.print("<td COLSPAN=3 bgcolor=\"#FFFFFF\">Remaining budget</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+(totalbudgetcapital-totalexpensecapital)+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+(totalbudgetexpense-totalexpenseexpense)+"</center></td>");
        out.print("<td><center>&nbsp;</center></td>");
        out.print("</tr>");
        out.print("<tr height=\"30\">");
        out.print("<td colspan=3 bgcolor=\"#FFFFFF\"><table><tr><td>Budget line(s)</td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"addbudget.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
        out.print("</tr></table></td>");         
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalbudgetcapital+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalbudgetexpense+"</center></td>");
        out.print("<td><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT * FROM PROJECT_BUDGET WHERE PROJECTID='"+PROJECTID+"'";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr height=\"30\">");
          out.print("<td><center>&nbsp;</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"30%\">"+r30.getString("DESCRIPTION")+"</td>");
          if (RO.equals("NO")) {
            out.print("<td width=\"10%\"><A HREF=\"addbudget.jsp?TODO=MOD&PROJECTID="+PROJECTID+"&BUDGETID="+r30.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
          }
          out.print("<td width=\"60%\">CER : "+r30.getString("CER")+"</td></tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DATEBUD")+"</center></td>");
          if (r30.getString("TYPE").equals("C")) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("AMOUNT")+"</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
          }
          if (r30.getString("TYPE").equals("E")) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("AMOUNT")+"</center></td>");
          }
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deletebudget.jsp?TODO=DELETE&PROJECTID="+PROJECTID+"&BUDGETID="+r30.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close(); 
        out.print("<tr height=\"30\">");
        out.print("<td colspan=3  bgcolor=\"#FFFFFF\"><table><tr><td>Actual(s)</td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"addexpense.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
        out.print("</tr></table></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalexpensecapital+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalexpenseexpense+"</center></td>");
        out.print("<td><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT * FROM PROJECT_EXPENSE WHERE PROJECTID='"+PROJECTID+"'";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr height=\"30\">");
          out.print("<td><center>&nbsp;</center></A></td>");
          String VENDORNAME=r30.getString("VENDORID");
          Statement st3 = Conn.createStatement();
          String q3 = "SELECT * FROM VENDOR WHERE ID='"+r30.getString("VENDORID")+"'";
          ResultSet r3 = st3.executeQuery(q3);
          if (r3.next()) {
            VENDORNAME=r3.getString("NAME");
          }
          st3.close();
          out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"30%\">"+r30.getString("DESCRIPTION")+"</td>");
          if (RO.equals("NO")) {
            out.print("<td width=\"10%\"><A HREF=\"addexpense.jsp?TODO=MOD&PROJECTID="+PROJECTID+"&EXPENSEID="+r30.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
          }
          out.print("<td width=\"30%\">INVOICE : "+r30.getString("INVOICE")+"</td><td width=\"30%\">VENDOR : "+VENDORNAME+"</td></tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DATEEXP")+"</center></td>");
          if (r30.getString("TYPE").equals("C")) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("AMOUNT")+"</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
          }
          if (r30.getString("TYPE").equals("E")) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("AMOUNT")+"</center></td>");
          }
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deleteexpense.jsp?TODO=DELETE&PROJECTID="+PROJECTID+"&EXPENSEID="+r30.getString("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      }

    %>
  </body>
</html>
