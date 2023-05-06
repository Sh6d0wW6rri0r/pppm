
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
        PPPMTools pt = new PPPMTools();
      
        // JSP parameters
        String act = request.getParameter("TODO");
        String PROJECTID = request.getParameter("PROJECTID");
        String RO = request.getParameter("RO");

        if (RO==null) {
          RO="NO";
        }
      	Project p = new Project(Conn,PROJECTID);
        if (act.equals("BPOADD")) {
          String ID = request.getParameter("ID");
          p.addBPO(pt.checkStr(ID));
        }
        if (act.equals("BPODELETE")) {
          String EMPLOYEEID = request.getParameter("EMPLOYEEID");
          p.deleteBPO(pt.checkStr(EMPLOYEEID));
        }
        if (act.equals("DIVADD")) {
          String ID = request.getParameter("ID");
          p.addDivision(pt.checkStr(ID));
        }
        if (act.equals("DIVDELETE")) {
          String DIVISIONID = request.getParameter("DIVISIONID");
          p.deleteDivision(pt.checkStr(DIVISIONID));
        }
        if (act.equals("LOCADD")) {
          String ID = request.getParameter("ID");
          p.addLocation(pt.checkStr(ID));
        }
        if (act.equals("LOCDELETE")) {
          String LOCATIONID = request.getParameter("LOCATIONID");
          p.deleteLocation(pt.checkStr(LOCATIONID));
        }
        if (act.equals("SIADD")) {
          String ID = request.getParameter("ID");
          p.addStrategy(pt.checkStr(ID));
        }
        if (act.equals("SIDELETE")) {
          String SIID = request.getParameter("SIID");
          p.deleteStrategy(pt.checkStr(SIID));
        }
        if (act.equals("PRJMOD")) {
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
            p.setName(pt.checkStr(request.getParameter("NAME")));
            p.setDescription(pt.checkStr(request.getParameter("DESCRIPTION")));
            p.setFownerid(FOWNERID);
            p.setDatestart(request.getParameter("DATE_START"));
            p.setDateend(request.getParameter("DATE_END"));
          }
        }
        if (act.equals("CLOSED")) {
          String CL = request.getParameter("CLOSED");
          p.setClosed(CL);
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Request Details</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Request management \\ <A HREF=\"request.jsp?TODO=NONE\" target=\"appliFrame\"> Request(s)</A> \\ Request details<td><A HREF=\"requestdetails.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Request description</strong></h2></center></td><td><A HREF=\"addrequest.jsp?TODO=MOD&REQ=Y&PROJECTID="+PROJECTID+"&REQTYPE=PROJECT\"><img border=0 src=\"icons/modify.png\"></A></td></tr></table>");

        String NAME = p.getName();
        String FOWNERID = p.getFownerid();
        String DESCRIPTION = p.getDescription();
        String STATUS = p.getStatus();
        String DATE_START = p.getDatestart();
        String DATE_END = p.getDateend();
        out.print("<table>");
        out.print("<tr><td><h2><strong>Name : </strong></h2></td><td>"+NAME+"</td></tr>");
        out.print("<tr><td><h2><strong>Description : </strong></h2></td><td>"+DESCRIPTION+"</td></tr>");
        out.print("<tr><td><h2><strong>Status : </strong></h2></td><td>"+STATUS+"</td></tr>");
        out.print("<tr><td><h2><strong>Functional ownership : </strong></h2></td><td>");
        Statement st21 = Conn.createStatement();
        String q21 = "SELECT ID,NAME FROM FOWNER WHERE ID='"+FOWNERID+"'";
        ResultSet r21 = st21.executeQuery(q21);
        if (r21.next()) {
          out.print(" "+r21.getString("NAME")+" ");
        }
        st21.close();
        out.print("<tr><td><h2><strong>Date start : </strong></h2></td><td>"+DATE_START+"</td></tr>");
        out.print("<tr><td><h2><strong>Date end : </strong></h2></td><td>"+DATE_END+"</td></tr>");  
        out.print("</table><hr>");

        out.print("<table><tr><td><h2><strong>Strategic alignment</strong></h2></center></td>");
        out.print("<td><A HREF=\"pickstrategicinitiative.jsp?TODO=ADD&REQ=Y&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"90%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT ID,NAME FROM STRATEGICINITIATIVE WHERE ID IN (SELECT SIID FROM PRJSI WHERE PROJECTID='"+PROJECTID+"')";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deletestrategicinitiative.jsp?TODO=DELETE&REQ=Y&SIID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Business Process Owner(s)</strong></h2></center></td>");
        out.print("<td><A HREF=\"pickbpo.jsp?TODO=ADD&REQ=Y&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"45%\"  background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"45%\"  background=\"images/fond_titre.jpg\"><center>Forname</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (SELECT EMPLOYEEID FROM PRJBPO WHERE PROJECTID='"+PROJECTID+"')";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("FORNAME")+"</center></td>");
          out.print("<td><center><A HREF=\"deletebpo.jsp?TODO=DELETE&REQ=Y&EMPLOYEEID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");

        out.print("<hr><table><tr><td><h2><strong>Division(s) impacted</strong></h2></center></td>");
        out.print("<td><A HREF=\"pickdivision.jsp?TODO=ADD&REQ=Y&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"90%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,NAME FROM DIVISION WHERE ID IN (SELECT DIVISIONID FROM PRJDIV WHERE PROJECTID='"+PROJECTID+"')";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          out.print("<td><center><A HREF=\"deletedivision.jsp?TODO=DELETE&REQ=Y&DIVISIONID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Location(s) impacted</strong></h2></center></td>");
        out.print("<td><A HREF=\"picklocation.jsp?TODO=ADD&REQ=Y&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"90%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,NAME FROM LOCATION WHERE ID IN (SELECT LOCATIONID FROM PRJLOC WHERE PROJECTID='"+PROJECTID+"')";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          out.print("<td><center><A HREF=\"deletelocation.jsp?TODO=DELETE&REQ=Y&LOCATIONID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
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
