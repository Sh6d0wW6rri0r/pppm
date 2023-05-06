
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
        String pagtmp = request.getParameter("PAGE");
        int currentpage = Integer.parseInt(pagtmp);
      	out.print("<center><strong><h1>Workload/Capacity per team member</h1></strong></center><hr>");
        out.print("<Table><tr><td>You are here : Report \\ <A HREF=\"reportcapacity.jsp?TODO=NONE\" target=\"appliFrame\">Capacity</A> \\ Workload/Capacity per team member</td><td><A HREF=\"teamworkload.jsp?TODO=NONE&PAGE="+currentpage+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        String COLTOSORT = "ID";
        String DIRSORT = "ASC";
        if (act.equals("SORT")) {
          if (request.getParameter("FIELD").equals(request.getParameter("OLDFIELD"))) {
            COLTOSORT=request.getParameter("FIELD");
            if (request.getParameter("OLDDIR").equals("ASC")) {
               DIRSORT="DESC";
            } else {
               DIRSORT="ASC";
            }
          } else {
            COLTOSORT=request.getParameter("FIELD");
            DIRSORT="ASC";
          }
        }
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"teamworkload.jsp?TODO=FILTER&FILTER=FILTER&PAGE="+currentpage+"\" target=\"appliFrame\">");
        String LASTFILTERTEAMCAPACITY=null;
        Statement st123b = Conn.createStatement();
        String q123b = "SELECT FILTERVALUE FROM FILTER WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERTEAMCAPACITY'";
        ResultSet r123b = st123b.executeQuery(q123b);
        if (r123b.next()) {
          LASTFILTERTEAMCAPACITY=r123b.getString("FILTERVALUE");
        }
        st123b.close();
        String filter = request.getParameter("FILTER");
        String filterstatement ="";
        String filstrTEAM=request.getParameter("SELECTFILTERTEAM");
        if (filstrTEAM==null) {
          if (LASTFILTERTEAMCAPACITY!=null) {
            filter="FILTER";
            filstrTEAM=LASTFILTERTEAMCAPACITY;
          } else {
            filter=null;
            filstrTEAM="*** - ALL";
          }
        } else {
          if (LASTFILTERTEAMCAPACITY!=null) {
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE FILTER SET FILTERVALUE='"+filstrTEAM+"' WHERE LOGIN='"+Userlogin+"' AND FILTERNAME='LASTFILTERTEAMCAPACITY'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO FILTER VALUES('"+Userlogin+"','LASTFILTERTEAMCAPACITY','"+filstrTEAM+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
        out.print("<tr><td>");
        out.print("<table width=\"100%\" CELLSPACING=\"0\"><tr>");
        out.print("<td bgcolor=\"#FFFFFF\">");
        out.print("Team : <select name=\"SELECTFILTERTEAM\">");
        out.print("<option>*** - ALL</option>");
        out.print("<option");
        if (filstrTEAM.equals("ORG - My hierarchical team")) {
          out.print(" selected ");
        }
        out.print(">ORG - My hierarchical team</option>");
        Statement st22 = Conn.createStatement();
        String q22 = "SELECT ID,NAME FROM TEAM WHERE ID IN (select TEAMID FROM EMPTM WHERE EMPLOYEEID='"+Userlogin+"')  ORDER BY NAME";
        ResultSet r22 = st22.executeQuery(q22);
        while(r22.next()) {
          out.print("<option");
          if (filstrTEAM.equals(r22.getString("ID")+" - "+r22.getString("NAME"))) {
            out.print(" selected ");
          }
          out.print(">"+r22.getString("ID")+" - "+r22.getString("NAME")+"</option>");
        }
        st22.close();
        out.print("</select>");
        out.print("</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>");
        out.print("<input type=\"image\" border=0 src=\"icons/search.png\" name=\"filter\" value=\"submit\"></center>");
        out.print("</td>");
        out.print("</tr></table>");
        out.print("</td>");
        out.print("</tr></table>");
        out.print("<br>");
        out.print("</form>");
        boolean first=true;
        String idfilTEAM="***";
        if (filter!= null) {
          idfilTEAM = filstrTEAM.substring(0,filstrTEAM.indexOf("-")-1);
          if (!idfilTEAM.equals("***")) {
            if (idfilTEAM.equals("ORG")) {
              if (!first) {
                filterstatement = filterstatement + " AND ";
              } else {
                filterstatement = " WHERE " ;
              }
              filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM WORKON WHERE EMPLOYEEID IN (SELECT EMPLOYEEID FROM EMPLOYEE WHERE OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"')))";
              first = false;
            } else {
              if (!first) {
                filterstatement = filterstatement + " AND ";
              } else {
                filterstatement = " WHERE " ;
              }
              filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM WORKON WHERE EMPLOYEEID IN (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID ='"+idfilTEAM+"'))";
              first = false;
            }
          }
        }
        out.print("<table><tr><td><h2><strong>Profile workload / capacity (hours)</strong></h2></center></td>");
        Statement st230 = Conn.createStatement();
        int nbpage=0;
        int nbpage1=0;
        if (!idfilTEAM.equals("ORG")) {
          String q230 = "SELECT COUNT(EMPLOYEEID) FROM RESTM";
          if (idfilTEAM.equals("***")) {
            q230=q230+" WHERE TEAMID IN (SELECT TEAMID FROM EMPTM WHERE EMPLOYEEID='"+Userlogin+"')";
          } else {
            q230=q230+" WHERE TEAMID='"+idfilTEAM+"'";
          }
          ResultSet r230 = st230.executeQuery(q230);
          if (r230.next()) {    
            nbpage1=r230.getInt("COUNT(EMPLOYEEID)")/10;
          }
          st230.close();
        } else {
          String q230="SELECT COUNT(ID) FROM EMPLOYEE WHERE OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"')";
          ResultSet r230 = st230.executeQuery(q230);
          if (r230.next()) {    
            nbpage1=r230.getInt("COUNT(ID)")/10;
          }
          st230.close();
        }
        int nbpage2=0;
        if (idfilTEAM.equals("***")) {
          st230=Conn.createStatement();
          String q230="SELECT COUNT(ID) FROM EMPLOYEE WHERE OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"')";
          ResultSet r230=st230.executeQuery(q230);
          if (r230.next()) {    
            nbpage2=r230.getInt("COUNT(ID)")/10;
          } 
          st230.close();
        }
        nbpage=nbpage1+nbpage2;
        out.print("<td>Page : </td>");
        for (int i=0; i<=nbpage;i++) {
          out.print("<td><A HREF=\"profileworkload.jsp?TODO=NONE&PAGE="+i+"\">"+i+"</A></td>");
        }
        out.print("</tr></table>");
        Statement st0 = Conn.createStatement();
        String DATE_START="2011-01-01";
        String DATE_END="2012-12-31";
        String q0 = "SELECT COUNT(ID) FROM PROJECT "+filterstatement;
        ResultSet r0 = st0.executeQuery(q0);
        if (r0.next()) {
          if(r0.getInt("COUNT(ID)")>0) {
            Statement st1 = Conn.createStatement();
            String q1 = "SELECT MIN(DATE_START),MAX(DATE_END) FROM PROJECT "+filterstatement;
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
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\">");
        out.print("<tr>");
        out.print("<td>");
        out.print("<table style=\"width:100px;\">");
        out.print("<tr valign=\"top\">");
        out.print("<td style=\"width:100px;\">");
        out.print("<table style=\"width:100px;\">");
        out.print("<tr>");
        out.print("<td style=\"width:100px;height:30px;\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("</tr>");
        int nbp=0;
        Statement st130 = Conn.createStatement();
        String q130 = "SELECT NAME,FORNAME FROM EMPLOYEE";
        if (idfilTEAM.equals("***")) {
          q130=q130+" WHERE ID IN (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID IN (SELECT TEAMID FROM EMPTM WHERE EMPLOYEEID='"+Userlogin+"')) OR OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"')";
        } else {
          if (idfilTEAM.equals("ORG")) {
            q130=q130+" WHERE OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"')";
          } else {
            q130=q130+" WHERE ID IN (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID='"+idfilTEAM+"')";
          }
        }     
        q130=q130+" ORDER BY NAME,FORNAME";        
        ResultSet r130 = st130.executeQuery(q130);
        int nbrow =0;
        while(r130.next()) {
          nbrow++;
          if (nbrow > currentpage*10 && nbrow <=(currentpage+1)*10) {
            nbp++;
            out.print("<tr>");
            out.print("<td style=\"width:100px;height:45px;\" bgcolor=#FFFFFF><center>&nbsp;"+r130.getString("NAME")+"-"+r130.getString("FORNAME")+"</center></td>");
            out.print("</tr>");
          }
        }
        st130.close();
        out.print("</table>");
        out.print("</td>");
        out.print("<td>");
        out.print("<div style=\"width:1100px;height:580px;overflow:auto;\">");
        out.print("<table style=\"width:"+nbmonth*100+"px;height:"+nbp*45+"px;\" >");
        out.print("<tr>");
        tmpyear=start_year;
        tmpmonth=start_month;
        out.print("<td style=\"width:100px;height:30px;\" background=\"images/fond_titre.jpg\"><center>"+MOIS[tmpmonth]+" "+tmpyear+" Workload/Capacity</center></td>");
        while (tmpyear!=end_year || tmpmonth!=end_month) {
          tmpmonth++;
          if (tmpmonth>11) {
            tmpyear++;
            tmpmonth=0;
            out.print("<td style=\"width:100px;height:30px;\" background=\"images/fond_titre.jpg\"><center>"+MOIS[tmpmonth]+" "+tmpyear+" Workload/Capacity</center></td>");
          } else {
            out.print("<td style=\"width:100px;height:30px;\" background=\"images/fond_titre.jpg\"><center>"+MOIS[tmpmonth]+" "+tmpyear+" Workload/Capacity</center></td>");
          }
        }
        out.print("</tr>");
        Statement st131 = Conn.createStatement();
        String q131 = "SELECT NAME,FORNAME,ID,SITEID,CAPACITY FROM EMPLOYEE";
        if (idfilTEAM.equals("***")) {
          q131=q131+" WHERE ID IN (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID IN (SELECT TEAMID FROM EMPTM WHERE EMPLOYEEID='"+Userlogin+"')) OR OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"')";
        } else {
          if (idfilTEAM.equals("ORG")) {
            q131=q131+" WHERE OUID IN (SELECT ID FROM OU WHERE EMPLOYEEID='"+Userlogin+"')";
          } else {
            q131=q131+" WHERE ID IN (SELECT EMPLOYEEID FROM RESTM WHERE TEAMID='"+idfilTEAM+"')";
          }
        }     
        q131=q131+" ORDER BY NAME,FORNAME";   
        ResultSet r131 = st131.executeQuery(q131);
        int nbrow2=0;
        while(r131.next()) {
          nbrow2++;
          if (nbrow2 > currentpage*10 && nbrow2 <=(currentpage+1)*10) {
            out.print("<tr>");
            tmpyear=start_year;
            tmpmonth=start_month;
            int capacity=r131.getInt("CAPACITY");
            Calendar mchk = Calendar.getInstance();
            mchk.setTime(d1.parse(tmpyear+"-"+(tmpmonth+1+"-01")));
            Statement st231 = Conn.createStatement();
            String q231 = "SELECT COUNT(DAYOFF) FROM OTHER_DAY_OFF WHERE SITEID='"+r131.getString("SITEID")+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
            ResultSet r231 = st231.executeQuery(q231);
            int nbdayoff=0;
            if (r231.next()) {
              nbdayoff=r231.getInt("COUNT(DAYOFF)");
            }
            st231.close();
            st231 = Conn.createStatement();
            q231 = "SELECT COUNT(DAYOFF) FROM HOLLIDAY WHERE EMPLOYEEID='"+r131.getString("ID")+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
            r231 = st231.executeQuery(q231);
            int nbholliday=0;
            if (r231.next()) {
              nbholliday=r231.getInt("COUNT(DAYOFF)");
            }
            st231.close();
            capacity=(capacity*(mchk.getActualMaximum(Calendar.DAY_OF_MONTH)-nbdayoff-nbholliday))/mchk.getActualMaximum(Calendar.DAY_OF_MONTH);
            int workload=0;
            Statement st232 = Conn.createStatement();
            String q232 = "SELECT WORKLOAD FROM EMPLOYEE_RECURRING_WORKLOAD WHERE EMPLOYEEID='"+r131.getString("ID")+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
            ResultSet r232 = st232.executeQuery(q232);
            int mwrkl = 0;
            while (r232.next()) {
              mwrkl=r232.getInt("WORKLOAD");
              workload=workload+mwrkl;   
            }
            st232.close();
            st232 = Conn.createStatement();
            q232 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+r131.getString("ID")+"' AND PROJECTID IN (SELECT ID FROM PROJECT WHERE STATUS<>'REQUEST' AND ONHOLD='N') ";
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
              workload=workload+(mwrkl*r232.getInt("PERCENTAGE")/100);   
            }
            st232.close();
            if (workload>capacity) {
              out.print("<td style=\"width:100px;height:45px;\" bgcolor=#FFFFFF><center><table><tr><td><span style=\"background-color:orange\"><A HREF=\"#\" onclick=\"window.showModalDialog('listteamworkload.jsp?TODO=NONE&EMPLOYEEID="+r131.getString("ID")+"&YEAR="+tmpyear+"&MONTH="+(tmpmonth+1)+"','','dialogHeight:400px;dialogWidth:800px;');\">"+workload+"</A></span></td><td>/</td><td>"+capacity+"</td></tr></table></center></td>");
            } else {
              out.print("<td style=\"width:100px;height:45px;\" bgcolor=#FFFFFF><center><table><tr><td><span style=\"\"><A HREF=\"#\" onclick=\"window.showModalDialog('listteamworkload.jsp?TODO=NONE&EMPLOYEEID="+r131.getString("ID")+"&YEAR="+tmpyear+"&MONTH="+(tmpmonth+1)+"','','dialogHeight:400px;dialogWidth:800px;');\">"+workload+"</A></span></td><td>/</td><td>"+capacity+"</td></tr></table></center></td>");
            }
            while (tmpyear!=end_year || tmpmonth!=end_month) {
              tmpmonth++;
              if (tmpmonth>11) {
                tmpyear++;
                tmpmonth=0;
              }
              capacity=r131.getInt("CAPACITY");
              mchk = Calendar.getInstance();
              mchk.setTime(d1.parse(tmpyear+"-"+(tmpmonth+1+"-01")));
              st231 = Conn.createStatement();
              q231 = "SELECT COUNT(DAYOFF) FROM OTHER_DAY_OFF WHERE SITEID='"+r131.getString("SITEID")+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
              r231 = st231.executeQuery(q231);
              nbdayoff=0;
              if (r231.next()) {
                nbdayoff=r231.getInt("COUNT(DAYOFF)");
              }
              st231.close();
              st231 = Conn.createStatement();
              q231 = "SELECT COUNT(DAYOFF) FROM HOLLIDAY WHERE EMPLOYEEID='"+r131.getString("ID")+"' AND DAYOFF>='"+tmpyear+"-"+(tmpmonth+1)+"-01' AND DAYOFF<='"+tmpyear+"-"+(tmpmonth+1)+"-"+mchk.getActualMaximum(Calendar.DAY_OF_MONTH)+"'";
              r231 = st231.executeQuery(q231);
              nbholliday=0;
              if (r231.next()) {
                nbholliday=r231.getInt("COUNT(DAYOFF)");
              }
              st231.close();
              capacity=(capacity*(mchk.getActualMaximum(Calendar.DAY_OF_MONTH)-nbdayoff-nbholliday))/mchk.getActualMaximum(Calendar.DAY_OF_MONTH);
              workload=0;
              st232 = Conn.createStatement();
              q232 = "SELECT WORKLOAD FROM EMPLOYEE_RECURRING_WORKLOAD WHERE EMPLOYEEID='"+r131.getString("ID")+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
              r232 = st232.executeQuery(q232);
              mwrkl = 0;
              while (r232.next()) {
                mwrkl=r232.getInt("WORKLOAD");
                workload=workload+mwrkl;   
              }
              st232.close();
              st232 = Conn.createStatement();
              q232 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+r131.getString("ID")+"' AND PROJECTID IN (SELECT ID FROM PROJECT WHERE STATUS<>'REQUEST' AND ONHOLD='N') ";
              r232 = st232.executeQuery(q232);
              while (r232.next()) {
                Statement st233 = Conn.createStatement();
                String q233 = "SELECT PROJECTID,ACTIVITYID,WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE PROJECTID='"+r232.getString("PROJECTID")+"' AND ACTIVITYID='"+r232.getString("ACTIVITYID")+"' AND MONTH="+(tmpmonth+1)+" AND YEAR="+tmpyear;
                ResultSet r233 = st233.executeQuery(q233);
                mwrkl = 0;
                while (r233.next()) {
                  mwrkl=mwrkl+r233.getInt("WORKLOAD");
                }
                st233.close();
                workload=workload+(mwrkl*r232.getInt("PERCENTAGE")/100);   
              }
              st232.close();
              if (workload>capacity) {
                out.print("<td style=\"width:100px;height:45px;\" bgcolor=#FFFFFF><center><table><tr><td><span style=\"background-color:orange\"><A HREF=\"#\" onclick=\"window.showModalDialog('listteamworkload.jsp?TODO=NONE&EMPLOYEEID="+r131.getString("ID")+"&YEAR="+tmpyear+"&MONTH="+(tmpmonth+1)+"','','dialogHeight:400px;dialogWidth:800px;');\">"+workload+"</A></span></td><td>/</td><td>"+capacity+"</td></tr></table></center></td>");
              } else {
                out.print("<td style=\"width:100px;height:45px;\" bgcolor=#FFFFFF><center><table><tr><td><span style=\"\"><A HREF=\"#\" onclick=\"window.showModalDialog('listteamworkload.jsp?TODO=NONE&EMPLOYEEID="+r131.getString("ID")+"&YEAR="+tmpyear+"&MONTH="+(tmpmonth+1)+"','','dialogHeight:400px;dialogWidth:800px;');\">"+workload+"</A></span></td><td>/</td><td>"+capacity+"</td></tr></table></center></td>");
              }
            }
            out.print("</tr>");
          }
        }
        st131.close();
        out.print("</table>");
        out.print("</div>");
        out.print("</td>");   
        out.print("</tr>");
        out.print("</table>");
        out.print("</div>");
        out.print("</td>");
        out.print("</tr>");
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
