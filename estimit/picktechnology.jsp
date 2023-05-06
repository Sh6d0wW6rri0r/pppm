
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
      String PROJECTID = request.getParameter("PROJECTID");
      
      String PROJECTTYPEID = request.getParameter("PROJECTTYPEID");
      String ptmp = request.getParameter("PAGE");

      
      int PAGE=0;
      
      if (ptmp==null) {
        
        PAGE=0;
      
      } else {
        
        PAGE=Integer.parseInt(ptmp);

      }
      if (Userlogin==null) {
        out.print("<script language=\"JavaScript\">");
        out.print("top.appliFrame.location='login.jsp?TIMEOUT=TRUE';");
        out.print("</script>");
      } else {
        out.print("<center><strong><h1>Resource</h1></strong></center><hr>");
        out.print("You are here : Portfolio \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\"> Projects</A> \\ <A HREF=\"projectexecution.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\" target=\"appliFrame\">Project execution</A> \\ Add technology");
        out.print("<hr>");       
        out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
        out.print("<tr><td bgcolor=#FFFFFF>");
        int nbpage=0;
        
        Statement st230 = Conn.createStatement();
        String q230 = "SELECT COUNT(ID) FROM TECHNOLOGY WHERE ID NOT IN (SELECT TECHNOLOGYID FROM PROJECT_TECHNOLOGY WHERE PROJECTID='"+PROJECTID+"')";
        ResultSet r230 = st230.executeQuery(q230);
        if (r230.next()) {    
          nbpage=r230.getInt("COUNT(ID)")/20;
        }
        st230.close();
        String NAME = "";
        out.print("<table><tr><td>Page : </td>");
        for (int i=0; i<=nbpage;i++) {
          out.print("<td><A HREF=\"picktechnology.jsp?TODO=ADD&PAGE="+i+"&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\">"+i+"</A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
  
        out.print("<td width=\"5%\">&nbsp;</td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>ID</center></td>");

        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");

        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Description</center></td>");

        out.print("<td width=\"5%\">&nbsp;</td>");

        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT ID,NAME,DESCRIPTION FROM TECHNOLOGY WHERE ID NOT IN (SELECT TECHNOLOGYID FROM PROJECT_TECHNOLOGY WHERE PROJECTID='"+PROJECTID+"')";
        ResultSet R01 = STR01.executeQuery(QR01);
  
        int pagecount=0;
        while(R01.next()) {

          if (pagecount>=PAGE*20 && pagecount<(PAGE+1)*20) {
            out.print("<tr>");

            out.print("<td>&nbsp;</td>");

            out.print("<td bgcolor=\"#FFFFFF\"><A HREF=\"projectexecution.jsp?TODO=TECHADD&TECHNOLOGYID="+R01.getString("ID")+"&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\">"+R01.getString("ID")+"</td>");

            out.print("<td bgcolor=\"#FFFFFF\">"+R01.getString("NAME")+"</td>");
            out.print("<td bgcolor=\"#FFFFFF\">"+R01.getString("DESCRIPTION")+"</td>");
            out.print("<td>&nbsp;</td>");

            out.print("</tr>");
          }
        }
        STR01.close();
        out.print("</table>");
        out.print("<A HREF=\"projectexecution.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\"><img border=0 src=\"icons/cancel.png\"></A>");
      }
      Conn.close();
    %>
  </body>
</html>
