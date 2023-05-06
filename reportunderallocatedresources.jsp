
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


  <%@ page import = "java.io.*" %>
  <%@ page import = "java.util.*" %>
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
        Statement st0 = Conn.createStatement();
        String DATE_START="2011-01-01";
        String DATE_END="2012-12-31";
        String q0 = "SELECT COUNT(ID) FROM PROJECT";
        ResultSet r0 = st0.executeQuery(q0);
        if (r0.next()) {
          if(r0.getInt("COUNT(ID)")>0) {
            Statement st1 = Conn.createStatement();
            String q1 = "SELECT MIN(DATE_START),MAX(DATE_END) FROM PROJECT ";
            ResultSet r1 = st1.executeQuery(q1);
            if (r1.next()) {
              DATE_START=r1.getString("MIN(DATE_START)");
              DATE_END=r1.getString("MAX(DATE_END)");
            }
            st1.close();
          }
        }
        st0.close();
        SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
        Calendar start = Calendar.getInstance();
        start.setTime(d1.parse(DATE_START));
        Calendar end = Calendar.getInstance();
        end.setTime(d2.parse(DATE_END));
        int start_month = start.get(Calendar.MONTH);
        int start_year = start.get(Calendar.YEAR);
        int end_month = end.get(Calendar.MONTH);
        int end_year = end.get(Calendar.YEAR);   
        String MOIS[] = new String[12];
        MOIS[0]="January";
        MOIS[1]="February";
        MOIS[2]="March";
        MOIS[3]="April";
        MOIS[4]="May";
        MOIS[5]="June";
        MOIS[6]="July";
        MOIS[7]="August";
        MOIS[8]="September";
        MOIS[9]="October";
        MOIS[10]="November";
        MOIS[11]="December";
        int nbmonth=1;
        int tmpyear=start_year;
        int tmpmonth=start_month;
        while (tmpyear!=end_year || tmpmonth!=end_month) {
          nbmonth++;
          tmpmonth++;
          if (tmpmonth>11) {
            tmpyear++;
            tmpmonth=0;
          } 
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/report.png\"></td><td><strong><h1>Underallocated resources</h1></strong></td></tr></table></center>");
        out.print("<hr>");
        out.print("<Table><tr><td>You are here : Report \\ <A HREF=\"reportpmogroup.jsp?TODO=NONE\" target=\"appliFrame\">PMO</A> \\ Under-allocated resources</td><td><A HREF=\"reportunderallocatedresources.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<h2>Between "+DATE_START+" and "+DATE_END+"</h2>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>FORNAME</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>WORKLOAD</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>CAPACITY</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>MONTH</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>YEAR</center></td>");
        out.print("</tr>");
        tmpyear=start_year;
        tmpmonth=start_month;
        while (tmpyear!=end_year || tmpmonth!=end_month) {
          Statement st32 = Conn.createStatement();  
          String q32 = "SELECT ID,NAME,FORNAME,SITEID FROM EMPLOYEE";
          ResultSet r32 = st32.executeQuery(q32);
          while (r32.next()) {
            Statement st231 = Conn.createStatement();
            String q231 = "SELECT SUM(CAPACITY) FROM EMPPRF WHERE EMPLOYEEID='"+r32.getString("ID")+"'";
            ResultSet r231 = st231.executeQuery(q231);
            int capacity=0;
            if (r231.next()) {
              capacity=r231.getInt("SUM(CAPACITY)");
            }
            st231.close();
            Calendar mchk = Calendar.getInstance();
            mchk.setTime(d1.parse(tmpyear+"-"+(tmpmonth+1+"-01")));
            st231 = Conn.createStatement();
            q231 = "SELECT COUNT(DAYOFF) FROM OTHER_DAY_OFF WHERE SITEID='"+r32.getString("SITEID")+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
            r231 = st231.executeQuery(q231);
            int nbdayoff=0;
            if (r231.next()) {
              nbdayoff=r231.getInt("COUNT(DAYOFF)");
            }
            st231.close();
            st231 = Conn.createStatement();
            q231 = "SELECT COUNT(DAYOFF) FROM HOLLIDAY WHERE EMPLOYEEID='"+r32.getString("ID")+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
            r231 = st231.executeQuery(q231);
            int nbholliday=0;
            if (r231.next()) {
              nbholliday=r231.getInt("COUNT(DAYOFF)");
            }
            st231.close();
            capacity=(capacity*(mchk.getActualMaximum(Calendar.DAY_OF_MONTH)-nbdayoff-nbholliday))/mchk.getActualMaximum(Calendar.DAY_OF_MONTH);
            int workload_recurring=0;
            Statement st232 = Conn.createStatement();
            String q232 = "SELECT WORKLOAD FROM EMPLOYEE_RECURRING_WORKLOAD WHERE EMPLOYEEID='"+r32.getString("ID")+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
            ResultSet r232 = st232.executeQuery(q232);
            int mwrkl = 0;
            while (r232.next()) {
              mwrkl=r232.getInt("WORKLOAD");
              workload_recurring=workload_recurring+mwrkl;   
            }
            st232.close();
            int workload_project=0;
            st232 = Conn.createStatement();
            q232 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+r32.getString("ID")+"' AND PROJECTID IN (SELECT ID FROM PROJECT WHERE STATUS<>'REQUEST') ";
            r232 = st232.executeQuery(q232);
            while (r232.next()) {
              Statement st233 = Conn.createStatement();
              String q233 = "SELECT PROJECTID,ACTIVITYID,WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE PROJECTID='"+r232.getString("PROJECTID")+"' AND ACTIVITYID='"+r232.getString("ACTIVITYID")+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
              ResultSet r233 = st233.executeQuery(q233);
              mwrkl = 0;
              if (r233.next()) {
                mwrkl=r233.getInt("WORKLOAD");
              }
              st233.close();
              workload_project=workload_project+(mwrkl*r232.getInt("PERCENTAGE")/100);   
            }
            st232.close();  
            if (workload_project+workload_recurring<(50/100*capacity)) {
              out.print("<tr>");
              out.print("<td bgcolor=\"#EFEFEF\"><center>"+r32.getString("NAME")+"</center></A></td>"); 
              out.print("<td bgcolor=\"#EFEFEF\"><center>"+r32.getString("FORNAME")+"</center></A></td>"); 
              out.print("<td bgcolor=\"#EFEFEF\"><center>"+(workload_project+workload_recurring)+"</center></A></td>"); 
              out.print("<td bgcolor=\"#EFEFEF\"><center>"+capacity+"</center></A></td>"); 
              out.print("<td bgcolor=\"#EFEFEF\"><center>"+MOIS[tmpmonth]+"</center></A></td>"); 
              out.print("<td bgcolor=\"#EFEFEF\"><center>"+tmpyear+"</center></A></td>"); 
              out.print("</tr>");
            }
          }
          st32.close();
          tmpmonth++;
          if (tmpmonth>11) {
            tmpyear++;
            tmpmonth=0;
          }
        }
        out.print("</table>");
        Conn.close();
      }

    %>
  </body>
</html>
