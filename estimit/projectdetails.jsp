
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
      if (Userlogin==null) {
        out.print("<script language=\"JavaScript\">");
        out.print("top.appliFrame.location='login.jsp?TIMEOUT=TRUE';");
        out.print("</script>");
      } else {
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Project Details</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Projects \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\"> My Project Portfolio</A> \\ Project Details<td><A HREF=\"projectdetails.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        String NAME = "";
        String DESCRIPTION = "";
        String PROJECTTYPEID = "";
        String PROJECTSTRUCTUREID = "";
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"portfolio.jsp?TODO=SAVEIT&PROJECTID="+PROJECTID+"\" target=\"appliFrame\">");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME,DESCRIPTION,PROJECTTYPEID,PROJECTSTRUCTUREID FROM PROJECT WHERE ID='"+PROJECTID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          NAME=R01.getString("NAME");
          DESCRIPTION=R01.getString("DESCRIPTION");
          PROJECTTYPEID=R01.getString("PROJECTTYPEID");
          PROJECTSTRUCTUREID=R01.getString("PROJECTSTRUCTUREID");
        }
        STR01.close();
        out.print("<table>");
        out.print("<tr><td>Project name : </td><td>&nbsp"+NAME+"</td></tr>");
        out.print("<tr><td>Description : </td><td>&nbsp"+DESCRIPTION+"</td></tr>");
        out.print("<tr><td>Project Type : </td><td><select name=\"PROJECTTYPEID\">");
        out.print("<option>NONE - NOT SELECTED</option>");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT ID,NAME FROM PROJECT_TYPE ORDER BY ID";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<option");
          if (PROJECTTYPEID.equals(R02.getString("ID"))) {
            out.print(" selected ");
          }
          out.print(">"+R02.getString("ID")+" - "+R02.getString("NAME")+"</option>");
        }
        STR02.close();
        out.print("</select></td></tr>");
        out.print("<tr><td>Project Methodology : </td><td><select name=\"PROJECTSTRUCTUREID\">");
        out.print("<option>NONE - NOT SELECTED</option>");
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT ID,NAME FROM PROJECT_STRUCTURE ORDER BY ID";
        ResultSet R03 = STR03.executeQuery(QR03);
        while(R03.next()) {
          out.print("<option");
          if (PROJECTSTRUCTUREID.equals(R03.getString("ID"))) {
            out.print(" selected ");
          }
          out.print(">"+R03.getString("ID")+" - "+R03.getString("NAME")+"</option>");
        }
        STR03.close();
        out.print("</select></td></tr>");
        out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
        out.print("<td><A HREF=\"portfolio.jsp?TODO=NONE\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        out.print("</table>");
        out.print("</form>");

      }
      Conn.close();
    %>
  </body>
</html>
