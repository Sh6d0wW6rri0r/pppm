
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
        Statement STR01 = Conn.createStatement();
        String DATE_START="2011-01-01";
        String DATE_END="2012-12-31";
        String QR01 = "SELECT COUNT(ID) FROM PROJECT";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          if(R01.getInt("COUNT(ID)")>0) {
            Statement STR02 = Conn.createStatement();
            String QR02 = "SELECT MIN(DATE_START),MAX(DATE_END) FROM PROJECT";
            ResultSet R02 = STR02.executeQuery(QR02);
            if (R02.next()) {
              DATE_START=R02.getString("MIN(DATE_START)");
              DATE_END=R02.getString("MAX(DATE_END)");
            }
            STR02.close();
          }
        }
        STR01.close();
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
        out.print("<center><strong><h1>Workload/capacity for ");
        Statement STR03 = Conn.createStatement();
        String SITEID="";
        int CAPA=0;
        String QR03 = "SELECT NAME,FORNAME,SITEID,CAPACITY FROM EMPLOYEE WHERE ID='"+EMPLOYEEID+"'";
        ResultSet R03 = STR03.executeQuery(QR03);
        if (R03.next()) {
          out.print(""+R03.getString("NAME")+" "+R03.getString("FORNAME"));
          SITEID=R03.getString("SITEID");
          CAPA=R03.getInt("CAPACITY");
        }
        STR03.close();
        out.print("</h1></strong></center>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\"  width=\"100%\">");
        out.print("<t>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><center>MONTH</center></td>");
        out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>WORKLOAD</center></td>");
        out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>CAPACITY</center></td>");
        out.print("</tr>");
        out.print("<tr>");
        tmpyear=start_year;
        tmpmonth=start_month;
        int capacity=CAPA;
        Calendar mchk = Calendar.getInstance();
        mchk.setTime(d1.parse(tmpyear+"-"+(tmpmonth+1+"-01")));
        Statement STR05 = Conn.createStatement();
        String QR05 = "SELECT COUNT(DAYOFF) FROM OTHER_DAY_OFF WHERE SITEID='"+SITEID+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
        ResultSet R05 = STR05.executeQuery(QR05);
        int nbdayoff=0;
        if (R05.next()) {
          nbdayoff=R05.getInt("COUNT(DAYOFF)");
        }
        STR05.close();
        Statement STR06 = Conn.createStatement();
        String QR06 = "SELECT COUNT(DAYOFF) FROM HOLLIDAY WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
        ResultSet R06 = STR06.executeQuery(QR06);
        int nbholliday=0;
        if (R06.next()) {
          nbholliday=R06.getInt("COUNT(DAYOFF)");
        }
        STR06.close();
        capacity=(capacity*(mchk.getActualMaximum(Calendar.DAY_OF_MONTH)-nbdayoff-nbholliday))/mchk.getActualMaximum(Calendar.DAY_OF_MONTH);
        int workload=0;
        Statement STR07 = Conn.createStatement();
        String QR07 = "SELECT WORKLOAD FROM EMPLOYEE_RECURRING_WORKLOAD WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
        ResultSet R07 = STR07.executeQuery(QR07);
        int mwrkl = 0;
        while (R07.next()) {
          mwrkl=R07.getInt("WORKLOAD");
          workload=workload+mwrkl;   
        }
        STR07.close();
        Statement STR08 = Conn.createStatement();
        String QR08 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND PROJECTID IN (SELECT ID FROM PROJECT WHERE STATUS<>'REQUEST') ";
        ResultSet R08 = STR08.executeQuery(QR08);
        while (R08.next()) {
          Statement STR09 = Conn.createStatement();
          String QR09 = "SELECT PROJECTID,ACTIVITYID,WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE PROJECTID='"+R08.getString("PROJECTID")+"' AND ACTIVITYID='"+R08.getString("ACTIVITYID")+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
          ResultSet R09 = STR09.executeQuery(QR09);
          mwrkl = 0;
          while (R09.next()) {
            mwrkl=mwrkl+R09.getInt("WORKLOAD");
          }
          STR09.close();
          workload=workload+(mwrkl*R08.getInt("PERCENTAGE")/100);   
        }
        STR08.close();
        out.print("<tr>");
        out.print("<td bgcolor=#FFFFFF>"+MOIS[tmpmonth]+" "+tmpyear+"</td>");
        if (workload>capacity) {
          out.print("<td bgcolor=#FFFFFF><center><span style=\"background-color:orange\"><A HREF=\"#\" onclick=\"window.showModalDialog('listteamworkload.jsp?TODO=NONE&EMPLOYEEID="+EMPLOYEEID+"&YEAR="+tmpyear+"&MONTH="+(tmpmonth+1)+"','','dialogHeight:400px;dialogWidth:800px;');\">"+workload+"</A></span></td>");
        } else {
          out.print("<td bgcolor=#FFFFFF><center><span style=\"\"><A HREF=\"#\" onclick=\"window.showModalDialog('listteamworkload.jsp?TODO=NONE&EMPLOYEEID="+EMPLOYEEID+"&YEAR="+tmpyear+"&MONTH="+(tmpmonth+1)+"','','dialogHeight:400px;dialogWidth:800px;');\">"+workload+"</A></span></td>");
        }
        out.print("<td bgcolor=#FFFFFF><center>"+capacity+"</center></td>");
        out.print("</tr>");
        while (tmpyear!=end_year || tmpmonth!=end_month) {
          tmpmonth++;
          if (tmpmonth>11) {
            tmpyear++;
            tmpmonth=0;
          }
          capacity=CAPA;
          mchk = Calendar.getInstance();
          mchk.setTime(d1.parse(tmpyear+"-"+(tmpmonth+1+"-01")));
          Statement STR11 = Conn.createStatement();
          String QR11 = "SELECT COUNT(DAYOFF) FROM OTHER_DAY_OFF WHERE SITEID='"+SITEID+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
          ResultSet R11 = STR11.executeQuery(QR11);
          nbdayoff=0;
          if (R11.next()) {
            nbdayoff=R11.getInt("COUNT(DAYOFF)");
          }
          STR11.close();
          Statement STR12 = Conn.createStatement();
          String QR12 = "SELECT COUNT(DAYOFF) FROM HOLLIDAY WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
          ResultSet R12 = STR12.executeQuery(QR12);
          nbholliday=0;
          if (R12.next()) {
            nbholliday=R12.getInt("COUNT(DAYOFF)");
          }
          STR12.close();
          capacity=(capacity*(mchk.getActualMaximum(Calendar.DAY_OF_MONTH)-nbdayoff-nbholliday))/mchk.getActualMaximum(Calendar.DAY_OF_MONTH);
          workload=0;
          Statement STR13 = Conn.createStatement();
          String QR13 = "SELECT WORKLOAD FROM EMPLOYEE_RECURRING_WORKLOAD WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
          ResultSet R13 = STR13.executeQuery(QR13);
          mwrkl = 0;
          while (R13.next()) {
            mwrkl=R13.getInt("WORKLOAD");
            workload=workload+mwrkl;   
          }
          STR13.close();
          Statement STR14 = Conn.createStatement();
          String QR14 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND PROJECTID IN (SELECT ID FROM PROJECT WHERE STATUS<>'REQUEST') ";
          ResultSet R14 = STR14.executeQuery(QR14);
          while (R14.next()) {
            Statement STR15 = Conn.createStatement();
            String QR15 = "SELECT PROJECTID,ACTIVITYID,WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE PROJECTID='"+R14.getString("PROJECTID")+"' AND ACTIVITYID='"+R14.getString("ACTIVITYID")+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
            ResultSet R15 = STR15.executeQuery(QR15);
            mwrkl = 0;
            while (R15.next()) {
              mwrkl=mwrkl+R15.getInt("WORKLOAD");
            }
            STR15.close();
            workload=workload+(mwrkl*R14.getInt("PERCENTAGE")/100);   
          }
          STR14.close();
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF>"+MOIS[tmpmonth]+" "+tmpyear+"</td>");
          if (workload>capacity) {
            out.print("<td bgcolor=#FFFFFF><center><span style=\"background-color:orange\"><A HREF=\"#\" onclick=\"window.showModalDialog('listteamworkload.jsp?TODO=NONE&EMPLOYEEID="+EMPLOYEEID+"&YEAR="+tmpyear+"&MONTH="+(tmpmonth+1)+"','','dialogHeight:400px;dialogWidth:800px;');\">"+workload+"</A></span></td>");
          } else {
            out.print("<td bgcolor=#FFFFFF><center><span style=\"\"><A HREF=\"#\" onclick=\"window.showModalDialog('listteamworkload.jsp?TODO=NONE&EMPLOYEEID="+EMPLOYEEID+"&YEAR="+tmpyear+"&MONTH="+(tmpmonth+1)+"','','dialogHeight:400px;dialogWidth:800px;');\">"+workload+"</A></span></td>");
          }
          out.print("<td bgcolor=#FFFFFF><center>"+capacity+"</center></td>");
          out.print("</tr>");
        }
        out.print("</tr>");
        out.print("</table>");
        out.print("<hr><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      } 

    %>
  </body>
</html>
