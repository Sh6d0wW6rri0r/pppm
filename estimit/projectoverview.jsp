
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

        out.print("<center><table><tr><td><img border=0 src=\"icons/report.png\"></td><td><strong><h1>Project Planning phase</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td>You are here : Projects \\ <A HREF=\"portfolio.jsp?TODO=NONE\" target=\"appliFrame\"> My Project Portfolio</A> \\ Project overview<td><A HREF=\"projectoverview.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&PROJECTTYPEID="+PROJECTTYPEID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        int EASYREQ = 0;
        int STANDARDREQ=0;
        int COMPLEXREQ=0;
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT NBEASY,NBSTANDARD,NBCOMPLEX FROM PROJECT_REQUIREMENTS WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          EASYREQ=R01.getInt("NBEASY");
          STANDARDREQ=R01.getInt("NBSTANDARD");
          COMPLEXREQ=R01.getInt("NBCOMPLEX");
        }
        STR01.close();
        out.print("<table><tr><td><h2><strong>Total for Planning phase</strong></h2></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Easy</center></b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Standard</b></center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Complex</b></center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Total</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Use-Cases</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+EASYREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+STANDARDREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+COMPLEXREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+(EASYREQ+STANDARDREQ+COMPLEXREQ)+"</b></center></td>");
        out.print("</tr>");
        long TOTALEASYREQ=0;
        long TOTALSTANDARDREQ=0;
        long TOTALCOMPLEXREQ=0;
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT EASY_HOURS,STANDARD_HOURS,COMPLEX_HOURS FROM PROJECT_PLANNING_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet R02 = STR02.executeQuery(QR02);
        if (R02.next()) {
          TOTALEASYREQ=R02.getLong("EASY_HOURS")*EASYREQ;
          TOTALSTANDARDREQ=R02.getLong("STANDARD_HOURS")*STANDARDREQ;
          TOTALCOMPLEXREQ=R02.getLong("COMPLEX_HOURS")*COMPLEXREQ;
        }
        STR02.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Requirements workload (hours)</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALEASYREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALSTANDARDREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALCOMPLEXREQ+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+(TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ)+"</b></center></td>");
        out.print("</tr>");
        long TOTALPMREQ=0;
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='PL-PM'";
        ResultSet R03 = STR03.executeQuery(QR03);
        if (R03.next()) {
          TOTALPMREQ=R03.getLong("RATIO")*(TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ)/100;
        }
        STR03.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Project Management workload (hours)</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALPMREQ+"</b></center></td>");
        out.print("</tr>");
        long TOTALQAREQ=0;
        Statement STR04 = Conn.createStatement();
        String QR04 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='PL-QA'";
        ResultSet R04 = STR04.executeQuery(QR04);
        if (R04.next()) {
          TOTALQAREQ=R04.getLong("RATIO")*(TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ)/100;
        }
        STR04.close();
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\">Quality Management workload (hours)</td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALQAREQ+"</b></center></td>");
        out.print("</tr>");
        long TOTALPLANNING=TOTALEASYREQ+TOTALSTANDARDREQ+TOTALCOMPLEXREQ+TOTALPMREQ+TOTALQAREQ;
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\"><b>Total Planning workload (hours)</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\" colspan=3><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+TOTALPLANNING+"</b></center></td>");
        out.print("</tr>");

        out.print("</table>");


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
        out.print("<br><br><h2><b>Total for Execution Phase</b></h2><br>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Workload</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for DEV and TEST</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALEXEC+"</center></td>");
        out.print("</tr>");
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
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for Project Management</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALPM+"</center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for Quality Assurance</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALQA+"</center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for Execution</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+(TOTALEXEC+TOTALPM+TOTALQA)+"</b></center></td>");
        out.print("</tr>");
        out.print("</table>");
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
        String deplcomplex="";
        String traincomplex="";
        Statement STR01b = Conn.createStatement();
        String QR01b = "SELECT COMPLEXITY FROM PROJECT_DEPLOYMENT WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R01b = STR01b.executeQuery(QR01b);
        if (R01b.next()) {
          deplcomplex=R01b.getString("COMPLEXITY");
        }
        STR01b.close();
        Statement STR02b = Conn.createStatement();
        String QR02b = "SELECT COMPLEXITY FROM PROJECT_TRAINING WHERE PROJECTID='"+PROJECTID+"'";
        ResultSet R02b = STR02b.executeQuery(QR02b);
        if (R02b.next()) {
          traincomplex=R02b.getString("COMPLEXITY");
        }
        STR02b.close();


        out.print("<br><h2><b>Total for Deployment Phase</b></h2><br>");
        out.print("<table>");
        out.print("<tr><td>Deployment complexity : </td><td>"+deplcomplex+"</td>");
        out.print("</tr>");
        out.print("<tr><td>Training complexity : </td><td>"+traincomplex+"</td>");
        out.print("</tr></table><br>");
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
        out.print("</tr></table>");

 
        long TOTALPMCLOSE=0;
        long TOTALQACLOSE=0;
        long TOTALCLOSE=0;

   
     Statement st56 = Conn.createStatement();
        String q56 = "SELECT RATIO FROM PROJECT_CLOSE_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"'";
        ResultSet r56 = st56.executeQuery(q56);
        if(r56.next()) {
          TOTALCLOSE=TOTALEXEC*r56.getLong("RATIO")/100;
        }
        st56.close();


        out.print("<br><h2><b>Total for Close phase</b></h2><br>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Workload</b></center></td>");
        out.print("</tr>");

   
     Statement st60 = Conn.createStatement();
        String q60 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO='CL-PM'";
        ResultSet r60 = st60.executeQuery(q60);
        if(r60.next()) {
          TOTALPMCLOSE=TOTALCLOSE*r60.getLong("RATIO")/100;
        }
        st60.close();
   
     Statement st61 = Conn.createStatement();
        String q61 = "SELECT RATIO FROM PROJECT_MANAGEMENT_RATIO WHERE PROJECTTYPEID='"+PROJECTTYPEID+"' AND IDRATIO ='CL-QA'";
        ResultSet r61 = st61.executeQuery(q61);
        if(r61.next()) {
          TOTALQACLOSE=TOTALCLOSE*r61.getLong("RATIO")/100;
        }
        st61.close();

        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Project Management</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALPMCLOSE+"</center></td>");
        out.print("</tr>");

        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\">Workload for Quality Assurance</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+TOTALQACLOSE+"</center></td>");
        out.print("</tr>");


        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for Close phase</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+(TOTALPMCLOSE+TOTALQACLOSE)+"</b></center></td>");
        out.print("</tr></table>");

        out.print("<br><h2><b>Total for Project</b></h2><br>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><b>Description</b></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center><b>Workload</b></center></td>");
        out.print("</tr>");
        out.print("<tr>");
        out.print("<td bgcolor=\"#FFFFFF\"><b>Total workload for Project</b></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center><b>"+(TOTALPMCLOSE+TOTALQACLOSE+TOTALPMDEPL+TOTALQADEPL+TOTALDEPL+TOTALTRAIN+TOTALEXEC+TOTALPM+TOTALQA+TOTALPLANNING)+"</b></center></td>");
        out.print("</tr>");

      }
      Conn.close();
    %>
  </body>
</html>
