
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
        String PRODUCTID = request.getParameter("PRODUCTID");
        String RISKID = request.getParameter("RISKID");

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
      	if (act.equals("ACTADD")) {
          boolean are_date_valid = true;
          try { 
            DateFormat formatter ; 
            Date date ; 
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            date = (Date)formatter.parse(request.getParameter("DATE_CREATION")); 
            date = (Date)formatter.parse(request.getParameter("DATE_CLOSING")); 
          } catch (Exception e) { 
            are_date_valid = false; 
          }
          if (!are_date_valid) {
            out.print("<HR>ERROR - DATE INVALID, PLEASE RE-ENTER THE DATA ! <HR>");
          } else {
            int ORD=0;
            Statement st43 = Conn.createStatement();
            String q43 = "SELECT ID FROM PRODUCT_RISK_ACTION WHERE PRODUCTID='"+PRODUCTID+"' AND RISKID='"+RISKID+"' ORDER BY ID DESC";
            ResultSet r43 = st43.executeQuery(q43);
            if (r43.next()) {
              ORD=r43.getInt("ID")+1;
            }
            st43.close();
            String EIDTMP = request.getParameter("EMPLOYEEID");
            String EMPLOYEEID = EIDTMP.substring(0,EIDTMP.indexOf("-")-1);
            String CLOSED="N";
            if (request.getParameter("CLOSED")!=null) {
              CLOSED = "Y";
            }
            Statement sti2 = Conn.createStatement();
            String i2 = "INSERT INTO PRODUCT_RISK_ACTION VALUES('"+PRODUCTID+"',"+RISKID+","+ORD+",'"+checkstr(request.getParameter("NAME"))+"','"+checkstr(request.getParameter("DESCRIPTION"))+"','"+request.getParameter("DATE_CREATION")+"','"+request.getParameter("DATE_CLOSING")+"','"+checkstr(request.getParameter("STATUS"))+"','"+EMPLOYEEID+"',"+request.getParameter("IMPACT")+","+request.getParameter("LIKELIHOOD")+",'"+request.getParameter("IMPLEMENT")+"','"+CLOSED+"','"+request.getParameter("STRATEGY")+"')";
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        if (act.equals("ACTMOD")) {
          String ACTIONID=request.getParameter("ACTIONID");
          boolean are_date_valid = true;
          try { 
            DateFormat formatter ; 
            Date date ; 
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            date = (Date)formatter.parse(request.getParameter("DATE_CREATION")); 
            date = (Date)formatter.parse(request.getParameter("DATE_CLOSING")); 
          } catch (Exception e) { 
            are_date_valid = false; 
          }
          if (!are_date_valid) {
            out.print("<HR>ERROR - DATE INVALID, PLEASE RE-ENTER THE DATA ! <HR>");
          } else {
            String EIDTMP = request.getParameter("EMPLOYEEID");
            String EMPLOYEEID = EIDTMP.substring(0,EIDTMP.indexOf("-")-1);
            String CLOSED="N";
            if (request.getParameter("CLOSED")!=null) {
              CLOSED = "Y";
            }
            Statement sti2 = Conn.createStatement();
            String i2 = "UPDATE PRODUCT_RISK_ACTION SET NAME='"+checkstr(request.getParameter("NAME"))+"',DESCRIPTION='"+checkstr(request.getParameter("DESCRIPTION"))+"',DATE_CREATION='"+request.getParameter("DATE_CREATION")+"',DATE_CLOSING='"+request.getParameter("DATE_CLOSING")+"',EMPLOYEEID='"+EMPLOYEEID+"',IMPACT="+request.getParameter("IMPACT")+",LIKELIHOOD="+request.getParameter("LIKELIHOOD")+",STATUS='"+checkstr(request.getParameter("STATUS"))+"',IMPLEMENT='"+request.getParameter("IMPLEMENT")+"',CLOSED='"+CLOSED+"',STRATEGY='"+checkstr(request.getParameter("STRATEGY"))+"' WHERE PRODUCTID='"+PRODUCTID+"' AND RISKID="+RISKID+" AND ID="+ACTIONID;
            sti2.executeUpdate(i2);
            sti2.close();
          }
        }
        if (act.equals("ACTDELETE")) {
          String ACTIONID = request.getParameter("ACTIONID");
          Statement sti2 = Conn.createStatement();
          String i2 = "DELETE FROM PRODUCT_RISK_ACTION WHERE RISKID="+RISKID+" AND PRODUCTID='"+PRODUCTID+"' AND ID="+ACTIONID;
          sti2.executeUpdate(i2);
          sti2.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/risks.png\"></td><td><strong><h1>Response(s) to product risk</h1></strong></td></tr></table></center><hr>");

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
        out.print("<table><tr><td><h2><strong>Product risk</strong></h2></center></td></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>IMPACT</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>LIKELIHOOD</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>PRIORITY</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>DATE DISCOVERED</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>DATE CLOSED</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>RESPONSIBLE</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>ESCALATE</center></td>");
        out.print("<td width=\"10%\">&nbsp;</td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT ID,PRODUCTID,NAME,DESCRIPTION,DATE_DISCOVER,DATE_CLOSING,EMPLOYEEID,IMPACT,LIKELIHOOD,ESCALATE,CLOSED FROM PRODUCT_RISK WHERE PRODUCTID='"+PRODUCTID+"' AND ID="+RISKID;
        ResultSet r30 = st30.executeQuery(q30);
        if(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\">"+r30.getString("NAME")+"</td>");
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
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<br><hr><table><tr><td><h2><strong>Risk response(s)</strong></h2></center></td><td><A HREF=\"addproductaction.jsp?TODO=ADD&PRODUCTID="+PRODUCTID+"&RISKID="+RISKID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>STRATEGY</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>IMPACT</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>LIKELIHOOD</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>PRIORITY</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>DATE DISCOVERED</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>DATE CLOSED</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>RESPONSIBLE</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>STATUS</center></td>");
        out.print("<td width=\"10%\">&nbsp;</td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT ID,PRODUCTID,RISKID,NAME,DESCRIPTION,DATE_CREATION,DATE_CLOSING,EMPLOYEEID,IMPACT,LIKELIHOOD,STATUS,IMPLEMENT,CLOSED,STRATEGY FROM PRODUCT_RISK_ACTION WHERE PRODUCTID='"+PRODUCTID+"' AND RISKID='"+RISKID+"' ORDER BY "+COLTOSORT+" "+DIRSORT;
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("STRATEGY")+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><table><tr><td>"+r30.getString("NAME")+"</td><td><center><A HREF=\"addproductaction.jsp?TODO=MOD&ACTIONID="+r30.getString("ID")+"&PRODUCTID="+PRODUCTID+"&RISKID="+RISKID+"\"><img border=0 src=\"icons/modifysmall.png\"></center></A></td></tr></table></td>");
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
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DATE_CREATION")+"</center></td>");
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
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("STATUS")+"</center></td>");
          out.print("<td><center><A HREF=\"deleteproductaction.jsp?TODO=DELETE&ACTIONID="+r30.getString("ID")+"&PRODUCTID="+PRODUCTID+"&RISKID="+RISKID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"productrisk.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"\">Return</A></center>");
        Conn.close();
      }

    %>
  </body>
</html>
