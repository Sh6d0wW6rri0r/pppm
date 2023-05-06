
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
        String PRODUCTID = request.getParameter("PRODUCTID");
        String BASELINEID = request.getParameter("BASELINEID");
        String RO = request.getParameter("RO");

        if (RO==null) {
          RO="NO";
        }      	
        out.print("<center><table><tr><td><img border=0 src=\"icons/compare.png\"></td><td><strong><h1>Product roadmap baseline comparison</h1></strong></td></tr></table></center><hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"30\">");
        out.print("<td width=\"5%\" background=\"images/fond_titre.jpg\"><center>#</center></td>");
        out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>Activity <br>(Current / Baseline)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Duration (days) <br>(Current / Baseline)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Workload (hours) <br>(Current / Baseline)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Start <br>(Current / Baseline)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>End <br>(Current / Baseline)</center></td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT PRODUCTID,ACTIVITYID,DATE_START,DATE_END,WORKLOAD,DURATION,NAME FROM PRODUCT_BASELINE_ACTIVITY WHERE PRODUCTID='"+PRODUCTID+"' AND BASELINEID="+BASELINEID;
        ResultSet R01 = STR01.executeQuery(QR01);
        while(R01.next()) {
          Statement STR02 = Conn.createStatement();
          String QR02 = "SELECT NAME,DATE_START,DATE_END,ID,DURATION,WORKLOAD FROM PRODUCT_ACTIVITY WHERE PRODUCTID='"+R01.getString("PRODUCTID")+"' AND ID="+R01.getInt("ACTIVITYID");
          ResultSet R02 = STR02.executeQuery(QR02);
          String ACTIVITY_NAME="No more part of planning";
          String ACTIVITY_DATE_START="No more part of planning";
          String ACTIVITY_DATE_END="No more part of planning";
          String ACTIVITY_WORKLOAD="No more part of planning";
          String ACTIVITY_DURATION="No more part of planning";
          if (R02.next()) {
            ACTIVITY_NAME=R02.getString("NAME");
            ACTIVITY_DATE_START=R02.getString("DATE_START");
            ACTIVITY_DATE_END=R02.getString("DATE_END");
            ACTIVITY_WORKLOAD=R02.getString("WORKLOAD");
            ACTIVITY_DURATION=R02.getString("DURATION");
          }
          STR02.close();
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+R01.getString("ACTIVITYID")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\">"+ACTIVITY_NAME+" / "+R01.getString("NAME")+"</td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>");
          if (!ACTIVITY_DURATION.equals(R01.getString("DURATION"))) {
            out.print("<span style=\"background-color:orange\">");
          }
          out.print(""+ACTIVITY_DURATION+"</span>");
          out.print(" / "+R01.getString("DURATION")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>");
          if (!ACTIVITY_WORKLOAD.equals(R01.getString("WORKLOAD"))) {
            out.print("<span style=\"background-color:orange\">");
          }
          out.print(""+ACTIVITY_WORKLOAD+"</span>");
          out.print(" / "+R01.getString("WORKLOAD")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>");
          if (!ACTIVITY_DATE_START.equals(R01.getString("DATE_START"))) {
            out.print("<span style=\"background-color:orange\">");
          }
          out.print(""+ACTIVITY_DATE_START+"</span>");
          out.print(" / "+R01.getString("DATE_START")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>");
          if (!ACTIVITY_DATE_END.equals(R01.getString("DATE_END"))) {
             out.print("<span style=\"background-color:orange\">");
          }
          out.print(""+ACTIVITY_DATE_END+"</span>");
          out.print(" / "+R01.getString("DATE_END")+"</center></td>");
          out.print("</tr>");
        }
        STR01.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"productbaseline.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"\">Return</A></center>");
        Conn.close();
      }

    %>   
  </body>
</html>
