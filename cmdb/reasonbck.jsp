
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
body { color: black; font-family: arial; font-size: 12px}
h1 { color: black; font-family: arial; font-size: 18px}

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



<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "javax.mail.*" %>
<%@ page import = "javax.mail.internet.*" %>
<%@ page import = "java.util.*" %> 
<%@ page import="javax.activation.*" %>



<body background="images/comp023.gif">

<%String Userlogin = (String)session.getAttribute("LOGIN");
  Connection Conn = (Connection)session.getAttribute("DBConnection");
  String act = request.getParameter("TODO");
  String MAILSERVER = (String)session.getAttribute("MAILSERVER");
  String THISSERVER = (String)session.getAttribute("THISSERVER");

  if (act.equals("DEF")) {
    Calendar rnb = Calendar.getInstance();
    String TD=(rnb.get(Calendar.MONTH)+1)+"/"+rnb.get(Calendar.DAY_OF_MONTH)+"/"+rnb.get(Calendar.YEAR);
    Statement st60 = Conn.createStatement();
    String q60 = "SELECT * FROM SOFTWARE_DOCUMENTS WHERE FORMIT016='Y' ORDER BY SOFTWAREID ";
    ResultSet r60 = st60.executeQuery(q60);
    while(r60.next()) {
      String DATAGEN=request.getParameter("DATAGEN"+r60.getString("SOFTWAREID"));
      String DATATAPE=request.getParameter("DATATAPE"+r60.getString("SOFTWAREID"));
      Statement st70 = Conn.createStatement();
      String q70 = "SELECT * FROM BACKUP_CHECK WHERE SOFTWAREID='"+r60.getString("SOFTWAREID")+"' AND  BCKDATE='"+TD+"'";
      ResultSet r70 = st70.executeQuery(q70);
      if(r70.next()) {
      Statement sti2 = Conn.createStatement();
      String i2 = "UPDATE BACKUP_CHECK SET DATAGEN='"+DATAGEN+"',DATATAPE='"+DATATAPE+"' WHERE SOFTWAREID='"+r60.getString("SOFTWAREID")+"' AND BCKDATE='"+TD+"'";
      sti2.executeUpdate(i2);
      sti2.close();
      } else {
      Statement sti2 = Conn.createStatement();
      String i2 = "INSERT INTO BACKUP_CHECK VALUES('"+TD+"','"+r60.getString("SOFTWAREID")+"','"+DATAGEN+"','"+DATATAPE+"','NONE','-')";
      sti2.executeUpdate(i2);
      sti2.close();

      }
      st70.close();
    }
    st60.close();
  }

  if (act.equals("ERRORFILL")) {
    out.print("ERROR : You must fill all the REASON fields !!!<hr>");
  }
  out.print("<center><strong><h1>Reason of Backup Error</h1></strong></center><hr>");

   out.print("<form name=\"formFILTER\" method=\"post\" action=\"signdaily.jsp?TODO=STORESIGN\" target=\"appliFrame\">");

  out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#000000\" width=\"100%\">");
  out.print("<tr BGCOLOR=\"#9A9A9A\">");
  out.print("<td background=\"images/fond_titre.jpg\"><center>SOFT #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>SOFT NAME</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>REASON</center></td>"); 
    out.print("</tr>");
    Calendar trnb = Calendar.getInstance();
    String TTD=(trnb.get(Calendar.MONTH)+1)+"/"+trnb.get(Calendar.DAY_OF_MONTH)+"/"+trnb.get(Calendar.YEAR);
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM BACKUP_CHECK WHERE (DATATAPE='N' or DATAGEN='N') AND BCKDATE='"+TTD+"' ORDER BY SOFTWAREID ";
    ResultSet r30 = st30.executeQuery(q30);
    int nbreason=0;
    while(r30.next()) {
      String DATAGEN=request.getParameter("DATAGEN"+r30.getString("SOFTWAREID"));
      String DATATAPE=request.getParameter("DATATAPE"+r30.getString("SOFTWAREID"));
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("SOFTWAREID")+"</center></td>");
      Statement st31 = Conn.createStatement();
      String q31 = "SELECT * FROM SOFTWARE WHERE ID='"+r30.getString("SOFTWAREID")+"'";
      ResultSet r31 = st31.executeQuery(q31);
      if (r31.next()) {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r31.getString("NAME")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></td>");
      }
      st31.close();
      out.print("<td bgcolor=\"#FFFFFF\"><center><textarea name=\"REASON"+r30.getString("SOFTWAREID")+"\" cols=\"80\" rows=\"5\" value=\"\">"+r30.getString("REASON")+"</textarea></center></td>");
      out.print("</tr>");
      nbreason++;
    }
    st30.close();
    out.print("</table>");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Sign\"></center>");
    out.print("</form>");
    if (nbreason==0) {
     out.print("<script language=\"JavaScript\">");
     out.print("top.appliFrame.location='signdaily.jsp?TODO=SIGN';");
      out.print("</script>");
    }
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
