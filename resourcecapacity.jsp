
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

 
  <%!boolean checknum(String str) {
  
      boolean isok=true;
      if (str.length()>10) {
        isok=false;
      } else {
        for (int it=0; it <str.length();it++) {
          if ((str.charAt(it)!='0') && (str.charAt(it)!='1') && (str.charAt(it)!='2') && (str.charAt(it)!='3') && (str.charAt(it)!='4') && (str.charAt(it)!='5') && (str.charAt(it)!='6') && (str.charAt(it)!='7') && (str.charAt(it)!='8') && (str.charAt(it)!='9') && (str.charAt(it)!='.')) {
            isok=false;
          }
        }
      }
      return isok;
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
      	if (act.equals("CAPMOD")) {
          String CAPACITY = checkstr(request.getParameter("CAPACITY"));
          if (CAPACITY.equals("")) {
            CAPACITY="0";
          }
          if (checknum(CAPACITY)) {
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE EMPLOYEE SET CAPACITY="+CAPACITY+" WHERE ID='"+EMPLOYEEID+"'";
            sti2.executeUpdate(i2);
            sti2.close();
          } else {
            out.print("<HR>ERROR IN THE NUMBER FORMAT<HR>");
          }
        }
        if (act.equals("LOADADD")) {
          String RECURRINGID = request.getParameter("RECURRINGID");
          int ORD=0;
          Statement st43 = Conn.createStatement();
          String q43 = "SELECT ORD FROM EMPREC WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND RECURRINGID='"+RECURRINGID+"' ORDER BY ORD DESC";
          ResultSet r43 = st43.executeQuery(q43);
          if (r43.next()) {
            ORD=r43.getInt("ORD")+1;
          }
          st43.close();
          Statement sti2 = Conn.createStatement();
          Calendar rn= Calendar.getInstance();
          String DATE_START = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
          String DATE_END = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
          String i2 = "INSERT INTO EMPREC VALUES ("+ORD+",'"+EMPLOYEEID+"','"+RECURRINGID+"',0,'"+DATE_START+"','"+DATE_END+"')";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("LOADDELETE")) {
          String RECURRINGID = request.getParameter("RECURRINGID");
          String ORD = request.getParameter("ORD");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM EMPREC WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND RECURRINGID='"+RECURRINGID+"' AND ORD="+ORD;
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("LOADMOD")) {
          String PROFILEID = request.getParameter("PROFILEID");
          String RECURRINGID = request.getParameter("RECURRINGID");
          String ORD = request.getParameter("ORD");
          String WORKLOAD = checkstr(request.getParameter("WORKLOAD"));
          if (WORKLOAD.equals("")) {
            WORKLOAD="0";
          }
          if (checknum(WORKLOAD)) {
            String DATE_START = request.getParameter("DATE_START");
            String DATE_END = request.getParameter("DATE_END");
            SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
            long begincreneau = d1.parse(DATE_START).getTime();
            long endcreneau = d2.parse(DATE_END).getTime();  
            long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
            long nday=0;
            for (long delta = begincreneau; delta <= endcreneau; delta = delta+ MILLISECONDS_PER_DAY) {
              Calendar cday = Calendar.getInstance();
              cday.setTimeInMillis(delta);
              if ((cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
                nday++;
              }
            }
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE EMPREC SET WORKLOAD="+WORKLOAD+",DATE_START='"+DATE_START+"',DATE_END='"+DATE_END+"' WHERE ORD="+ORD+" AND RECURRINGID='"+RECURRINGID+"' AND EMPLOYEEID='"+EMPLOYEEID+"'";
            sti2.executeUpdate(i2);
            sti2.close();
            Calendar start = Calendar.getInstance();
            start.setTime(d1.parse(DATE_START));
            Calendar end = Calendar.getInstance();
            end.setTime(d2.parse(DATE_END));
            int start_month = start.get(Calendar.MONTH);
            int start_year = start.get(Calendar.YEAR);
            int end_month = end.get(Calendar.MONTH);
            int end_year = end.get(Calendar.YEAR);   
            int nbmonth=1;
            int currentmonth=start_month;
            int nbdays[] = new int[255];
            nbdays[nbmonth]=0;
            Calendar tmpst = Calendar.getInstance();
            tmpst.setTime(d1.parse(""+start_year+"-"+(start_month+1)+"-01"));
            long sdt = tmpst.getTimeInMillis();
            Calendar tmped = Calendar.getInstance();
            if (end_month==1) {
              tmped.setTime(d1.parse(""+end_year+"-"+(end_month+1)+"-28"));
            } else {
              tmped.setTime(d1.parse(""+end_year+"-"+(end_month+1)+"-30"));
            }
            while (sdt<=tmped.getTimeInMillis()) {
              sdt=sdt+MILLISECONDS_PER_DAY;
              Calendar caltmp = Calendar.getInstance();
              caltmp.setTimeInMillis(sdt);
              if ((caltmp.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (caltmp.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
                nbdays[nbmonth]++;
              }
              if (caltmp.get(Calendar.MONTH)!=currentmonth) {
                currentmonth=caltmp.get(Calendar.MONTH);
                nbmonth++;
                nbdays[nbmonth]=0;
              }
            }
            int nbmonthb=1;
            int currentmonthb=start_month;
            int nbdaysopen[] = new int[255];
            nbdaysopen[nbmonthb]=0;
            long sdtb = start.getTimeInMillis();
            while (sdtb<=end.getTimeInMillis()) {
              sdtb=sdtb+MILLISECONDS_PER_DAY;
              Calendar caltmp = Calendar.getInstance();
              caltmp.setTimeInMillis(sdtb);
              if ((caltmp.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (caltmp.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
                nbdaysopen[nbmonthb]++;
              }
              if (caltmp.get(Calendar.MONTH)!=currentmonthb) {
                currentmonthb=caltmp.get(Calendar.MONTH);
                nbmonthb++;
                nbdaysopen[nbmonthb]=0;
              }
            }
            Statement sti4 = Conn.createStatement();
            String i4 = "DELETE FROM EMPLOYEE_RECURRING_WORKLOAD WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND RECURRINGID='"+RECURRINGID+"' AND ORD="+ORD;
            sti4.executeUpdate(i4);
            sti4.close(); 
            currentmonth=1;
            int tmpyear=start_year;
            int tmpmonth=start_month;
            long sumwrkl=0;
            while (tmpyear!=end_year || tmpmonth!=end_month) {
              long wrkl =  Integer.parseInt(WORKLOAD)*nbdaysopen[currentmonth]/nbdays[currentmonth];
              Statement sti3 = Conn.createStatement();
              String i3 = "INSERT INTO EMPLOYEE_RECURRING_WORKLOAD VALUES ('"+EMPLOYEEID+"','"+RECURRINGID+"',"+ORD+","+tmpyear+","+(tmpmonth+1)+","+wrkl+")";
              sti3.executeUpdate(i3);
              sti3.close();
              nbmonth++;
              tmpmonth++;
              currentmonth++;
              if (tmpmonth>11) {
                tmpyear++;
                tmpmonth=0;
              } 
            }
            long wrkl =  Integer.parseInt(WORKLOAD)*nbdaysopen[currentmonth]/nbdays[currentmonth];
            Statement sti3 = Conn.createStatement();
            String i3 = "INSERT INTO EMPLOYEE_RECURRING_WORKLOAD VALUES ('"+EMPLOYEEID+"','"+RECURRINGID+"',"+ORD+","+tmpyear+","+(tmpmonth+1)+","+wrkl+")";
            sti3.executeUpdate(i3);
            sti3.close();
          } else {
            out.print("<hr> ERROR ON THE NUMBER FORMAT<HR>");
          }
        }
        out.print("<table><tr><td><h2><strong>Resource Capacity(h/month)</strong></h2></center></td>");
        out.print("<td><A HREF=\"modifyresourcecapacity.jsp?TODO=MOD&EMPLOYEEID="+EMPLOYEEID+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
        out.print("</tr></table>");
        String CAPACITY = "";
        Statement st10 = Conn.createStatement();
        String q10 = "SELECT CAPACITY FROM EMPLOYEE WHERE ID='"+EMPLOYEEID+"'";
        ResultSet r10 = st10.executeQuery(q10);
        if (r10.next()) {
          CAPACITY=r10.getString("CAPACITY");
        }
        st10.close();
        out.print("<table>");
        out.print("<tr><td><h2><strong>Capacity (h/month) : </strong></h2></td><td>"+CAPACITY+"</td></tr>");
        out.print("</table>");
        out.print("<hr><table><tr><td><h2><strong>Recurring workload (hours per month)</strong></h2></center></td><td><A HREF=\"addresourcerecurring.jsp?TODO=ADD&EMPLOYEEID="+EMPLOYEEID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>Workload (h/month)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Start</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>End</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st33 = Conn.createStatement();
        String q33 = "SELECT ORD,WORKLOAD,RECURRINGID,DATE_START,DATE_END FROM EMPREC WHERE EMPLOYEEID='"+EMPLOYEEID+"'";
        ResultSet r33 = st33.executeQuery(q33);
        while(r33.next()) {
          out.print("<tr>");
          Statement st31 = Conn.createStatement();
          String q31 = "SELECT ID,NAME FROM RECURRING WHERE ID='"+r33.getString("RECURRINGID")+"'";
          ResultSet r31 = st31.executeQuery(q31);
          if (r31.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("NAME")+"</center></A></td>");
          }
          st31.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r33.getString("WORKLOAD")+"<A HREF=\"resourcerecurring.jsp?TODO=ADD&ORD="+r33.getString("ORD")+"&EMPLOYEEID="+EMPLOYEEID+"&RECURRINGID="+r33.getString("RECURRINGID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r33.getString("DATE_START")+"<A HREF=\"resourcerecurring.jsp?TODO=ADD&ORD="+r33.getString("ORD")+"&EMPLOYEEID="+EMPLOYEEID+"&RECURRINGID="+r33.getString("RECURRINGID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r33.getString("DATE_END")+"<A HREF=\"resourcerecurring.jsp?TODO=ADD&ORD="+r33.getString("ORD")+"&EMPLOYEEID="+EMPLOYEEID+"&RECURRINGID="+r33.getString("RECURRINGID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></center></td>");
          out.print("<td><center><A HREF=\"deleteresourcerecurring.jsp?TODO=DELETE&ORD="+r33.getString("ORD")+"&RECURRINGID="+r33.getString("RECURRINGID")+"&EMPLOYEEID="+EMPLOYEEID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        st33.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      }

    %>
  </body>
</html>
