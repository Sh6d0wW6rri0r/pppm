
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
      String TECHNOLOGYID = request.getParameter("TECHNOLOGYID");
 
  

      if (Userlogin==null) {
        out.print("<script language=\"JavaScript\">");
        out.print("top.appliFrame.location='login.jsp?TIMEOUT=TRUE';");
        out.print("</script>");
      } else {
        if (act.equals("TASKADD")) {
          String TASKID = request.getParameter("TASKID");
          Statement sti2 = Conn.createStatement();
          String i2 = "INSERT INTO PROJECT_TECHNOLOGY_TASK VALUES ('"+PROJECTID+"','"+TECHNOLOGYID+"','"+TASKID+"',0,0,0)";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("TASKUPDATE")) {
          String TASKID = request.getParameter("TASKID");
          String NBEASY = request.getParameter("NBEASY");
          String NBSTANDARD = request.getParameter("NBSTANDARD");
          String NBCOMPLEX = request.getParameter("NBCOMPLEX");

          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE PROJECT_TECHNOLOGY_TASK SET NBEASY="+NBEASY+",NBSTANDARD="+NBSTANDARD+",NBCOMPLEX="+NBCOMPLEX+" WHERE PROJECTID='"+PROJECTID+"' AND TECHNOLOGYID='"+TECHNOLOGYID+"' AND TASKID='"+TASKID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        if (act.equals("TASKDELETE")) {
          String TASKID = request.getParameter("TASKID");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM PROJECT_TECHNOLOGY WHERE TECHNOLOGYID='"+TECHNOLOGYID+"' AND PROJECTID='"+PROJECTID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
          sti2 = Conn.createStatement();
          i2 = "DELETE FROM PROJECT_TECHNOLOGY_TASK WHERE TECHNOLOGYID='"+TECHNOLOGYID+"' AND PROJECTID='"+PROJECTID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/configure.png\"></td><td><strong><h1>Project Execution phase - "+TECHNOLOGYID+"</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Projects \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\"> My Project Portfolio</A> \\ <A HREF=\"projectexecution.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\">Project execution</A> \\ Project Executions tasks </td><td><A HREF=\"projectexecutiontask.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"&TECHNOLOGYID="+TECHNOLOGYID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Project Execution Technology tasks</strong></h2></center></td>");

        out.print("<td><A HREF=\"picktask.jsp?TODO=ADD&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"&TECHNOLOGYID="+TECHNOLOGYID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
 
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>Description</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center># of easy</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center># of standard</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center># of complex</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT TASKID,NBEASY,NBSTANDARD,NBCOMPLEX FROM PROJECT_TECHNOLOGY_TASK WHERE PROJECTID='"+PROJECTID+"' AND TECHNOLOGYID='"+TECHNOLOGYID+"'";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          Statement st31 = Conn.createStatement();
          String q31 = "SELECT NAME,DESCRIPTION FROM TECHNOLOGY_TASK_RATIO WHERE TASKID='"+r30.getString("TASKID")+"' AND TECHNOLOGYID='"+TECHNOLOGYID+"'";
          ResultSet r31 = st31.executeQuery(q31);
          if(r31.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"updatetask.jsp?TODO=MOD&TASKID="+r30.getString("TASKID")+"&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"&TECHNOLOGYID="+TECHNOLOGYID+"\">"+r31.getString("NAME")+"</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("DESCRIPTION")+"</center></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"updatetask.jsp?TODO=MOD&TASKID="+r30.getString("TASKID")+"&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"&TECHNOLOGYID="+TECHNOLOGYID+"\">-</center></A></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
          }
          st31.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("NBEASY")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("NBSTANDARD")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getInt("NBCOMPLEX")+"</center></td>");
          out.print("<td><center><A HREF=\"deletetask.jsp?TODO=DELETE&TASKID="+r30.getString("TASKID")+"&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"&TECHNOLOGYID="+TECHNOLOGYID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");

          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
      }
      Conn.close();
    %>
  </body>
</html>
