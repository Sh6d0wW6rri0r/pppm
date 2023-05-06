
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

        if (act.equals("CALCIT")) {
            String DC = request.getParameter("DEPLCOMPLEX");
            String TC = request.getParameter("TRAINCOMPLEX");
            Statement STRC01 = Conn.createStatement();
            String QRC01 = "SELECT COMPLEXITY FROM PROJECT_DEPLOYMENT WHERE PROJECTID='"+PROJECTID+"'";
            ResultSet RC01 = STRC01.executeQuery(QRC01);
            if (RC01.next()) {
              Statement sti2 = Conn.createStatement();
              String i2 = "UPDATE PROJECT_DEPLOYMENT SET COMPLEXITY='"+DC+"' WHERE PROJECTID='"+request.getParameter("PROJECTID")+"'";
              sti2.executeUpdate(i2);
              sti2.close();
            } else {
              Statement sti2 = Conn.createStatement();
              String i2 = "INSERT INTO PROJECT_DEPLOYMENT VALUES('"+PROJECTID+"','"+DC+"')";
              sti2.executeUpdate(i2);
              sti2.close();
            }
           STRC01.close();
            Statement STRC02 = Conn.createStatement();
            String QRC02 = "SELECT COMPLEXITY FROM PROJECT_TRAINING WHERE PROJECTID='"+PROJECTID+"'";
            ResultSet RC02 = STRC02.executeQuery(QRC02);
            if (RC02.next()) {
              Statement sti2 = Conn.createStatement();
              String i2 = "UPDATE PROJECT_TRAINING SET COMPLEXITY='"+TC+"' WHERE PROJECTID='"+request.getParameter("PROJECTID")+"'";
              sti2.executeUpdate(i2);
              sti2.close();
            } else {
              Statement sti2 = Conn.createStatement();
              String i2 = "INSERT INTO PROJECT_TRAINING VALUES('"+PROJECTID+"','"+TC+"')";
              sti2.executeUpdate(i2);
              sti2.close();
            }
           STRC02.close();
        }


        out.print("<center><table><tr><td><img border=0 src=\"icons/organization.png\"></td><td><strong><h1>Project Deployment phase</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Projects \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\"> My Project Portfolio</A> \\ Project deployment </td><td><A HREF=\"projectdeployment.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");

        long TOTALEXEC=0;
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT ID,NAME,DESCRIPTION FROM TECHNOLOGY WHERE ID IN (SELECT TECHNOLOGYID FROM PROJECT_TECHNOLOGY WHERE PROJECTID='"+PROJECTID+"')";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          long TOTALTECH=0;
          Statement st32 = Conn.createStatement();
          String q32 = "SELECT NBEASY,NBSTANDARD,NBCOMPLEX,TASKID FROM PROJECT_TECHNOLOGY_TASK WHERE PROJECTID='"+PROJECTID+"' AND TECHNOLOGYID='"+r30.getString("ID")+"'";
          ResultSet r32 = st32.executeQuery(q32);
          while (r32.next()) {
            Statement st33 = Conn.createStatement();
            String q33 = "SELECT EASY_DEV_HOURS,STANDARD_DEV_HOURS,COMPLEX_DEV_HOURS,EASY_TEST_HOURS,STANDARD_TEST_HOURS,COMPLEX_TEST_HOURS FROM TECHNOLOGY_TASK_RATIO WHERE TASKID='"+r32.getString("TASKID")+"' AND TECHNOLOGYID='"+r30.getString("ID")+"'";
            ResultSet r33 = st33.executeQuery(q33);
            if(r33.next()) {
              TOTALTECH=TOTALTECH+r32.getLong("NBEASY")*r33.getLong("EASY_DEV_HOURS")+r32.getLong("NBSTANDARD")*r33.getLong("STANDARD_DEV_HOURS")+r32.getLong("NBCOMPLEX")*r33.getLong("COMPLEX_DEV_HOURS")+r32.getLong("NBEASY")*r33.getLong("EASY_TEST_HOURS")+r32.getLong("NBSTANDARD")*r33.getLong("STANDARD_TEST_HOURS")+r32.getLong("NBCOMPLEX")*r33.getLong("COMPLEX_TEST_HOURS");
            }
            st33.close();
          }
          st32.close();

          TOTALEXEC=TOTALEXEC+TOTALTECH;
        }
        st30.close();
 

        long TOTALPM=0;
        long TOTALQA=0;
   
     Statement st34 = Conn.createStatement();
        String q34 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='EX-PM'";
        ResultSet r34 = st34.executeQuery(q34);
        if(r34.next()) {
          TOTALPM=TOTALEXEC*r34.getLong("RATIO")/100;
        }
        st34.close();
   
     Statement st35 = Conn.createStatement();
        String q35 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO ='EX-QA'";
        ResultSet r35 = st35.executeQuery(q35);
        if(r35.next()) {
          TOTALQA=TOTALEXEC*r35.getLong("RATIO")/100;
        }
        st35.close();
 
        long TOTALDEPLEASY=0;
        long TOTALDEPLSTANDARD=0;
        long TOTALDEPLCOMPLEX=0;

   
     Statement st36 = Conn.createStatement();
        String q36 = "SELECT EASY_RATIO,STANDARD_RATIO,COMPLEX_RATIO FROM PROJECT_DEPL_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet r36 = st36.executeQuery(q36);
        if(r36.next()) {
          TOTALDEPLEASY=TOTALEXEC*r36.getLong("EASY_RATIO")/100;
          TOTALDEPLSTANDARD=TOTALEXEC*r36.getLong("STANDARD_RATIO")/100;
          TOTALDEPLCOMPLEX=TOTALEXEC*r36.getLong("COMPLEX_RATIO")/100;

        }
        st36.close();

        long TOTALTRAINEASY=0;
        long TOTALTRAINSTANDARD=0;
        long TOTALTRAINCOMPLEX=0;

   
     Statement st37 = Conn.createStatement();
        String q37 = "SELECT EASY_RATIO,STANDARD_RATIO,COMPLEX_RATIO FROM PROJECT_TRAIN_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet r37 = st37.executeQuery(q37);
        if(r37.next()) {
          TOTALTRAINEASY=TOTALEXEC*r37.getLong("EASY_RATIO")/100;
          TOTALTRAINSTANDARD=TOTALEXEC*r37.getLong("STANDARD_RATIO")/100;
          TOTALTRAINCOMPLEX=TOTALEXEC*r37.getLong("COMPLEX_RATIO")/100;

        }
        st37.close();
 
        String DEPLCOMPLEXITY="";
   
     Statement st38 = Conn.createStatement();
        String q38 = "SELECT COMPLEXITY FROM PROJECT_DEPLOYMENT WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet r38 = st38.executeQuery(q38);
        if(r38.next()) {
           DEPLCOMPLEXITY=r38.getString("COMPLEXITY");
        }
        st38.close();

        String TRAINCOMPLEXITY="";
   
     Statement st39 = Conn.createStatement();
        String q39 = "SELECT COMPLEXITY FROM PROJECT_TRAINING WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet r39 = st39.executeQuery(q39);
        if(r39.next()) {
           TRAINCOMPLEXITY=r39.getString("COMPLEXITY");
        }
        st39.close();
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectdeployment.jsp?TODO=CALCIT&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\" target=\"appliFrame\">");
        String deplcomplex="";
        String traincomplex="";
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT COMPLEXITY FROM PROJECT_DEPLOYMENT WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          deplcomplex=R01.getString("COMPLEXITY");
        }
        STR01.close();
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT COMPLEXITY FROM PROJECT_TRAINING WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R02 = STR02.executeQuery(QR02);
        if (R02.next()) {
          traincomplex=R02.getString("COMPLEXITY");
        }
        STR02.close();
        out.print("<table>");
        out.print("<tr><td>Deployment complexity : </td><td><select name=\"DEPLCOMPLEX\">");
        out.print("<option>NONE - NOT SELECTED</option>");
        out.print("<option");
        if (deplcomplex.equals("EASY")) {
          out.print(" selected ");
        }
        out.print(">EASY</option>");
        out.print("<option");
        if (deplcomplex.equals("STANDARD")) {
          out.print(" selected ");
        }
        out.print(">STANDARD</option>");
        out.print("<option");
        if (deplcomplex.equals("COMPLEX")) {
          out.print(" selected ");
        }
        out.print(">COMPLEX</option>");
        out.print("</select></td></tr>");
        out.print("<tr><td>Training complexity : </td><td><select name=\"TRAINCOMPLEX\">");
        out.print("<option>NONE - NOT SELECTED</option>");
        out.print("<option");
        if (traincomplex.equals("EASY")) {
          out.print(" selected ");
        }
        out.print(">EASY</option>");
        out.print("<option");
        if (traincomplex.equals("STANDARD")) {
          out.print(" selected ");
        }
        out.print(">STANDARD</option>");
        out.print("<option");
        if (traincomplex.equals("COMPLEX")) {
          out.print(" selected ");
        }
        out.print(">COMPLEX</option>");
        out.print("</select></td></tr></table>");
        out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/approve.png\" type=image Value=submit></td>");
        out.print("</tr></table>");
        out.print("</form>");

        out.print("<br><h2>Total for Deployment Phase</h2><br>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Workload</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        long TOTALDEPL=0;
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Deployment</td>");
        if (DEPLCOMPLEXITY.equals("EASY")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALDEPLEASY+"</center></td>");
          TOTALDEPL=TOTALDEPLEASY;
        }
        if (DEPLCOMPLEXITY.equals("STANDARD")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALDEPLSTANDARD+"</center></td>");
          TOTALDEPL=TOTALDEPLSTANDARD;
        }
        if (DEPLCOMPLEXITY.equals("COMPLEX")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALDEPLCOMPLEX+"</center></td>");
          TOTALDEPL=TOTALDEPLCOMPLEX;
        }
        if (DEPLCOMPLEXITY.equals("")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>Complexity not selected</center></td>");
        }
        long TOTALTRAIN=0;
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Training</td>");
        if (TRAINCOMPLEXITY.equals("EASY")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALTRAINEASY+"</center></td>");
          TOTALTRAIN=TOTALTRAINEASY;
        }
        if (TRAINCOMPLEXITY.equals("STANDARD")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALTRAINSTANDARD+"</center></td>");
          TOTALTRAIN=TOTALTRAINSTANDARD;
        }
        if (TRAINCOMPLEXITY.equals("COMPLEX")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALTRAINCOMPLEX+"</center></td>");
          TOTALTRAIN=TOTALTRAINCOMPLEX;
        }
        if (TRAINCOMPLEXITY.equals("")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>Complexity not selected</center></td>");
        }

        out.print("</tr>");

        long TOTALPMDEPL=0;
        long TOTALQADEPL=0;
   
     Statement st40 = Conn.createStatement();
        String q40 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='DP-PM'";
        ResultSet r40 = st40.executeQuery(q40);
        if(r40.next()) {
          TOTALPMDEPL=(TOTALDEPL+TOTALTRAIN)*r40.getLong("RATIO")/100;
        }
        st40.close();
   
     Statement st41 = Conn.createStatement();
        String q41 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO ='DP-QA'";
        ResultSet r41 = st41.executeQuery(q41);
        if(r41.next()) {
          TOTALQADEPL=(TOTALDEPL+TOTALTRAIN)*r41.getLong("RATIO")/100;
        }
        st41.close();

        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Project Management</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALPMDEPL+"</center></td>");
        out.print("</tr>");

        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Quality Assurance</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALQADEPL+"</center></td>");
        out.print("</tr>");


        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total Workload for Deployment phase</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+(TOTALPMDEPL+TOTALQADEPL+TOTALDEPL+TOTALTRAIN)+"</b></center></td>");
        out.print("</tr>");

      }
      Conn.close();
    %>
  </body>
</html>
