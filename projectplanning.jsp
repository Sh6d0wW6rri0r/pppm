
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


  <%@ page import = "java.io.*" %>
  <%@ page import = "java.util.*" %>
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
  <%@ page import = "org.jdom.*" %>
  <%@ page import = "org.jdom.input.*" %>
  <%@ page import = "org.jdom.output.*" %>
  <%@ page import = "fr.pppm.*" %>

  <%!public void generatePlanning(String planningProjectID,String FATHERID,int level,String RO,Connection planningConnection,JspWriter out) throws Exception {
      Statement st31 = planningConnection.createStatement();
      String q31 = "SELECT NAME,DATE_START,DATE_END,ID,WORKLOAD,DURATION,TEMPLATELINK,DOCLINK FROM PROJECT_ACTIVITY WHERE PROJECTID='"+planningProjectID+"' AND FATHER='"+FATHERID+"' ORDER BY ORD ASC";
      ResultSet r31 = st31.executeQuery(q31);
      while(r31.next()) {
        out.print("<tr>");
        out.print("<td><table><tr>");
        if (RO.equals("NO")) {
          out.print("<td><center><A HREF=\"addactivity.jsp?TODO=ADD&PROJECTID="+planningProjectID+"&FATHER="+r31.getInt("ID")+"\"><img border=0 src=\"icons/addsmall.png\"></A></center></td>");
          out.print("<td><center><A HREF=\"deleteactivity.jsp?TODO=ADD&PROJECTID="+planningProjectID+"&ID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/deletesmall.png\"></A></center></td>");
          out.print("<td><center><A HREF=\"linkactivity.jsp?TODO=ADD&PROJECTID="+planningProjectID+"&FROMID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/linksmall.png\"></A></center></td>");
          out.print("<td><center><A HREF=\"deleteactivitylink.jsp?TODO=ADD&PROJECTID="+planningProjectID+"&ACTIVITYID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/deletelinksmall.png\"></A></center></td>");
        }
        out.print("</tr></td></table></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("ID")+"</center></A></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"80%\">");
        for (int i=0;i<level;i++) {
          out.print("&nbsp;&nbsp;&nbsp;");
        }
        boolean cansplit = true;
        Statement st43 = planningConnection.createStatement();
        String q43 = "SELECT * FROM PROJECT_ACTIVITY WHERE PROJECTID='"+planningProjectID+"' AND FATHER="+r31.getString("ID");
        ResultSet r43 = st43.executeQuery(q43);
        if (r43.next()) {
          cansplit=false;
        }
        st43.close();
        out.print(""+r31.getString("NAME")+"</td>");
        if (RO.equals("NO")) {
          if (cansplit) {
            out.print("<td width=\"20%\"><A HREF=\"addactivity.jsp?TODO=MOD&PROJECTID="+planningProjectID+"&ID="+r31.getInt("ID")+"&NAMEONLY=FALSE\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
          } else {
            out.print("<td width=\"20%\"><A HREF=\"addactivity.jsp?TODO=MOD&PROJECTID="+planningProjectID+"&ID="+r31.getInt("ID")+"&NAMEONLY=TRUE\"><img border=0 src=\"icons/modifysmall.png\"></A></td>");
          }
        }
        out.print("</tr></table></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getInt("DURATION")+"</center></td>");
        st43 = planningConnection.createStatement();
        q43 = "SELECT WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE PROJECTID='"+planningProjectID+"' AND ACTIVITYID="+r31.getString("ID");
        r43 = st43.executeQuery(q43);
        int wrkl=0;
        while (r43.next()) {
          wrkl=wrkl+r43.getInt("WORKLOAD");
        }
        st43.close();
        if (wrkl!=r31.getInt("WORKLOAD")) {
          if (cansplit) {
            out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"60%\"><center>"+r31.getInt("WORKLOAD")+"</td>");
          } else {
            Project pl=new Project(planningConnection,planningProjectID);
            out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"60%\"><center>"+pl.calculateworkload(r31.getString("ID"))+"</td>");
          }
          if (RO.equals("NO") && cansplit) {
            out.print("<td width=\"20%\"><A HREF=\"splitactivityworkload.jsp?TODO=MOD&PROJECTID="+planningProjectID+"&ID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/splitsmall.png\"></A></td>");
          }
          if (cansplit) {
            out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"60%\"><center>"+r31.getInt("WORKLOAD")+"</td>");
          } else {
            Project pl = new Project(planningConnection,planningProjectID);
            out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"60%\"><center>"+pl.calculateworkload(r31.getString("ID"))+"</td>");
          }
        } else {
          if (cansplit) {
            out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"60%\"><center>"+r31.getInt("WORKLOAD")+"</td>");
          } else {
            Project pl = new Project(planningConnection,planningProjectID);
            out.print("<td bgcolor=\"#FFFFFF\"><table width=\"100%\"><tr><td width=\"60%\"><center>"+pl.calculateworkload(r31.getString("ID"))+"</td>");
          }
          if (RO.equals("NO") && cansplit) {
            out.print("<td width=\"20%\"><A HREF=\"splitactivityworkload.jsp?TODO=MOD&PROJECTID="+planningProjectID+"&ID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/splitsmall.png\"></A></td>");
          }
          out.print("<td width=\"20%\">&nbsp;</td></tr></table></center></td>");
        }
        Statement st33 = planningConnection.createStatement();
        String q33 = "SELECT PERCENTAGE FROM RESOURCE_PROFILE_ACTIVITY WHERE PROJECTID='"+planningProjectID+"' AND ACTIVITYID="+r31.getString("ID");
        ResultSet r33 = st33.executeQuery(q33);
        int percenttotal2=0;
        while (r33.next()) {
          percenttotal2=percenttotal2+r33.getInt("PERCENTAGE");
        }
        st33.close();
        st33 = planningConnection.createStatement();
        q33 = "SELECT PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE PROJECTID='"+planningProjectID+"' AND ACTIVITYID="+r31.getString("ID")+" AND APPROVED='YES'";
        r33 = st33.executeQuery(q33);
        while (r33.next()) {
          percenttotal2=percenttotal2+r33.getInt("PERCENTAGE");
        }
        st33.close();
        if (RO.equals("NO")) {
          if (percenttotal2!=100) {
            out.print("<td bgcolor=\"#FFFFFF\"><center><table width=\"100%\"><tr><td width=\"70%\"><center><A HREF=\"resourcesactivity.jsp?TODO=ADD&PROJECTID="+planningProjectID+"&ACTIVITYID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/resourcessmall.png\"></A></center></td><td width=\"30%\"><center><img border=0 src=\"icons/alertsmall.png\"></center></td></tr></table></center></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center><table width=\"100%\"><tr><td width=\"70%\"><center><A HREF=\"resourcesactivity.jsp?TODO=ADD&PROJECTID="+planningProjectID+"&ACTIVITYID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/resourcessmall.png\"></A></center></td><td width=\"30%\">&nbsp;</td></tr></table></center></td>");
          }
        } else {
          out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
        }
        st33 = planningConnection.createStatement();
        q33 = "SELECT * FROM PROJECT_ACTIVITY_LINK WHERE PROJECTID='"+planningProjectID+"' AND FROMID="+r31.getString("ID");
        r33 = st33.executeQuery(q33);
        out.print("<td bgcolor=\"#FFFFFF\">");
        while (r33.next()) {
          out.print(r33.getString("TYPE")+":"+r33.getString("TOID")+";");
        }
        out.print("</td>");
        st33.close();
        if (r31.getString("TEMPLATELINK")==null || RO.equals("NO")) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></A></td>");
        } else {
          if (r31.getString("TEMPLATELINK").equals("")) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></A></td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\""+r31.getString("TEMPLATELINK")+"\" target=\"_new\"><img border=0 src=\"icons/tempsmall.png\"></A></center></A></td>");
          }
        }
        if (RO.equals("NO")) {
          if (r31.getString("DOCLINK")==null) {
            out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"adddoc.jsp?TODO=ADDDOC&PROJECTID="+planningProjectID+"&ACTIVITYID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/docaddsmall.png\"></A></center></A></td>");
          } else {
            if (r31.getString("DOCLINK").equals("")) {
              out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"adddoc.jsp?TODO=ADDDOC&PROJECTID="+planningProjectID+"&ACTIVITYID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/docaddsmall.png\"></A></center></A></td>");
            } else {
              out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\""+r31.getString("DOCLINK")+"\" target=\"_new\"><img border=0 src=\"icons/docsmall.png\"></A><A HREF=\"adddoc.jsp?TODO=MODDOC&PROJECTID="+planningProjectID+"&ACTIVITYID="+r31.getInt("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></center></A></td>");
            }
          }
        } else {
          out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\""+r31.getString("DOCLINK")+"\" target=\"_new\"><img border=0 src=\"icons/docsmall.png\"></A></center></A></td>");
        }
        if (cansplit) {
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("DATE_START")+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("DATE_END")+"</center></A></td>");
        } else {
          Project pl = new Project(planningConnection,planningProjectID);
          String sd = pl.calculatestartdate(r31.getString("ID"));
          String ed = pl.calculateenddate(r31.getString("ID"));
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+sd+"</center></A></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+ed+"</center></A></td>");
          Statement sti2 = planningConnection.createStatement();
          String i2 = "UPDATE PROJECT_ACTIVITY SET DATE_START='"+sd+"',DATE_END='"+ed+"' WHERE PROJECTID='"+planningProjectID+"' AND ID="+r31.getString("ID");
          sti2.executeUpdate(i2);
        }
        out.print("</tr>");
        generatePlanning(planningProjectID,r31.getString("ID"),level+1,RO,planningConnection,out);
      }
      st31.close();
    }
%>

  <%!public void displayPlanning(String planningProjectID,String FATHERID,int level,String RO,Connection planningConnection,JspWriter out) {
      try {
        generatePlanning(planningProjectID,FATHERID,level,RO,planningConnection,out);
      } catch (Exception e) {
      }
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

        Project pl = new Project(Conn,PROJECTID);
        PPPMTools mytools = new PPPMTools();        
        if (act.equals("ADDDOC") || act.equals("MODDOC")) {

          String ACTIVITYID= request.getParameter("ACTIVITYID");
 
          String DOCLINK= mytools.checkStr(request.getParameter("DOCLINK"));
  
          pl.addDocumentToActivity(ACTIVITYID,DOCLINK); 
 

       }
        if (act.equals("DEFINETEMPLATE")) {
          String PHASETEMPLATE  = request.getParameter("PHASETEMPLATE");
          pl.setPlanningFromTemplate(PHASETEMPLATE);
        }
        if (act.equals("ACTADD")) {
          String FATHER  = request.getParameter("FATHER");
          String NAME  = mytools.checkStr(request.getParameter("NAME"));

          String CREATETYPE=mytools.checkStr(request.getParameter("CREATETYPE"));
  
        String DATE_START="";

          String DATE_END="";
    
          if (CREATETYPE.equals("SCRATCH")) {          
            DATE_START=request.getParameter("DATE_START");
            DATE_END=request.getParameter("DATE_END");
        
          } else {
  
          DATE_START=request.getParameter("DATE_START_TEMPLATE");
            DATE_END=request.getParameter("DATE_END_TEMPLATE");

          }
          String WORKLOAD=mytools.checkStr(request.getParameter("WORKLOAD"));



          if (WORKLOAD.equals("")) {
    
        WORKLOAD="0";
    
          }
    

      if (mytools.checknum(WORKLOAD)) {
            pl.addTask(FATHER,NAME,DATE_START,DATE_END,WORKLOAD);
          } else {

            out.print("<HR>ERROR ON THE NUMBER FORMAT<HR>");

          }
        }
        if (act.equals("ACTMOD")) {
          String ID  = request.getParameter("ID");
          String NAME  = mytools.checkStr(request.getParameter("NAME"));

          String NAMEONLY=request.getParameter("NAMEONLY");
         
          if (NAMEONLY.equals("TRUE")) {
 
            pl.renameTask(ID,NAME);
          } else {

            String DATE_START=request.getParameter("DATE_START");
            String DATE_END=request.getParameter("DATE_END");
            String WORKLOAD=mytools.checkStr(request.getParameter("WORKLOAD"));

            if (WORKLOAD.equals("")) {

              WORKLOAD="0";

            }
           
            if (mytools.checknum(WORKLOAD)) {
              pl.changeTask(ID,NAME,DATE_START,DATE_END,WORKLOAD);
            } else {

              out.print("<HR>ERROR IN THE NUMBER FORMAT<HR>");

            }
         
          }
        }
        if (act.equals("SPLIT")) {
          String ID  = request.getParameter("ID");
          Statement st100 = Conn.createStatement();
          String q100 = "SELECT YEAR,MONTH,DAY,WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE ACTIVITYID='"+ID+"' AND PROJECTID='"+PROJECTID+"' ORDER BY YEAR,MONTH,DAY";
          ResultSet r100 = st100.executeQuery(q100);
          while (r100.next()) {
            String wrkl=request.getParameter(r100.getInt("YEAR")+""+r100.getInt("MONTH")+""+r100.getInt("DAY"));
 
            if (wrkl.equals("")) {

              wrkl="0";
 
            }          

            if (mytools.checknum(wrkl)) {
              pl.setTaskWorkloadByDay(ID,wrkl,""+r100.getInt("DAY"),""+r100.getInt("MONTH"),""+r100.getInt("YEAR"));
            } else {

              out.print("<HR>ERROR ON THE NUMBER FORMAT<HR>");
            }
          }
        }
        if (act.equals("LNKADD")) {
          String FROMID  = request.getParameter("FROMID");
          String TIDTMP = request.getParameter("TOID");
          String TOID = TIDTMP.substring(0,TIDTMP.indexOf("-")-1);
          String TTMP = request.getParameter("TYPE");
          String TYPE = TTMP.substring(0,TTMP.indexOf("-")-1);
          pl.linkTask(FROMID,TOID,TYPE);
        }
        if (act.equals("LNKDELETE")) {
          String ACTIVITYID = request.getParameter("ACTIVITYID");
          String TIDTMP = request.getParameter("TOID");
          String TOID = TIDTMP.substring(0,TIDTMP.indexOf("-")-1);
          pl.deleteLink(ACTIVITYID,TOID);
        }
        if (act.equals("BASELINE")) {
          String NAME=mytools.checkStr(request.getParameter("NAME"));
          pl.createBaseline(NAME);
        }
        if (act.equals("ACTDELETE")) {
          String ID  = request.getParameter("ID");
          pl.deleteactivity(ID);    
        }
        if (act.equals("LOADMSP")) {
          String contentType = request.getContentType();
          if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
            DataInputStream in = new DataInputStream(request.getInputStream());
            int formDataLength = request.getContentLength();
            byte dataBytes[] = new byte[formDataLength];
            int byteRead = 0;
            int totalBytesRead = 0; 
            while (totalBytesRead < formDataLength) {
              byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
              totalBytesRead += byteRead;
            }     
            String file = new String(dataBytes);
            String saveFile = file.substring(file.indexOf("filename=\"") + 10);
            saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
            int lastIndex = contentType.lastIndexOf("=");
            String boundary = contentType.substring(lastIndex + 1,contentType.length());
            int pos;
            pos = file.indexOf("filename=\"");
            pos = file.indexOf("\n", pos) + 1;
            pos = file.indexOf("\n", pos) + 1;
            pos = file.indexOf("\n", pos) + 1;
            int boundaryLocation = file.indexOf(boundary, pos) - 4;                
            int startPos = ((file.substring(0, pos)).getBytes()).length;                
            int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
            FileOutputStream fileOut = new FileOutputStream("/data/tomcat/strppm/upload/"+saveFile);
            fileOut.write(dataBytes, startPos, (endPos - startPos));                
            fileOut.flush();                
            fileOut.close();
            int res = pl.loadMSPFile(saveFile);
            if (res==1) {
              out.print("<HR> THE NAME OF ONE OF THE PHASES IS NOT COMPLIANT WITH THE PHASE TEMPLATE USED FOR THIS PROJECT <HR>");
            }
            if (res==2) {
              out.print("<hr> THIS IS NOT A VALID MICROSOFT PROJECT XML FILE<hr>");
            }
          }
        }
        Statement st10 = Conn.createStatement();
        out.print("<center><table><tr><td><img border=0 src=\"icons/planning.png\"></td><td><strong><h1>Project planning</h1></strong></td></tr></table></center><hr>");
        if (RO.equals("NO")) {
          out.print("<td><A HREF=\"loadmsp.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/load.png\"> </A></td>");
          User us = new User(Conn);
          if (us.hasRole(Userlogin,"BASELINE")) {
            out.print("<td><A HREF=\"addbaseline.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/addbaseline.png\"> </A></td>");
          }
        }
        out.print("<td><A HREF=\"baseline.jsp?TODO=NONE&PROJECTID="+PROJECTID+"&RO="+RO+"\"><img border=0 src=\"icons/baseline.png\"> </A></td>");
        out.print("</tr></table>");
        out.print("<hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"5%\"><center>&nbsp;</center></td>");
        out.print("<td width=\"5%\" background=\"images/fond_titre.jpg\"><center>#</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Activity</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Duration (days)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Workload (hours)</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Ressources</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Link to</center></td>");
        out.print("<td width=\"5%\" background=\"images/fond_titre.jpg\"><center>Doc. template</center></td>");
        out.print("<td width=\"5%\" background=\"images/fond_titre.jpg\"><center>Prj doc.</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>Start</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>End</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT NAME,DATE_START,DATE_END,ID FROM PROJECT_ACTIVITY WHERE PROJECTID='"+PROJECTID+"' AND FATHER='ROOT' ORDER BY ORD ASC";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          out.print("<td><table><tr>");
          if (RO.equals("NO")) {
            out.print("<td><center><A HREF=\"addactivity.jsp?TODO=ADD&PROJECTID="+PROJECTID+"&FATHER="+r30.getInt("ID")+"\"><img border=0 src=\"icons/addsmall.png\"></A></center></td>");
          } else {
            out.print("<td>&nbsp;</td>");
          }
          out.print("<td><center>&nbsp;</center></td>");
          out.print("</tr></table></td>");
          out.print("<td bgcolor=\"#EFEFEF\"><center>"+r30.getString("ID")+"</center></A></td>");
          out.print("<td bgcolor=\"#EFEFEF\">"+r30.getString("NAME")+"</td>");
          Statement st31b = Conn.createStatement();
          String q31b = "SELECT WORKLOAD FROM PROJECT_ACTIVITY WHERE PROJECTID='"+PROJECTID+"' AND FATHER='"+r30.getInt("ID")+"' ORDER BY ORD ASC";
          ResultSet r31b = st31b.executeQuery(q31b);
          int wrktmp=0;
          while(r31b.next()) {
            wrktmp=wrktmp+r31b.getInt("WORKLOAD");
          }
          st31b.close();
          SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
          SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
          long begincreneau = d1.parse(r30.getString("DATE_START")).getTime();
          long endcreneau = d2.parse(r30.getString("DATE_END")).getTime();  
          long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
          long nday=0;
          for (long delta = begincreneau; delta <= endcreneau; delta = delta+ MILLISECONDS_PER_DAY) {
            Calendar cday = Calendar.getInstance();
            cday.setTimeInMillis(delta);
            if ((cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
              nday++;
            }
          }
          out.print("<td bgcolor=\"#EFEFEF\"><center>"+nday+"</center></td>");
          out.print("<td bgcolor=\"#EFEFEF\"><center>"+pl.calculateworkload(r30.getString("ID"))+"</center></td>");
          out.print("<td bgcolor=\"#EFEFEF\"><center><table width=\"100%\"><tr><td width=\"70%\"><center><A HREF=\"resourcesactivity.jsp?TODO=ADD&PROJECTID="+PROJECTID+"&ACTIVITYID="+r30.getInt("ID")+"\"><img border=0 src=\"icons/resourcessmall.png\"></A></center></td><td width=\"30%\">&nbsp;</td></tr></table></center></td>");
          st31b = Conn.createStatement();
          q31b = "SELECT * FROM PROJECT_ACTIVITY_LINK WHERE PROJECTID='"+PROJECTID+"' AND FROMID="+r30.getString("ID");
          r31b = st31b.executeQuery(q31b);
          out.print("<td bgcolor=\"#EFEFEF\">");
          while (r31b.next()) {
            out.print(r31b.getString("TYPE")+":"+r31b.getString("TOID")+";");
          }
          out.print("</td>");
          st31b.close();
          out.print("<td bgcolor=\"#EFEFEF\"><center>-</center></td>");
          out.print("<td bgcolor=\"#EFEFEF\"><center>-</center></td>");
          boolean haschild=false;
          Statement st30a = Conn.createStatement();
          String q30a = "SELECT ID FROM PROJECT_ACTIVITY WHERE PROJECTID='"+PROJECTID+"' AND FATHER='"+r30.getString("ID")+"'";
          ResultSet r30a = st30a.executeQuery(q30a);
          if(r30a.next()) {
            haschild=true;
          }
          st30a.close();
          if (!haschild) {
            out.print("<td bgcolor=\"#EFEFEF\"><center>"+r30.getString("DATE_START")+"</center></A></td>");
            out.print("<td bgcolor=\"#EFEFEF\"><center>"+r30.getString("DATE_END")+"</center></A></td>");
          } else {
            out.print("<td bgcolor=\"#EFEFEF\"><center>"+pl.calculatestartdate(r30.getString("ID"))+"</center></A></td>");
            out.print("<td bgcolor=\"#EFEFEF\"><center>"+pl.calculateenddate(r30.getString("ID"))+"</center></A></td>");
          }
          out.print("</tr>");
          displayPlanning(PROJECTID,r30.getString("ID"),1,RO,Conn,out);
        }
        st30.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        
        Conn.close();
      }
      out.print("<canvas id=\"canvas\"></canvas>");
      out.print("<script>\n");
      out.print("var canvas=document.getElementById('canvas');\n");
      out.print("canvas.width=window.innerWidth-30;\n");
      out.print("canvas.height=window.innerHeight-30;\n");
      out.print("var ctx=document.getElementById('canvas').getContext('2d');\n");
      out.print("ctx.fillStyle=\"rgb(255,255,255)\";\n");
      out.print("ctx.fillRect(5,5,window.innerWidth-30,window.innerHeight-30);\n");
      out.print("</script>\n");

    %>
  </body>
</html>
