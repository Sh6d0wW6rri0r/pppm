
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

  <%@ page import = "java.sql.*" %>
  <%@ page import = "java.util.*" %>
  <%@ page import = "java.util.Date" %>
  <%@ page import = "java.util.Calendar" %>
  <%@ page import = "java.text.SimpleDateFormat" %>
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
  

      if (Userlogin==null) {
        out.print("<script language=\"JavaScript\">");
        out.print("top.appliFrame.location='login.jsp?TIMEOUT=TRUE';");
        out.print("</script>");
      } else {
        if (act.equals("SAVEIT")) {
            String PROJECTID = request.getParameter("PROJECTID");
            String projecttypeidtmp = request.getParameter("PROJECTTYPEID");
            String PROJECTTYPEID = projecttypeidtmp.substring(0,projecttypeidtmp.indexOf("-")-1);
            String projectstructureidtmp = request.getParameter("PROJECTSTRUCTUREID");
            String PROJECTSTRUCTUREID = projectstructureidtmp.substring(0,projectstructureidtmp.indexOf("-")-1);
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE PROJECT SET PROJECTTYPEID='"+PROJECTTYPEID+"',PROJECTSTRUCTUREID='"+PROJECTSTRUCTUREID+"' WHERE ID='"+request.getParameter("PROJECTID")+"'";
            sti2.executeUpdate(i2);
            sti2.close();
        }
        out.print("<center><strong><h1>Your project portfolio</h1></strong></center><hr>");
        out.print("<table><tr><td>You are here : Projects \\ My Project Portfolio </td><td><A HREF=\"portfolio.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Project(s)</strong></h2></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"16%\"><center>Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Methodology</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Type</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Overview</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Planning</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Execution</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Deployment</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Close</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>Feedback</center></td>");
        out.print("</tr>");
        Statement STR16 = Conn.createStatement();
        String QR16 = "SELECT * FROM PROJECT WHERE PM='"+Userlogin+"'";
        ResultSet R16 = STR16.executeQuery(QR16);
        while(R16.next()) {
          out.print("<tr>");     
          out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectdetails.jsp?TODO=NONE&PROJECTID="+R16.getString("ID")+"\">&nbsp;"+R16.getString("NAME")+"</A></center></td>");
 
          Statement STR16B = Conn.createStatement();
          String QR16B = "SELECT * FROM PROJECT_STRUCTURE WHERE ID='"+R16.getString("PROJECTSTRUCTUREID")+"'";
          ResultSet R16B = STR16B.executeQuery(QR16B);
          if (R16B.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+R16B.getString("NAME")+"</center></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;NOT DEFINED</center></td>");
          }
          STR16B.close();
          Statement STR16C = Conn.createStatement();
          String QR16C = "SELECT * FROM PROJECT_TYPE WHERE ID='"+R16.getString("PROJECTTYPEID")+"'";
          ResultSet R16C = STR16C.executeQuery(QR16C);
          if (R16C.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+R16C.getString("NAME")+"</center></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;NOT DEFINED</center></td>");
          }
          STR16C.close();
          if (R16.getString("PROJECTTYPEID").equals("NONE") || R16.getString("PROJECTSTRUCTUREID").equals("NONE")) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>"); 
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>"); 
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectoverview.jsp?TODO=NONE&PROJECTID="+R16.getString("ID")+"&PROJECTTYPEID="+R16.getString("PROJECTTYPEID")+"\"><img border=0 src=\"icons/report.png\"></A></center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectplanning.jsp?TODO=NONE&PROJECTID="+R16.getString("ID")+"&PROJECTTYPEID="+R16.getString("PROJECTTYPEID")+"\"><img border=0 src=\"icons/planning.png\"></A></center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectexecution.jsp?TODO=NONE&PROJECTID="+R16.getString("ID")+"&PROJECTTYPEID="+R16.getString("PROJECTTYPEID")+"\"><img border=0 src=\"icons/configure.png\"></A></center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectdeployment.jsp?TODO=NONE&PROJECTID="+R16.getString("ID")+"&PROJECTTYPEID="+R16.getString("PROJECTTYPEID")+"\"><img border=0 src=\"icons/organization.png\"></A></center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectclose.jsp?TODO=NONE&PROJECTID="+R16.getString("ID")+"&PROJECTTYPEID="+R16.getString("PROJECTTYPEID")+"\"><img border=0 src=\"icons/yes.png\"></A></center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"projectfeedback.jsp?TODO=NONE&PROJECTID="+R16.getString("ID")+"&PROJECTTYPEID="+R16.getString("PROJECTTYPEID")+"\"><img border=0 src=\"icons/request.png\"></A></center></td>");
          }
          out.print("</tr>");
        }
        STR16.close();
        out.print("</table>");


      } 
      Conn.close();
    %>
  </body>
</html>
