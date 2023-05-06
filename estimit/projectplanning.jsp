
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
      String POOLNAME=(String)session.getAttribute("POOLNAME");

      // database connection
      Context initCtx = new InitialContext();
      DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
      Connection Conn = ds.getConnection();

      // JSP parameters
      String act = request.getParameter("TODO");
      String PROJECTID = request.getParameter("PROJECTID");
      String PROJECTTYPEID = request.getParameter("PROJECTTYPEID");

      if (Userlogin==null) {
        out.print("<script language=\"JavaScript\">");
        out.print("top.appliFrame.location='login.jsp?TIMEOUT=TRUE';");
        out.print("</script>");
      } else {
        if (act.equals("CALCIT")) {
            String NBEASY = request.getParameter("NBEASY");
            String NBSTANDARD = request.getParameter("NBSTANDARD");
            String NBCOMPLEX = request.getParameter("NBCOMPLEX");
            Statement STRC01 = Conn.createStatement();
            String QRC01 = "SELECT NBEASY,NBSTANDARD,NBCOMPLEX FROM PROJECT_REQUIREMENTS WHERE PROJECTID='"+PROJECTID+"'";
            ResultSet RC01 = STRC01.executeQuery(QRC01);
            if (RC01.next()) {
              Statement sti2 = Conn.createStatement();
              String i2 = "UPDATE PROJECT_REQUIREMENTS SET NBEASY="+NBEASY+",NBSTANDARD="+NBSTANDARD+",NBCOMPLEX="+NBCOMPLEX+" WHERE PROJECTID='"+request.getParameter("PROJECTID")+"'";
              sti2.executeUpdate(i2);
              sti2.close();
            } else {
              Statement sti2 = Conn.createStatement();
              String i2 = "INSERT INTO PROJECT_REQUIREMENTS VALUES('"+PROJECTID+"',"+NBEASY+","+NBSTANDARD+","+NBCOMPLEX+")";
              sti2.executeUpdate(i2);
              sti2.close();
            }
           STRC01.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/planning.png\"></td><td><strong><h1>Project Planning phase</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Projects \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\"> My Project Portfolio</A> \\ Project planning<td><A HREF=\"projectplanning.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        int EASYREQ = 0;
        int STANDARDREQ=0;
        int COMPLEXREQ=0;
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectplanning.jsp?TODO=CALCIT&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\" target=\"appliFrame\">");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT NBEASY,NBSTANDARD,NBCOMPLEX FROM PROJECT_REQUIREMENTS WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          EASYREQ=R01.getInt("NBEASY");
          STANDARDREQ=R01.getInt("NBSTANDARD");
          COMPLEXREQ=R01.getInt("NBCOMPLEX");
        }
        STR01.close();
        out.print("<table><tr><td><h1><strong>Planning phase parameters</strong></h1></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Easy</center></b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Standard</b></center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Complex</b></center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Total</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Use-Cases</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"NBEASY\" type=\"text\" size=\"10\" value=\""+EASYREQ+"\"></center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"NBSTANDARD\" type=\"text\" size=\"10\" value=\""+STANDARDREQ+"\"></center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"NBCOMPLEX\" type=\"text\" size=\"10\" value=\""+COMPLEXREQ+"\"></center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+(EASYREQ+STANDARDREQ+COMPLEXREQ)+"</b></center></td>");
        out.print("</tr>");
        long TOTALEASYREQ=0;
        long TOTALSTANDARDREQ=0;
        long TOTALCOMPLEXREQ=0;
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT EASY_HOURS,STANDARD_HOURS,COMPLEX_HOURS FROM PROJECT_PLANNING_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet R02 = STR02.executeQuery(QR02);
        if (R02.next()) {
          TOTALEASYREQ=R02.getLong("EASY_HOURS")*EASYREQ;
          TOTALSTANDARDREQ=R02.getLong("STANDARD_HOURS")*STANDARDREQ;
          TOTALCOMPLEXREQ=R02.getLong("COMPLEX_HOURS")*COMPLEXREQ;
        }
        STR02.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Requirements workload (hours)</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALEASYREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALSTANDARDREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALCOMPLEXREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+(TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ)+"</b></center></td>");
        out.print("</tr>");
        long TOTALPMREQ=0;
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='PL-PM'";
        ResultSet R03 = STR03.executeQuery(QR03);
        if (R03.next()) {
          TOTALPMREQ=R03.getLong("RATIO")*(TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ)/100;
        }
        STR03.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Project Management workload (hours)</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALPMREQ+"</b></center></td>");
        out.print("</tr>");
        long TOTALQAREQ=0;
        Statement STR04 = Conn.createStatement();
        String QR04 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='PL-QA'";
        ResultSet R04 = STR04.executeQuery(QR04);
        if (R04.next()) {
          TOTALQAREQ=R04.getLong("RATIO")*(TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ)/100;
        }
        STR04.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Quality Management workload (hours)</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALQAREQ+"</b></center></td>");
        out.print("</tr>");
        long TOTALPLANNING=TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ+TOTALPMREQ+TOTALQAREQ;
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\"><b>Total Planning workload (hours)</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALPLANNING+"</b></center></td>");
        out.print("</tr>");

        out.print("</table>");
        out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/approve.png\" type=image Value=submit></td>");
        out.print("</tr></table>");
        out.print("</table>");
        out.print("</form>");
        out.print("<hr>");
        out.print("<table><tr><td><h1><strong>High-Level estimation for the remaining phases of the project</strong></h1></center></td></tr></table>");

        long TOTALDEV=0;
        long TOTALTEST=0;
        Statement STR05 = Conn.createStatement();
        String QR05 = "SELECT DEV_RATIO,TESTING_RATIO FROM PROJECT_EXECUTION_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet R05 = STR05.executeQuery(QR05);
        if (R05.next()) {
          TOTALDEV=R05.getLong("DEV_RATIO")*(TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ)/100;
          TOTALTEST=R05.getLong("TESTING_RATIO")*(TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ)/100;
        }
        STR05.close();

        out.print("<br><h2>Execution Phase</h2><br>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Workload</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Development/Configuration</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALDEV+"</center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Testing</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALTEST+"</center></td>");
        out.print("</tr>");
        out.print("<tr>");
        long TOTALPMEXE=0;
        Statement STR06 = Conn.createStatement();
        String QR06 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='EX-PM'";
        ResultSet R06 = STR06.executeQuery(QR06);
        if (R06.next()) {
          TOTALPMEXE=R06.getLong("RATIO")*(TOTALDEV+TOTALTEST)/100;
        }
        STR06.close();
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Project Management</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALPMEXE+"</center></td>");
        out.print("</tr>");
        out.print("<tr>");
        long TOTALQAEXE=0;
        Statement STR07 = Conn.createStatement();
        String QR07 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='EX-QA'";
        ResultSet R07 = STR07.executeQuery(QR07);
        if (R07.next()) {
          TOTALQAEXE=R07.getLong("RATIO")*(TOTALDEV+TOTALTEST)/100;
        }
        STR07.close();
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Quality Management</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALQAEXE+"</center></td>");
        out.print("</tr>");
        long TOTALEXE=TOTALDEV+TOTALTEST+TOTALPMEXE+TOTALQAEXE;
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for Execution phase</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALEXE+"</b></center></td>");
        out.print("</tr>");
        out.print("</table>");

        out.print("<br><h2>Deployement Phase</h2><br>");
        long TOTALDEPL=0;
        Statement STR08 = Conn.createStatement();
        String QR08 = "SELECT STANDARD_RATIO FROM PROJECT_DEPL_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet R08 = STR08.executeQuery(QR08);
        if (R08.next()) {
          TOTALDEPL=R08.getLong("STANDARD_RATIO")*(TOTALDEV+TOTALTEST)/100;
        }
        STR08.close();
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Workload</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Deployment</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALDEPL+"</center></td>");
        out.print("</tr>");
        long TOTALTRAIN=0;
        Statement STR09 = Conn.createStatement();
        String QR09 = "SELECT STANDARD_RATIO FROM PROJECT_TRAIN_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet R09 = STR09.executeQuery(QR09);
        if (R09.next()) {
          TOTALTRAIN=R09.getLong("STANDARD_RATIO")*(TOTALDEV+TOTALTEST)/100;
        }
        STR09.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Training</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALTRAIN+"</center></td>");
        out.print("</tr>");
        long TOTALPMDPL=0;
        Statement STR10 = Conn.createStatement();
        String QR10 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='DP-PM'";
        ResultSet R10 = STR10.executeQuery(QR10);
        if (R10.next()) {
          TOTALPMDPL=R10.getLong("RATIO")*(TOTALDEPL+TOTALTRAIN)/100;
        }
        STR10.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Project Management</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALPMDPL+"</center></td>");
        out.print("</tr>");
        long TOTALQADPL=0;
        Statement STR11 = Conn.createStatement();
        String QR11 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='DP-QA'";
        ResultSet R11 = STR11.executeQuery(QR11);
        if (R11.next()) {
          TOTALQADPL=R11.getLong("RATIO")*(TOTALDEPL+TOTALTRAIN)/100;
        }
        STR11.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Quality Management</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALQADPL+"</center></td>");
        out.print("</tr>");
        long TOTALDPL=TOTALDEPL+TOTALTRAIN+TOTALPMDPL+TOTALQADPL;
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for Deployment phase</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALDPL+"</b></center></td>");
        out.print("</tr>");
        out.print("</table>");


        out.print("<br><h2>Close Phase</h2><br>");
        long TOTALCLOSE=0;
        Statement STR12 = Conn.createStatement();
        String QR12 = "SELECT RATIO FROM PROJECT_CLOSE_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet R12 = STR12.executeQuery(QR12);
        if (R12.next()) {
          TOTALCLOSE=R12.getLong("RATIO")*(TOTALDEV+TOTALTEST)/100;
        }
        STR12.close();
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Workload</b></center></td>");
        out.print("</tr>");        
        long TOTALPMCLOSE=0;
        Statement STR13 = Conn.createStatement();
        String QR13 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='CL-PM'";
        ResultSet R13 = STR13.executeQuery(QR13);
        if (R13.next()) {
          TOTALPMCLOSE=R13.getLong("RATIO")*TOTALCLOSE/100;
        }
        STR13.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Project Management</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALPMCLOSE+"</center></td>");
        out.print("</tr>");
        long TOTALQACLOSE=0;
        Statement STR14 = Conn.createStatement();
        String QR14 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='CL-QA'";
        ResultSet R14 = STR14.executeQuery(QR14);
        if (R14.next()) {
          TOTALQACLOSE=R14.getLong("RATIO")*TOTALCLOSE/100;
        }
        STR14.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Quality Management</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALQACLOSE+"</center></td>");
        out.print("</tr>");
        long TOTALCL=TOTALPMCLOSE+TOTALQACLOSE;
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for Close phase</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALCL+"</b></center></td>");
        out.print("</tr>");
        out.print("</table>");

        out.print("<br><h2>Total Project</h2><br>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Workload</b></center></td>");
        out.print("</tr>");
        long TOTALPROJECT=TOTALCL+TOTALDEPL+TOTALEXE+TOTALPLANNING;        
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for project</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALPROJECT+"</b></center></td>");
        out.print("</tr>");
        out.print("</table>");

      }
      Conn.close();
    %>
  </body>
</html>
