
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
  body { color: black; font-family: arial; font-size: 11px}
  h1 { color: black; font-family: arial; font-size: 16px}
</style> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.navbar {
    overflow: hidden;
    background-color: #333;
    font-family: Arial;
}

.navbar a {
    float: left;
    font-size: 16px;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

.dropdown {
    float: left;
    overflow: hidden;
}

.dropdown .dropbtn {
    cursor: pointer;
    font-size: 16px;    
    border: none;
    outline: none;
    color: white;
    padding: 14px 16px;
    background-color: inherit;
}

.navbar a:hover, .dropdown:hover .dropbtn {
    background-color: red;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    float: none;
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}

.dropdown-content a:hover {
    background-color: #ddd;
}

.show {
    display: block;
}
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
  <%@ page import = "fr.pppm.*" %>


  <body bgcolor="#FFFFFF">
    <script>
    function showModalADD()
    {
    	window.showModalDialog('addrequest.jsp?TODO=ADD','','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='request.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalAPPROVE(reqstr)
    {
    	window.showModalDialog('approverequest.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='request.jsp?TODO=NONE';
    }
    </script>
    <script>
    function showModalPROJECTDETAILS(reqstr)
    {
    	window.showModalDialog('requestdetails.jsp?TODO=MOD&'+reqstr,'','dialogHeight:400px;dialogWidth:800px;');
        top.appliFrame.location='request.jsp?TODO=NONE';
    }
    </script>

<jsp:include page="mainmenu.jsp" />
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
                PPPMTools pt = new PPPMTools(); 
              	out.print("<center><strong><h1>Project requests</h1></strong></center><br>");
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
                out.print("<form name=\"formFILTER\" method=\"post\" action=\"request.jsp?TODO=FILTER&FILTER=FILTER\" target=\"appliFrame\">");
                PPMFilter filterengine = new PPMFilter(Conn);
                String LASTFILTERLOCATION=filterengine.getFilterValue("LASTFILTERLOCATIONPORTFOLIO",Userlogin);
                String LASTFILTERDIVISION=filterengine.getFilterValue("LASTFILTERDIVISIONPORTFOLIO",Userlogin);
                String LASTFILTERBPO=filterengine.getFilterValue("LASTFILTERBPOPORTFOLIO",Userlogin);
                String LASTFILTERSI=filterengine.getFilterValue("LASTFILTERSIPORTFOLIO",Userlogin);
                String filter = request.getParameter("FILTER");
                String filterstatement ="";
                String filstrlocation=request.getParameter("SELECTFILTERLOCATION");
                String filstrdivision=request.getParameter("SELECTFILTERDIVISION");
                String filstrBPO=request.getParameter("SELECTFILTERBPO");
                String filstrPM=request.getParameter("SELECTFILTERPM");
                String filstrSI=request.getParameter("SELECTFILTERSI");
                String filstrAT=request.getParameter("SELECTFILTERAT");
                String filstrIT=request.getParameter("SELECTFILTERIT");
                if (filstrlocation==null) {
                  if (LASTFILTERLOCATION!=null) {
                    filter="FILTER";
                    filstrlocation=LASTFILTERLOCATION;
                  } else {
                    filter=null;
                    filstrlocation="*** - ALL";
                  }
                } else {
                    filterengine.setFilterValue("LASTFILTERLOCATIONPORTFOLIO",Userlogin,filstrlocation);          
                }
                if (filstrdivision==null) {
                  if (LASTFILTERDIVISION!=null) {
                    filter="FILTER";
                    filstrdivision=LASTFILTERDIVISION;
                  } else {
                    filter=null;
                    filstrdivision="*** - ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERDIVISIONPORTFOLIO",Userlogin,filstrdivision);
                }
                if (filstrBPO==null) {
                  if (LASTFILTERBPO!=null) {
                    filter="FILTER";
                    filstrBPO=LASTFILTERBPO;
                  } else {
                    filter=null;
                    filstrBPO="*** - ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERBPOPORTFOLIO",Userlogin,filstrBPO);      
                }
                if (filstrSI==null) {
                  if (LASTFILTERSI!=null) {
                    filter="FILTER";
                    filstrSI=LASTFILTERSI;
                  } else {
                    filter=null;
                    filstrSI="ALL";
                  }
                } else {
                  filterengine.setFilterValue("LASTFILTERSIPORTFOLIO",Userlogin,filstrSI);
                }
                out.print("<table border=\"1\" CELLSPACING=\"0\" BORDERCOLOR=\"#9F9F9F\" width=\"100%\">");
                out.print("<tr><td bgcolor=#FFFFFF>");
                out.print("<table width=\"100%\"><tr>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Filter by Location : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERLOCATION\">");
                out.print("<option>*** - ALL</option>");
                Statement st20 = Conn.createStatement();
                String q20 = "SELECT ID,NAME FROM LOCATION ORDER BY NAME";
                ResultSet r20 = st20.executeQuery(q20);
                while(r20.next()) {
                  out.print("<option");
                  if (filstrlocation.equals(r20.getString("ID")+" - "+r20.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+r20.getString("ID")+" - "+r20.getString("NAME")+"</option>");
                }
                st20.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Division : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERDIVISION\">");
                out.print("<option>*** - ALL</option>");
                Statement st21 = Conn.createStatement();
                String q21 = "SELECT ID,NAME FROM DIVISION ORDER BY NAME";
                ResultSet r21 = st21.executeQuery(q21);
                while(r21.next()) {
                  out.print("<option");
                  if (filstrdivision.equals(r21.getString("ID")+" - "+r21.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+r21.getString("ID")+" - "+r21.getString("NAME")+"</option>");
                }
                st21.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("BPO/Product Owner : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERBPO\">");
                out.print("<option>*** - ALL</option>");
                Statement st22 = Conn.createStatement();
                String q22 = "SELECT ID,NAME,FORNAME FROM EMPLOYEE WHERE ID IN (select EMPLOYEEID FROM PRJBPO)  ORDER BY NAME,FORNAME";
                ResultSet r22 = st22.executeQuery(q22);
                while(r22.next()) {
                  out.print("<option");
                  if (filstrBPO.equals(r22.getString("ID")+" - "+r22.getString("NAME")+" "+r22.getString("FORNAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+r22.getString("ID")+" - "+r22.getString("NAME")+" "+r22.getString("FORNAME")+"</option>");
                }
                st22.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("Strategic initiative : </td><td bgcolor=#FFFFFF><select name=\"SELECTFILTERSI\">");
                out.print("<option>*** - ALL</option>");
                Statement st24 = Conn.createStatement();
                String q24 = "SELECT ID,NAME FROM STRATEGICINITIATIVE ORDER BY NAME";
                ResultSet r24 = st24.executeQuery(q24);
                while(r24.next()) {
                  out.print("<option");
                  if (filstrSI.equals(r24.getString("ID")+" - "+r24.getString("NAME"))) {
                    out.print(" selected ");
                  }
                  out.print(">"+r24.getString("ID")+" - "+r24.getString("NAME")+"</option>");
                }
                st24.close();
                out.print("</select>");
                out.print("</td>");
                out.print("<td bgcolor=#FFFFFF>");
                out.print("<input type=\"image\" border=0 src=\"icons/search.png\" name=\"filter\" value=\"submit\"></center>");
                out.print("</td>");
                out.print("</tr></table>");
                out.print("</td>");
                out.print("</tr></table>");
                out.print("<br>");
                out.print("</form>");
                boolean first=true;
                if (filter!= null) {
                  String idfillocation = filstrlocation.substring(0,filstrlocation.indexOf("-")-1);
                  if (!idfillocation.equals("***")) {
                    filterstatement = " WHERE " ;
                    filterstatement = filterstatement + " ID in (SELECT PROJECTID FROM PRJLOC WHERE LOCATIONID='"+idfillocation+"')";
                    first = false;
                  }
                  String idfildivision = filstrdivision.substring(0,filstrdivision.indexOf("-")-1);
                  if (!idfildivision.equals("***")) {
                    if (!first) {
                      filterstatement = filterstatement + " AND ";
                    } else {
                      filterstatement = " WHERE " ;
                    }
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJDIV WHERE DIVISIONID='"+idfildivision+"')";
                    first = false;
                  }
                  String idfilBPO = filstrBPO.substring(0,filstrBPO.indexOf("-")-1);
                  if (!idfilBPO.equals("***")) {
                    if (!first) {
                      filterstatement = filterstatement + " AND ";
                    } else {
                      filterstatement = " WHERE " ;
                    }
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJBPO WHERE EMPLOYEEID='"+idfilBPO+"')";
                    first = false;
                  }
                  String idfilSI = filstrSI.substring(0,filstrSI.indexOf("-")-1);
                  if (!idfilSI.equals("***")) {
                    if (!first) {
                      filterstatement = filterstatement + " AND ";
                    } else {
                      filterstatement = " WHERE " ;
                    }
                    filterstatement = filterstatement + "ID in (SELECT PROJECTID FROM PRJSI WHERE SIID='"+idfilSI+"')";
                    first = false;
                  }
                }
                if (!first) {
                  filterstatement = filterstatement + " AND ";
                } else {
                  filterstatement = " WHERE " ;
                }
                filterstatement = filterstatement + " STATUS='REQUEST'";
                out.print("<tr><td><h2><strong>Project request(s)</strong></h2></center></td></tr></table>");
                out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
                out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"20\">");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"40%\"><center><A HREF=\"request.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Attributes</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Score</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>START</td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>END</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>TRANSFORM</center></td>");
                out.print("</tr>");
                Statement st30 = Conn.createStatement();
                String q30 = "SELECT * FROM PROJECT "+filterstatement+" ORDER BY "+COLTOSORT+" "+DIRSORT;
                ResultSet r30 = st30.executeQuery(q30);
                while(r30.next()) {
                  out.print("<tr height=15>");
                  if (r30.getString("NAME").equals("")) {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
                  } else {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r30.getString("NAME")+"</center></td>");
                  }
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalPROJECTDETAILS('PROJECTID="+r30.getString("ID")+"');\"><img border=0 src=\"icons/attributes.png\" height=15></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("SCORE")+"</center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r30.getString("DATE_START")+"</center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r30.getString("DATE_END")+"</center></td>");
                  Statement st330 = Conn.createStatement();
                  String q330 = "SELECT COUNT(DIVISIONID) FROM PRJDIV WHERE PROJECTID='"+r30.getString("ID")+"'";
                  ResultSet r330 = st330.executeQuery(q330);
                  boolean islocal = true;
                  if (r330.next()) {
                    if (r330.getInt("COUNT(DIVISIONID)")>1) {
                      islocal=false;
                    }
                  }
                  st330.close();
                  boolean cantransform=false;
                  if (islocal) {
                    Statement st331 = Conn.createStatement();
                    String q331 = "SELECT COUNT(BITLID) FROM LOCATION WHERE BITLID='"+Userlogin+"' AND ID IN (SELECT LOCATIONID FROM PRJLOC WHERE PROJECTID='"+r30.getString("ID")+"')";
                    ResultSet r331 = st331.executeQuery(q331);
                    if (r331.next()) {
                      if (r331.getInt("COUNT(BITLID)")>0) {
                        cantransform=true;
                      }
                    }
                    st331.close();
                  }
                  Statement st131 = Conn.createStatement();
                  String q131 = "SELECT COUNT(USERRIGHT) FROM USER_RIGHT WHERE LOGIN='"+Userlogin+"' AND USERRIGHT='REQAPP'";
                  ResultSet r131 = st131.executeQuery(q131);
                  if (r131.next()) {
                    if (r131.getInt("COUNT(USERRIGHT)")>0) {
                      cantransform=true;
                    }
                  }
                  st131.close();
                  if (cantransform) {
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalAPPROVE('PROJECTID="+r30.getString("ID")+"&REQTYPE=PROJECT');\"><img border=0 src=\"icons/approve.png\" height=15></A></center></td>");
                  } else {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>---</center></td>");
                  }
                  out.print("</tr>");
                }
                st30.close();
                out.print("</table>");
                out.print("<table><tr><td><h2><strong>Product request(s)</strong></h2></center></td></tr></table>");
                out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
                out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"20\">");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"40%\"><center><A HREF=\"request.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Attributes</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Score</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>START</td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>END</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>TRANSFORM</center></td>");
                out.print("</tr>");
                Statement st130 = Conn.createStatement();
                String q130 = "SELECT * FROM PRODUCT "+filterstatement+" ORDER BY "+COLTOSORT+" "+DIRSORT;
                ResultSet r130 = st130.executeQuery(q130);
                while(r130.next()) {
                  out.print("<tr height=15>");
                  if (r130.getString("NAME").equals("")) {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
                  } else {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r130.getString("NAME")+"</center></td>");
                  }
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"requestproductdetails.jsp?TODO=MOD&PRODUCTID="+r130.getString("ID")+"\"><img border=0 src=\"icons/attributes.png\" height=15></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>"+r130.getString("SCORE")+"</center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r130.getString("DATE_START")+"</center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r130.getString("DATE_END")+"</center></td>");
                  boolean cantransform = false;
                  Statement st1131 = Conn.createStatement();
                  String q1131 = "SELECT COUNT(USERRIGHT) FROM USER_RIGHT WHERE LOGIN='"+Userlogin+"' AND USERRIGHT='REQAPP'";
                  ResultSet r1131 = st1131.executeQuery(q1131);
                  if (r1131.next()) {
                    if (r1131.getInt("COUNT(USERRIGHT)")>0) {
                      cantransform=true;
                    }
                  }
                  st1131.close();
                  if (cantransform) {
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalAPPROVE('PRODUCTID="+r130.getString("ID")+"&REQTYPE=PRODUCT');\"><img border=0 src=\"icons/approve.png\" height=15></A></center></td>");
                  } else {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>---</center></td>");
                  }
                  out.print("</tr>");
                }
                st130.close();
                out.print("</table>");
                out.print("<table><tr><td><h2><strong>Program request(s)</strong></h2></center></td></tr></table>");
                out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
                out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"20\">");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"40%\"><center><A HREF=\"request.jsp?TODO=SORT&FIELD=NAME&OLDFIELD="+COLTOSORT+"&OLDDIR="+DIRSORT+"\">Name</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Attributes</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>START</td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"15%\"><center>END</center></td>");
                out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>TRANSFORM</center></td>");
                out.print("</tr>");
                Statement st230 = Conn.createStatement();
                String q230 = "SELECT * FROM PROGRAM "+filterstatement+" ORDER BY "+COLTOSORT+" "+DIRSORT;
                ResultSet r230 = st230.executeQuery(q230);
                while(r230.next()) {
                  out.print("<tr height=15>");
                  if (r230.getString("NAME").equals("")) {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
                  } else {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r230.getString("NAME")+"</center></td>");
                  }
                  out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"requestprogramdetails.jsp?TODO=MOD&PROGRAMID="+r230.getString("ID")+"\"><img border=0 src=\"icons/attributes.png\" height=15></A></center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r230.getString("DATE_START")+"</center></td>");
                  out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+r230.getString("DATE_END")+"</center></td>");
                  boolean cantransform = false;
                  Statement st2131 = Conn.createStatement();
                  String q2131 = "SELECT COUNT(USERRIGHT) FROM USER_RIGHT WHERE LOGIN='"+Userlogin+"' AND USERRIGHT='REQAPP'";
                  ResultSet r2131 = st2131.executeQuery(q2131);
                  if (r2131.next()) {
                    if (r2131.getInt("COUNT(USERRIGHT)")>0) {
                      cantransform=true;
                    }
                  }
                  st2131.close();
                  if (cantransform) {
                    out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"#\" onclick=\"showModalAPPROVE('PROGRAMID="+r230.getString("ID")+"&REQTYPE=PROGRAM');\"><img border=0 src=\"icons/approve.png\" height=15></A></center></td>");
                  } else {
                    out.print("<td bgcolor=\"#FFFFFF\"><center>---</center></td>");
                  }
                  out.print("</tr>");
                }
                st230.close();
                out.print("</table>");
                Conn.close();
              } 

    %>
  </body>
</html>
