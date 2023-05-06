
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

    <%-- PPPM.ORG , the OpenSource PPM (Portfolio, Project and Program management) system --%>
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


  <%!String checkstr(String str) {
  
      String insertok="";
  
      for (int it=0; it <str.length();it++) {
        if ((str.charAt(it)>='a') && (str.charAt(it)<='z')) {
          insertok=insertok+str.charAt(it);
        }
        if ((str.charAt(it)>='A') && (str.charAt(it)<='Z')) {
          insertok=insertok+str.charAt(it);
        }
        if ((str.charAt(it)>='0') && (str.charAt(it)<='9')) {
          insertok=insertok+str.charAt(it);
        }
        if ((str.charAt(it)==' ')) {
          insertok=insertok+" ";
        } 
        if ((str.charAt(it)=='\n')) {
          insertok=insertok+"\\\n";
        } 
        if ((str.charAt(it)=='\'')) {
          insertok=insertok+"''";
        }
        if ((str.charAt(it)=='à')) {
          insertok=insertok+"&agrave;";
        }
        if ((str.charAt(it)=='é')) {
          insertok=insertok+"&eacute;";
        }
        if ((str.charAt(it)=='è')) {
          insertok=insertok+"&egrave;";
        }
        if ((str.charAt(it)=='ù')) {
          insertok=insertok+"&ugrave;";
        }
        if ((str.charAt(it)=='ô')) {
          insertok=insertok+"&ocirc;";
        }
        if ((str.charAt(it)=='ê')) {
          insertok=insertok+"&ecirc;";
        }
        if ((str.charAt(it)=='€')) {
          insertok=insertok+"&euro;";
        }
        if ((str.charAt(it)=='ç')) {
          insertok=insertok+"&ccedil;";
        }
        if ((str.charAt(it)=='&')) {
          insertok=insertok+"&amp;";
        }
        if ((str.charAt(it)=='\"')) {
          insertok=insertok+"&quot;";
        }
        if ((str.charAt(it)=='\\')) {
          insertok=insertok+"\\\\";
        }
        if ((str.charAt(it)=='$')) {
          insertok=insertok+"$";
        }
        if ((str.charAt(it)=='*')) {
         insertok=insertok+"*";
        }
        if ((str.charAt(it)=='%')) {
          insertok=insertok+"%";
        }
        if ((str.charAt(it)=='/')) {
          insertok=insertok+"/";
        }
        if ((str.charAt(it)=='.')) {
          insertok=insertok+".";
        }
        if ((str.charAt(it)=='?')) {
          insertok=insertok+"?";
        }
        if ((str.charAt(it)==',')) {
          insertok=insertok+",";
        }
        if ((str.charAt(it)==';')) {
          insertok=insertok+";";
        }
        if ((str.charAt(it)==':')) {
          insertok=insertok+":";
        }
        if ((str.charAt(it)=='!')) {
          insertok=insertok+"!";
        }
        if ((str.charAt(it)=='|')) {
          insertok=insertok+"|";
        }
        if ((str.charAt(it)=='{')) {
          insertok=insertok+"{";
        }
        if ((str.charAt(it)=='}')) {
          insertok=insertok+"}";
        }
        if ((str.charAt(it)=='(')) {
          insertok=insertok+"(";
        }
        if ((str.charAt(it)==')')) {
          insertok=insertok+")";
        }
        if ((str.charAt(it)=='[')) {
          insertok=insertok+"{";
        }
        if ((str.charAt(it)==']')) {
          insertok=insertok+"}";
        }
        if ((str.charAt(it)=='~')) {
          insertok=insertok+"~";
        }
        if ((str.charAt(it)=='#')) {
          insertok=insertok+"#";
        }
        if ((str.charAt(it)=='=')) {
          insertok=insertok+"=";
        }
        if ((str.charAt(it)=='@')) {
          insertok=insertok+"@";
        }
        if ((str.charAt(it)=='-')) {
          insertok=insertok+"-";
        }
        if ((str.charAt(it)=='_')) {
          insertok=insertok+"_";
        }
        if ((str.charAt(it)=='<')) {
          insertok=insertok+"&lt;";
        }
        if ((str.charAt(it)=='>')) {
          insertok=insertok+"&gt;";
        }
      }
  
      return insertok;

    }
  
%>

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
        String EMPLOYEEID = request.getParameter("EMPLOYEEID");
      	if (act.equals("APPROVE")) {
          String PROJECTID = request.getParameter("PROJECTID");
          String ACTIVITYID = request.getParameter("ACTIVITYID");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE RESOURCE_USER_ACTIVITY SET APPROVED='YES' WHERE PROJECTID='"+PROJECTID+"' AND EMPLOYEEID='"+EMPLOYEEID+"' AND ACTIVITYID='"+ACTIVITYID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("REFUSE")) {
          String PROJECTID = request.getParameter("PROJECTID");
          String ACTIVITYID = request.getParameter("ACTIVITYID");
          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE RESOURCE_USER_ACTIVITY SET APPROVED='REJECTED' WHERE PROJECTID='"+PROJECTID+"' AND EMPLOYEEID='"+EMPLOYEEID+"' AND ACTIVITYID='"+ACTIVITYID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/resources.png\"></td><td><strong><h1>Resource request(s)</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td><h2><strong>Resource request(s) for project(s)</strong></h2></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>Project</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>Date start</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>Date end</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Workload (hours)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Resource workload</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Approve</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Refuse</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT * FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND APPROVED='NO'";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          Statement st31 = Conn.createStatement();
          String q31 = "SELECT NAME FROM PROJECT WHERE ID='"+r30.getString("PROJECTID")+"'";
          ResultSet r31 = st31.executeQuery(q31);
          if (r31.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("NAME")+"</center></A></td>");
          }
          st31.close();
          Statement st32 = Conn.createStatement();
          String q32= "SELECT DATE_START,DATE_END,WORKLOAD FROM PROJECT_ACTIVITY WHERE ID='"+r30.getString("ACTIVITYID")+"' AND PROJECTID='"+r30.getString("PROJECTID")+"'";
          ResultSet r32 = st32.executeQuery(q32);
          if (r32.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r32.getString("DATE_START")+"</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r32.getString("DATE_END")+"</center></A></td>");
            int wrk = Integer.parseInt(r32.getString("WORKLOAD"));
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("PERCENTAGE")*wrk/100+"</center></A></td>");
   
          }
          st32.close();
          out.print("<td bgcolor=#FFFFFF><center><A HREF=\"#\" onclick=\"window.showModalDialog('listemployeeworkload.jsp?TODO=NONE&EMPLOYEEID="+EMPLOYEEID+"','','dialogHeight:400px;dialogWidth:800px;');\"><img border=0 src=\"icons/capacity.png\"></A></span></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"resourcerequest.jsp?TODO=APPROVE&EMPLOYEEID="+EMPLOYEEID+"&ACTIVITYID="+r30.getString("ACTIVITYID")+"&PROJECTID="+r30.getString("PROJECTID")+"\"><img border=0 src=\"icons/yes.png\"></center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"resourcerequest.jsp?TODO=REFUSE&EMPLOYEEID="+EMPLOYEEID+"&ACTIVITYID="+r30.getString("ACTIVITYID")+"&PROJECTID="+r30.getString("PROJECTID")+"\"><img border=0 src=\"icons/cancel.png\"></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<table><tr><td><h2><strong>Resource request(s) approved for project(s)</strong></h2></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"25%\" background=\"images/fond_titre.jpg\"><center>Project</center></td>");
        out.print("<td width=\"25%\" background=\"images/fond_titre.jpg\"><center>Date start</center></td>");
        out.print("<td width=\"25%\" background=\"images/fond_titre.jpg\"><center>Date end</center></td>");
        out.print("<td width=\"25%\" background=\"images/fond_titre.jpg\"><center>Workload (hours)</center></td>");
        out.print("</tr>");
        Statement st30b = Conn.createStatement();
        String q30b = "SELECT * FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND APPROVED='YES'";
        ResultSet r30b = st30b.executeQuery(q30b);
        while(r30b.next()) {
          out.print("<tr>");
          Statement st31b = Conn.createStatement();
          String q31b = "SELECT NAME FROM PROJECT WHERE ID='"+r30b.getString("PROJECTID")+"'";
          ResultSet r31b = st31b.executeQuery(q31b);
          if (r31b.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31b.getString("NAME")+"</center></A></td>");
          }
          st31b.close();
          Statement st32b = Conn.createStatement();
          String q32b= "SELECT DATE_START,DATE_END,WORKLOAD FROM PROJECT_ACTIVITY WHERE ID='"+r30b.getString("ACTIVITYID")+"' AND PROJECTID='"+r30b.getString("PROJECTID")+"'";
          ResultSet r32b = st32b.executeQuery(q32b);
          if (r32b.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r32b.getString("DATE_START")+"</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r32b.getString("DATE_END")+"</center></A></td>");
            int wrk = Integer.parseInt(r32b.getString("WORKLOAD"));
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30b.getInt("PERCENTAGE")*wrk/100+"</center></A></td>");
   
          }
          st32b.close();
          out.print("</tr>");
        }
        st30b.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      }

    %>
  </body>
</html>
