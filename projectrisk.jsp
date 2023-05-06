
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
        String PROJECTID = request.getParameter("PROJECTID");
        String RO = request.getParameter("RO");

        if (RO==null) {
          RO="NO";
        }

        String risk_matrix[][] = new String[6][6];
        risk_matrix[1][5]="O";
        risk_matrix[1][4]="G";
        risk_matrix[1][3]="G";
        risk_matrix[1][2]="G";
        risk_matrix[1][1]="G";
        risk_matrix[2][5]="O";
        risk_matrix[2][4]="O";
        risk_matrix[2][3]="G";
        risk_matrix[2][2]="G";
        risk_matrix[2][1]="G";
        risk_matrix[3][5]="R";
        risk_matrix[3][4]="O";
        risk_matrix[3][3]="O";
        risk_matrix[3][2]="G";
        risk_matrix[3][1]="G";
        risk_matrix[4][5]="R";
        risk_matrix[4][4]="R";
        risk_matrix[4][3]="O";
        risk_matrix[4][2]="O";
        risk_matrix[4][1]="G";
        risk_matrix[5][5]="R";
        risk_matrix[5][4]="R";
        risk_matrix[5][3]="R";
        risk_matrix[5][2]="O";
        risk_matrix[5][1]="O";
      	if (act.equals("RSKADD")) {
          boolean are_date_valid = true;
          try { 
            DateFormat formatter ; 
            Date date ; 
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            date = (Date)formatter.parse(request.getParameter("DATE_DISCOVER")); 
            date = (Date)formatter.parse(request.getParameter("DATE_CLOSING")); 
          } catch (Exception e) { 
            are_date_valid = false; 
          }
          if (!are_date_valid) {
            out.print("<HR>ERROR - DATE INVALID, PLEASE RE-ENTER THE DATA ! <HR>");
          } else {
            int ORD=0;
            Statement st43 = Conn.createStatement();
            String q43 = "SELECT ID FROM PROJECT_RISK WHERE PROJECTID='"+PROJECTID+"' ORDER BY ID DESC";
            ResultSet r43 = st43.executeQuery(q43);
            if (r43.next()) {
              ORD=r43.getInt("ID")+1;
            }
            st43.close();
            String EIDTMP = request.getParameter("EMPLOYEEID");
            String EMPLOYEEID = EIDTMP.substring(0,EIDTMP.indexOf("-")-1);
            Statement sti2 = Conn.createStatement();
            String ESCALATE="N";
            if (request.getParameter("ESCALATE")!=null) {
              ESCALATE = "Y";
            }
            int impact = Integer.parseInt(request.getParameter("IMPACT"));
            int likelihood = Integer.parseInt(request.getParameter("LIKELIHOOD"));
            if (risk_matrix[impact][likelihood].equals("R")) {
              ESCALATE="Y";
            }
            String CLOSED="N";
            if (request.getParameter("CLOSED")!=null) {
              CLOSED = "Y";
            }
            String i2 = "INSERT INTO PROJECT_RISK VALUES('"+PROJECTID+"',"+ORD+",'"+checkstr(request.getParameter("NAME"))+"','"+checkstr(request.getParameter("DESCRIPTION"))+"','"+request.getParameter("DATE_DISCOVER")+"','"+request.getParameter("DATE_CLOSING")+"','"+EMPLOYEEID+"',"+request.getParameter("IMPACT")+","+request.getParameter("LIKELIHOOD")+",'"+ESCALATE+"','"+CLOSED+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        if (act.equals("RSKMOD")) {
          String RISKID=request.getParameter("RISKID");
          boolean are_date_valid = true;
          try { 
            DateFormat formatter ; 
            Date date ; 
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            date = (Date)formatter.parse(request.getParameter("DATE_DISCOVER")); 
            date = (Date)formatter.parse(request.getParameter("DATE_CLOSING")); 
          } catch (Exception e) { 
            are_date_valid = false; 
          }
          if (!are_date_valid) {
            out.print("<HR>ERROR - DATE INVALID, PLEASE RE-ENTER THE DATA ! <HR>");
          } else {
            String EIDTMP = request.getParameter("EMPLOYEEID");
            String EMPLOYEEID = EIDTMP.substring(0,EIDTMP.indexOf("-")-1);
            String ESCALATE="N";
            if (request.getParameter("ESCALATE")!=null) {
              ESCALATE = "Y";
            }
            int impact = Integer.parseInt(request.getParameter("IMPACT"));
            int likelihood = Integer.parseInt(request.getParameter("LIKELIHOOD"));
            if (risk_matrix[impact][likelihood].equals("R")) {
              ESCALATE="Y";
            }
            String CLOSED="N";
            if (request.getParameter("CLOSED")!=null) {
              CLOSED = "Y";
            }
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE PROJECT_RISK SET NAME='"+checkstr(request.getParameter("NAME"))+"',DESCRIPTION='"+checkstr(request.getParameter("DESCRIPTION"))+"',DATE_DISCOVER='"+request.getParameter("DATE_DISCOVER")+"',DATE_CLOSING='"+request.getParameter("DATE_CLOSING")+"',EMPLOYEEID='"+EMPLOYEEID+"',IMPACT="+request.getParameter("IMPACT")+",LIKELIHOOD="+request.getParameter("LIKELIHOOD")+",ESCALATE='"+ESCALATE+"',CLOSED='"+CLOSED+"' WHERE PROJECTID='"+PROJECTID+"' AND ID="+RISKID;
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        if (act.equals("RSKDELETE")) {
          String RISKID = request.getParameter("RISKID");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM PROJECT_RISK WHERE ID="+RISKID+" AND PROJECTID='"+PROJECTID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
          sti2 = Conn.createStatement();
          i2 = "DELETE FROM PROJECT_RISK_ACTION WHERE ID="+RISKID+" AND PROJECTID='"+PROJECTID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/risks.png\"></td><td><strong><h1>Project risk(s)</h1></strong></td></tr></table></center><hr>");
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
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"30\">");
        out.print("<td width=\"30%\" background=\"images/fond.gif\"><center>&nbsp;</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>LOW</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>MEDIUM</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>HIGH</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond.gif\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        out.print("<tr height=\"30\">");
        Statement st40a = Conn.createStatement();
        String q40a = "SELECT PROJECTID,IMPACT,LIKELIHOOD FROM PROJECT_RISK WHERE PROJECTID='"+PROJECTID+"'";
        int nbrlow=0;
        int nbrhigh = 0;
        int nbrcritical = 0;
        ResultSet r40a = st40a.executeQuery(q40a);
        while(r40a.next()) {
          int impact = r40a.getInt("IMPACT");
          int likelihood = r40a.getInt("LIKELIHOOD");
          if (risk_matrix[impact][likelihood].equals("G")) {
            nbrlow++;
          }
          if (risk_matrix[impact][likelihood].equals("O")) {
            nbrhigh++;
          }
          if (risk_matrix[impact][likelihood].equals("R")) {
            nbrcritical++;
          }
        }
        st40a.close();
        out.print("<td background=\"images/fond_titre.jpg\"><center>RISK(S)</center></td>");
        out.print("<td bgcolor=\"#00FF00\"><center><A HREF=\"#\" onclick=\"window.showModalDialog('listprojectrisk.jsp?TODO=NONE&LEVEL=LOW&PROJECTID="+PROJECTID+"','','dialogHeight:400px;dialogWidth:800px;');\">"+nbrlow+"</A></center></td>");
        out.print("<td bgcolor=\"#FF7F3F\"><center><A HREF=\"#\" onclick=\"window.showModalDialog('listprojectrisk.jsp?TODO=NONE&LEVEL=MEDIUM&PROJECTID="+PROJECTID+"','','dialogHeight:400px;dialogWidth:800px;');\">"+nbrhigh+"</center></td>");
        out.print("<td bgcolor=\"#FF0000\"><center><A HREF=\"#\" onclick=\"window.showModalDialog('listprojectrisk.jsp?TODO=NONE&LEVEL=HIGH&PROJECTID="+PROJECTID+"','','dialogHeight:400px;dialogWidth:800px;');\">"+nbrcritical+"</center></td>");
        out.print("<td background=\"images/fond.gif\"><center>&nbsp;</center></td>");
        out.print("</tr>");
        out.print("</table>");
        out.print("<br><hr><table><tr><td><h2><strong>Project risk(s)</strong></h2></center></td>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"addrisk.jsp?TODO=ADD&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        }
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>IMPACT</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>LIKELIHOOD</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>PRIORITY</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>DATE DISCOVERED</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>DATE CLOSED</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>RESPONSIBLE</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>ESCALATE</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>REPONSES</center></td>");
        out.print("<td><center></center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT ID,PROJECTID,NAME,DESCRIPTION,DATE_DISCOVER,DATE_CLOSING,EMPLOYEEID,IMPACT,LIKELIHOOD,ESCALATE,CLOSED FROM PROJECT_RISK WHERE PROJECTID='"+PROJECTID+"' ORDER BY "+COLTOSORT+" "+DIRSORT;
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><table><tr><td>"+r30.getString("NAME")+"</td>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"addrisk.jsp?TODO=MOD&RISKID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/modifysmall.png\"></center></A></td>");
          }
          out.print("</tr></table></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("IMPACT")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("LIKELIHOOD")+"</center></td>");
          int impact = r30.getInt("IMPACT");
          int likelihood = r30.getInt("LIKELIHOOD");
          if (risk_matrix[impact][likelihood].equals("G")) {
            out.print("<td bgcolor=\"#00FF00\"><center>Low</center></td>");
          }
          if (risk_matrix[impact][likelihood].equals("O")) {
            out.print("<td bgcolor=\"#FF7F3F\"><center>Medium</center></td>");
          }
          if (risk_matrix[impact][likelihood].equals("R")) {
            out.print("<td bgcolor=\"#FF0000\"><center>High</center></td>");
          }
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DATE_DISCOVER")+"</center></td>");
          if (r30.getString("CLOSED").equals("Y")) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DATE_CLOSING")+"</center></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>---</center></td>");
          }
          Statement st32 = Conn.createStatement();
          String q32 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID='"+r30.getString("EMPLOYEEID")+"'";
          ResultSet r32 = st32.executeQuery(q32);
          if (r32.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r32.getString("FORNAME")+" "+r32.getString("NAME")+"</center></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>?</center></td>");
          }
          st32.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("ESCALATE")+"</center></td>");
          Statement st38 = Conn.createStatement();
          String q38 = "SELECT ID FROM PROJECT_RISK_ACTION WHERE PROJECTID='"+PROJECTID+"' AND RISKID='"+r30.getString("ID")+"'";
          ResultSet r38 = st38.executeQuery(q38);
          int nbrac = 0;
          while (r38.next()) {
            nbrac++;
          }
          out.print("<td bgcolor=\"#FFFFFF\"><center><table><tr><td>"+nbrac+"</td><td><A HREF=\"riskaction.jsp?TODO=NONE&RISKID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"&RO="+RO+"\"><img border=0 src=\"icons/modifysmall.png\"></center></A></td></tr></table></center></td>");
          st38.close();
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"deleterisk.jsp?TODO=DELETE&RISKID="+r30.getString("ID")+"&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      }

    %>
  </body>
</html>
