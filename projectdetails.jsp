
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
        if (act.equals("APPADD")) {
          String ID = request.getParameter("ID");
          p.addApplication(pt.checkStr(ID));
        }
        if (act.equals("APPDELETE")) {
          String ATID = request.getParameter("ATID");
          p.deleteApplication(pt.checkStr(ATID));
        }
        if (act.equals("INFADD")) {
          String ID = request.getParameter("ID");
          p.addInfrastructure(pt.checkStr(ID));
        }
        if (act.equals("INFDELETE")) {
          String ITID = request.getParameter("ITID");
          p.deleteInfrastructure(pt.checkStr(ITID));
        }
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
        if (act.equals("PMADD")) {
          String ID = request.getParameter("ID");
          p.addProjectManager(pt.checkStr(ID));
        }
        if (act.equals("PMDELETE")) {
          String EMPLOYEEID = request.getParameter("EMPLOYEEID");
          p.deleteProjectManager(pt.checkStr(EMPLOYEEID));
        }
        if (act.equals("SIADD")) {
          String ID = request.getParameter("ID");
          p.addStrategy(pt.checkStr(ID));
        }
        if (act.equals("SIDELETE")) {
          String SIID = request.getParameter("SIID");
          p.deleteStrategy(pt.checkStr(SIID));
        }
        if (act.equals("SCORE")) {
          Statement st11 = Conn.createStatement();
          String q11 = "SELECT ID,NAME,WEIGHT,GROUPID FROM SCORING_QUESTION";
          ResultSet r11 = st11.executeQuery(q11);
          int totalscore=0;
          while (r11.next()) {
            String QUESTION = request.getParameter(r11.getString("ID")); 
            totalscore=totalscore+p.setAnswer(QUESTION,r11.getString("ID"),r11.getInt("WEIGHT")); 
          }
          st11.close(); 
          p.setScore(totalscore);
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
        if (act.equals("CTMOD")) {
          String CT = request.getParameter("CAPACITYTRIANGLE");
          String CAPACITYTRIANGLE = CT.substring(0,1);
          p.setCapacitytriangle(CAPACITYTRIANGLE);
        }
        if (act.equals("ONHOLD")) {
          String OH = request.getParameter("ONHOLD");
         p.setOnhold(OH.substring(0,1));
        }
        if (act.equals("CLOSED")) {
          String CL = request.getParameter("CLOSED");
          p.setClosed(CL.substring(0,1));
        }
        if (act.equals("SELECTSCORE")) {
          String GROUPID = request.getParameter("GROUPID");
          p.setScoringgroupid(GROUPID);
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Project Details</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td><h2><strong>Project description</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"addrequest.jsp?TODO=MOD&REQ=N&PROJECTID="+PROJECTID+"&REQTYPE=PROJECT\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
        }
        out.print("</tr></table>");
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
        out.print("<table><tr><td><h2><strong>On-hold status</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"modifyonhold.jsp?TODO=MOD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
        }
        out.print("</tr></table>");
        String ONHOLD = p.getOnhold();
        out.print("<table>");
        if (ONHOLD.equals("Y")) {
          out.print("<tr><td><h2><strong>Project On-Hold : </strong></h2></td><td>Yes</td></tr>");
        } else {
          out.print("<tr><td><h2><strong>Project On-Hold : </strong></h2></td><td>No</td></tr>");
        }
        out.print("</table><hr>");

        out.print("<table><tr><td><h2><strong>Closed status</strong></h2></center></td>");
        Statement st1000 = Conn.createStatement();
        String q1000 = "SELECT * FROM USER_RIGHT WHERE LOGIN='"+Userlogin+"' AND USERRIGHT='ADMIN'";
        ResultSet r1000 = st1000.executeQuery(q1000);
        if (RO.equals("NO") || r1000.next()) {
          out.print("<td><A HREF=\"modifyclosed.jsp?TODO=MOD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
        }
        st1000.close();
        out.print("</tr></table>");
        String CLOSED = p.getClosed();
        out.print("<table>");
        if (CLOSED.equals("Y")) {
          out.print("<tr><td><h2><strong>Project Closed : </strong></h2></td><td>Yes</td></tr>");
        } else {
          out.print("<tr><td><h2><strong>Project Closed : </strong></h2></td><td>No</td></tr>");
        }
        out.print("</table><hr>");

        out.print("<table><tr><td><h2><strong>Strategic alignment</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickstrategicinitiative.jsp?TODO=ADD&REQ=N&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
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
            out.print("<td><center><A HREF=\"deletestrategicinitiative.jsp?TODO=DELETE&REQ=N&SIID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Scoring</strong></h2></center></td></tr>");

        if (RO.equals("NO")) {
          String scoring = p.getScoringgroupid();
          int score= p.getScore(); 
          if (scoring.equals("")) {
            out.print("<tr><td> Select the scoring model :<A HREF=\"selectscore.jsp?TODO=NONE&REQ=N&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
          } else {
            out.print("<tr><td> Change the scoring model :<A HREF=\"selectscore.jsp?TODO=NONE&REQ=N&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
            out.print("<tr><td> Score the project :<A HREF=\"score.jsp?TODO=NONE&REQ=N&PROJECTID="+PROJECTID+"&GROUPID="+scoring+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
          }
          out.print("<tr><td>Current score : "+score+"</td>");          
        }
        out.print("</tr></table>");
        out.print("<hr><table><tr><td><h2><strong>Application type(s)</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickapplicationtype.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"90%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,NAME FROM APPLICATIONTYPE WHERE ID IN (SELECT ATID FROM PRJAT WHERE PROJECTID='"+PROJECTID+"')";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deleteapplicationtype.jsp?TODO=DELETE&ATID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Infrastructure type(s)</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickinfrastructuretype.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"90%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,NAME FROM INFRASTRUCTURETYPE WHERE ID IN (SELECT ITID FROM PRJIT WHERE PROJECTID='"+PROJECTID+"')";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deleteinfrastructuretype.jsp?TODO=DELETE&ITID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Business Process Owner(s)</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickbpo.jsp?TODO=ADD&REQ=N&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
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
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deletebpo.jsp?TODO=DELETE&REQ=N&EMPLOYEEID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Project Manager(s)</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickpm.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"45%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"45%\" background=\"images/fond_titre.jpg\"><center>Forname</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (SELECT EMPLOYEEID FROM PRJPM WHERE PROJECTID='"+PROJECTID+"')";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NAME")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("FORNAME")+"</center></td>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deletepm.jsp?TODO=DELETE&EMPLOYEEID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Division(s) impacted</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"pickdivision.jsp?TODO=ADD&REQ=N&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
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
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deletedivision.jsp?TODO=DELETE&REQ=N&DIVISIONID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Location(s) impacted</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"picklocation.jsp?TODO=ADD&REQ=N&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
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
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deletelocation.jsp?TODO=DELETE&REQ=N&LOCATIONID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
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
