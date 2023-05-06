
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

        // JSP parameters
        String act = request.getParameter("TODO");
        String PROGRAMID = request.getParameter("PROGRAMID");
        String RO = request.getParameter("RO");

        if (RO==null) {
          RO="NO";
        }
      	PPPMTools pt = new PPPMTools();
        Program prg = new Program(Conn,PROGRAMID);
        if (act.equals("PRJADD")) {
          String ID = request.getParameter("ID");
          prg.addProject(pt.checkStr(ID));
        }
        if (act.equals("PRJDELETE")) {
          String PROJECTID = request.getParameter("PROJECTID");
          prg.deleteProject(pt.checkStr(PROJECTID)); 
        }
        if (act.equals("BPOADD")) {
          String ID = request.getParameter("ID");
          prg.addBPO(pt.checkStr(ID));
        }
        if (act.equals("BPODELETE")) {
          String EMPLOYEEID = request.getParameter("EMPLOYEEID");
          prg.deleteBPO(pt.checkStr(EMPLOYEEID));
        }
        if (act.equals("PMADD")) {
          String ID = request.getParameter("ID");
          prg.addPM(pt.checkStr(ID));
        }
        if (act.equals("PMDELETE")) {
          String EMPLOYEEID = request.getParameter("EMPLOYEEID");
          prg.deletePM(pt.checkStr(EMPLOYEEID));
        }
 
        if (act.equals("CLOSED")) {
          String CL = request.getParameter("CLOSED");
          prg.closeProgram(CL);
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Program Details</h1></strong></td></tr></table></center><hr>");
          out.print("<table><tr><td><h2><strong>Program description</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"addrequest.jsp?TODO=MOD&REQ=N&PROGRAMID="+PROGRAMID+"&REQTYPE=PROGRAM\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
        }
        out.print("</tr></table>");
        String NAME = "";
        String FOWNERID = "";
        String DESCRIPTION = "";
        String DATE_START = "";
        String DATE_END = "";
        Statement st10 = Conn.createStatement();
        String q10 = "SELECT ID,NAME,FOWNERID,DESCRIPTION,DATE_START,DATE_END FROM PROGRAM WHERE ID='"+PROGRAMID+"'";
        ResultSet r10 = st10.executeQuery(q10);
        if (r10.next()) {
          NAME=r10.getString("NAME");
          FOWNERID=r10.getString("FOWNERID");
          DESCRIPTION=r10.getString("DESCRIPTION");
          DATE_START=r10.getString("DATE_START");
          DATE_END=r10.getString("DATE_END");
        }
        st10.close();
        out.print("<table>");
        out.print("<tr><td><h2><strong>Name : </strong></h2></td><td>"+NAME+"</td></tr>");
        out.print("<tr><td><h2><strong>Description : </strong></h2></td><td>"+DESCRIPTION+"</td></tr>");
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

        out.print("<table><tr><td><h2><strong>Closed status</strong></h2></center></td>");
        Statement st1000 = Conn.createStatement();
        String q1000 = "SELECT * FROM USER_RIGHT WHERE LOGIN='"+Userlogin+"' AND USERRIGHT='ADMIN'";
        ResultSet r1000 = st1000.executeQuery(q1000);
        if (RO.equals("NO") || r1000.next()) {
          out.print("<td><A HREF=\"modifyprogramclosed.jsp?TODO=MOD&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
        }
        st1000.close();
        out.print("</tr></table>");
        String CLOSED = "";
        st10 = Conn.createStatement();
        q10 = "SELECT CLOSED FROM PROGRAM WHERE ID='"+PROGRAMID+"'";
        r10 = st10.executeQuery(q10);
        if (r10.next()) {
          CLOSED=r10.getString("CLOSED");
        }
        st10.close();
        out.print("<table>");
        if (CLOSED.equals("Y")) {
          out.print("<tr><td><h2><strong>Program Closed : </strong></h2></td><td>Yes</td></tr>");
        } else {
          out.print("<tr><td><h2><strong>Program Closed : </strong></h2></td><td>No</td></tr>");
        }
        out.print("</table><hr>");

        out.print("<table><tr><td><h2><strong>Project(s)</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickproject.jsp?TODO=ADD&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        } 
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"45%\"  background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"45%\"  background=\"images/fond_titre.jpg\"><center>Description</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT ID,NAME,DESCRIPTION FROM PROJECT WHERE ID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"')";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DESCRIPTION")+"</center></td>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deletepgmproject.jsp?TODO=DELETE&PROJECTID="+r30.getString("ID")+"&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Business Process Owner(s)</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickprogrambpo.jsp?TODO=ADD&REQ=N&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"45%\"  background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"45%\"  background=\"images/fond_titre.jpg\"><center>Forname</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (SELECT EMPLOYEEID FROM PGMBPO WHERE PROGRAMID='"+PROGRAMID+"')";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("FORNAME")+"</center></td>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deleteprogrambpo.jsp?TODO=DELETE&REQ=N&EMPLOYEEID="+r30.getString("ID")+"&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Program Manager(s)</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickpgmpm.jsp?TODO=ADD&REQ=P&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"45%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"45%\" background=\"images/fond_titre.jpg\"><center>Forname</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (SELECT EMPLOYEEID FROM PGMPM WHERE PROGRAMID='"+PROGRAMID+"')";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("FORNAME")+"</center></td>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deletepgmpm.jsp?TODO=DELETE&EMPLOYEEID="+r30.getString("ID")+"&PROGRAMID="+PROGRAMID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
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
