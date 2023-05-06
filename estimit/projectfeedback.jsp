
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
        out.print("<center><table><tr><td><img border=0 src=\"icons/request.png\"></td><td><strong><h1>Project feedback</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Projects \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\"> My Project Portfolio</A> \\ Project feedback<td><A HREF=\"projectfeedback.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        int PL_EASY_HOURS = 0;
        int PL_STANDARD_HOURS=0;
        int PL_COMPLEX_HOURS=0;
        int PL_PM_HOURS=0;
        int PL_QA_HOURS=0;
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"portfolio.jsp?TODO=SAVEFEEDBACK&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\" target=\"appliFrame\">");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT EASY_HOURS,STANDARD_HOURS,COMPLEX_HOURS FROM PROJECT_PLANNING_FEEDBACK WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          PL_EASY_HOURS=R01.getInt("EASY_HOURS");
          PL_STANDARD_HOURS=R01.getInt("STANDARD_HOURS");
          PL_COMPLEX_HOURS=R01.getInt("COMPLEX_HOURS");
        }
        STR01.close();
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT HOURS FROM PROJECT_MANAGEMENT_FEEDBACK WHERE PROJECTID='"+PROJECTID+"' AND IDRATIO='PL-PM'";
        ResultSet R02 = STR02.executeQuery(QR02);
        if (R02.next()) {
          PL_PM_HOURS=R02.getInt("HOURS");
        }
        STR02.close();
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT HOURS FROM PROJECT_MANAGEMENT_FEEDBACK WHERE PROJECTID='"+PROJECTID+"' AND IDRATIO='PL-QA'";
        ResultSet R03 = STR03.executeQuery(QR03);
        if (R03.next()) {
          PL_QA_HOURS=R03.getInt("HOURS");
        }
        STR03.close();

        out.print("<table><tr><td><h1><strong>Planning phase feedback</strong></h1></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Easy hours</center></b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Standard hours</b></center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Complex hours</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Planning tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"PL_EASY_HOURS\" type=\"text\" size=\"10\" value=\""+PL_EASY_HOURS+"\"></center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"PL_STANDARD_HOURS\" type=\"text\" size=\"10\" value=\""+PL_STANDARD_HOURS+"\"></center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"PL_COMPLEX_HOURS\" type=\"text\" size=\"10\" value=\""+PL_COMPLEX_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Project Management tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center><input name=\"PL_PM_HOURS\" type=\"text\" size=\"10\" value=\""+PL_PM_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Quality Assurance tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center><input name=\"PL_QA_HOURS\" type=\"text\" size=\"10\" value=\""+PL_QA_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("</table>");

        int DEV_HOURS = 0;
        int TESTING_HOURS=0;
        int EX_PM_HOURS=0;
        int EX_QA_HOURS=0;
        Statement STR01b = Conn.createStatement();
        String QR01b = "SELECT DEV_HOURS,TESTING_HOURS FROM PROJECT_EXECUTION_FEEDBACK WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R01b = STR01b.executeQuery(QR01b);
        if (R01b.next()) {
          DEV_HOURS=R01b.getInt("DEV_HOURS");
          TESTING_HOURS=R01b.getInt("TESTING_HOURS");
        }
        STR01b.close();
        Statement STR02b = Conn.createStatement();
        String QR02b = "SELECT HOURS FROM PROJECT_MANAGEMENT_FEEDBACK WHERE PROJECTID='"+PROJECTID+"' AND IDRATIO='EX-PM'";
        ResultSet R02b = STR02b.executeQuery(QR02b);
        if (R02b.next()) {
          PL_PM_HOURS=R02b.getInt("HOURS");
        }
        STR02b.close();
        Statement STR03b = Conn.createStatement();
        String QR03b = "SELECT HOURS FROM PROJECT_MANAGEMENT_FEEDBACK WHERE PROJECTID='"+PROJECTID+"' AND IDRATIO='EX-QA'";
        ResultSet R03b = STR03b.executeQuery(QR03b);
        if (R03b.next()) {
          PL_QA_HOURS=R03b.getInt("HOURS");
        }
        STR03b.close();

        out.print("<table><tr><td><h1><strong>Execution phase feedback</strong></h1></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Development hours</center></b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Testing hours</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Execution tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"DEV_HOURS\" type=\"text\" size=\"10\" value=\""+DEV_HOURS+"\"></center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"TESTING_HOURS\" type=\"text\" size=\"10\" value=\""+TESTING_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Project Management tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center><input name=\"EX_PM_HOURS\" type=\"text\" size=\"10\" value=\""+EX_PM_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Quality Assurance tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center><input name=\"EX_QA_HOURS\" type=\"text\" size=\"10\" value=\""+EX_QA_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("</table>");

        int DEPL_HOURS=0;
        int TRAIN_HOURS=0;
        int DP_PM_HOURS=0;
        int DP_QA_HOURS=0;
        Statement STR01c = Conn.createStatement();
        String QR01c = "SELECT HOURS FROM PROJECT_DEPL_FEEDBACK WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R01c = STR01c.executeQuery(QR01c);
        if (R01c.next()) {
          DEPL_HOURS=R01c.getInt("HOURS");
        }
        STR01c.close();
        Statement STR01d = Conn.createStatement();
        String QR01d = "SELECT HOURS FROM PROJECT_TRAIN_FEEDBACK WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R01d = STR01d.executeQuery(QR01d);
        if (R01d.next()) {
          TRAIN_HOURS=R01d.getInt("HOURS");
        }
        STR01d.close();
        Statement STR02c = Conn.createStatement();
        String QR02c = "SELECT HOURS FROM PROJECT_MANAGEMENT_FEEDBACK WHERE PROJECTID='"+PROJECTID+"' AND IDRATIO='DP-PM'";
        ResultSet R02c = STR02c.executeQuery(QR02c);
        if (R02c.next()) {
          DP_PM_HOURS=R02c.getInt("HOURS");
        }
        STR02c.close();
        Statement STR03c = Conn.createStatement();
        String QR03c = "SELECT HOURS FROM PROJECT_MANAGEMENT_FEEDBACK WHERE PROJECTID='"+PROJECTID+"' AND IDRATIO='DP-QA'";
        ResultSet R03c = STR03c.executeQuery(QR03c);
        if (R03c.next()) {
          DP_QA_HOURS=R03c.getInt("HOURS");
        }
        STR03c.close();

        out.print("<table><tr><td><h1><strong>Deployment phase feedback</strong></h1></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Deployment hours</center></b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Training hours</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Deployment tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"DEPL_HOURS\" type=\"text\" size=\"10\" value=\""+DEPL_HOURS+"\"></center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><input name=\"TRAIN_HOURS\" type=\"text\" size=\"10\" value=\""+TRAIN_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Project Management tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center><input name=\"DP_PM_HOURS\" type=\"text\" size=\"10\" value=\""+DP_PM_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Quality Assurance tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center><input name=\"DP_QA_HOURS\" type=\"text\" size=\"10\" value=\""+DP_QA_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("</table>");

        int CL_PM_HOURS=0;
        int CL_QA_HOURS=0;
        Statement STR02d = Conn.createStatement();
        String QR02d = "SELECT HOURS FROM PROJECT_MANAGEMENT_FEEDBACK WHERE PROJECTID='"+PROJECTID+"' AND IDRATIO='DP-PM'";
        ResultSet R02d = STR02d.executeQuery(QR02d);
        if (R02d.next()) {
          CL_PM_HOURS=R02d.getInt("HOURS");
        }
        STR02d.close();
        Statement STR03d = Conn.createStatement();
        String QR03d = "SELECT HOURS FROM PROJECT_MANAGEMENT_FEEDBACK WHERE PROJECTID='"+PROJECTID+"' AND IDRATIO='DP-QA'";
        ResultSet R03d = STR03d.executeQuery(QR03d);
        if (R03d.next()) {
          CL_QA_HOURS=R03d.getInt("HOURS");
        }
        STR03d.close();

        out.print("<table><tr><td><h1><strong>Close phase feedback</strong></h1></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Hours</center></b></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Project Management tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center><input name=\"CL_PM_HOURS\" type=\"text\" size=\"10\" value=\""+CL_PM_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Hours spent on Quality Assurance tasks</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center><input name=\"CL_QA_HOURS\" type=\"text\" size=\"10\" value=\""+CL_QA_HOURS+"\"></center></td>");
        out.print("</tr>");
        out.print("</table>");

        out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/approve.png\" type=image Value=submit></td>");
        out.print("</tr></table>");
        out.print("</form>");
        out.print("<hr>");

      }
      Conn.close();
    %>
  </body>
</html>
