
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
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>

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
      String TASKID = request.getParameter("TASKID");
      String PROJECTID = request.getParameter("PROJECTID");
      String PROJECTTYPEID = request.getParameter("PROJECTTYPEID");
      String TECHNOLOGYID = request.getParameter("TECHNOLOGYID");

      if (Userlogin==null) {
        out.print("<script language=\"JavaScript\">");
        out.print("top.appliFrame.location='login.jsp?TIMEOUT=TRUE';");
        out.print("</script>");
      } else {
        out.print("<center><strong><h1>Update task</h1></strong></center><hr>");
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectexecutiontask.jsp?TODO=TASKUPDATE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"&TECHNOLOGYID="+TECHNOLOGYID+"&TASKID="+TASKID+"\" target=\"appliFrame\">");
        out.print("<table>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT NBEASY,NBSTANDARD,NBCOMPLEX FROM PROJECT_TECHNOLOGY_TASK WHERE PROJECTID='"+PROJECTID+"' AND TECHNOLOGYID='"+TECHNOLOGYID+"' AND TASKID='"+TASKID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          out.print("<tr><td>Easy actions : </td><td><input name=\"NBEASY\" type=\"text\" size=\"10\" value=\""+R01.getString("NBEASY")+"\"></td></tr>");
          out.print("<tr><td>Standard actions : </td><td><input name=\"NBSTANDARD\" type=\"text\" size=\"10\" value=\""+R01.getString("NBSTANDARD")+"\"></td></tr>");
          out.print("<tr><td>complex actions : </td><td><input name=\"NBCOMPLEX\" type=\"text\" size=\"10\" value=\""+R01.getString("NBCOMPLEX")+"\"></td></tr>");           
        }
        STR01.close();
        out.print("<tr><td>&nbsp;</td><td><input type=\"submit\" name=\"Save\" value=\"Save\">");
        out.print("<input type=button onClick=\"location.href='projectexecutiontask.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"&TECHNOLOGYID="+TECHNOLOGYID+"\" value='Cancel'></td></tr>");
        out.print("</table>");
        out.print("</form>");
      }
      Conn.close();
    %>
  </body>
</html>
