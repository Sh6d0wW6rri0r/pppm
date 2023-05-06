package fr.pppm;

// Vortex PPM, the OpenSource PPM (Portfolio, Project and Program management) system
// Copyright (C) 2012  Olivier Moulin

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.


import java.util.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;

public class Application {

Connection applicationConnection;
String applicationid;
String name;
String description;
String fownerid;
String date_start;
String date_end;
String status;
int score;
String closed;
String scoring_groupid;

public Application (Connection Conn) throws Exception {
  applicationConnection=Conn;
  int ORD=0;
  Statement st43 = applicationConnection.createStatement();
  String q43 = "SELECT ID,SEQ FROM INDX WHERE ID='APPLICATION'";
  ResultSet r43 = st43.executeQuery(q43);
  if (r43.next()) {
    ORD=r43.getInt("SEQ");
  }
  st43.close();
  Statement sti1 = applicationConnection.createStatement();
  String i1 = "UPDATE INDX SET SEQ="+(ORD+1)+" WHERE ID='APPLICATION'";
  sti1.executeUpdate(i1);
  sti1.close();
  applicationid="PRD"+ORD;
  name="";
  description="";
  status="";
  score=0;
  fownerid="";
  date_start="2011-01-01";
  date_end="2011-01-01";
  closed="N";
  scoring_groupid="";
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "INSERT INTO APPLICATION VALUES('"+applicationid+"','"+name+"','"+description+"',"+score+",'"+fownerid+"','"+date_start+"','"+date_end+"','"+status+"','"+closed+"','"+scoring_groupid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public Application (Connection Conn, String pid) throws Exception {
  applicationConnection=Conn;
  applicationid = pid;
  Statement st12 = applicationConnection.createStatement();
  String q12 = "SELECT * FROM APPLICATION WHERE ID='"+applicationid+"'";
  ResultSet r12 = st12.executeQuery(q12);
  if (r12.next()) {
    name=r12.getString("NAME");
    description=r12.getString("DESCRIPTION");
    score=r12.getInt("SCORE");
    fownerid=r12.getString("FOWNERID");
    date_start=r12.getString("DATE_START");
    date_end=r12.getString("DATE_END");
    status=r12.getString("STATUS");
    closed=r12.getString("CLOSED");
    scoring_groupid=r12.getString("SCORING_GROUPID");
  }
  st12.close();
}

public void refresh () throws Exception {
  Statement st12 = applicationConnection.createStatement();
  String q12 = "SELECT * FROM APPLICATION WHERE ID='"+applicationid+"'";
  ResultSet r12 = st12.executeQuery(q12);
  if (r12.next()) {
    name=r12.getString("NAME");
    description=r12.getString("DESCRIPTION");
    score=r12.getInt("SCORE");
    fownerid=r12.getString("FOWNERID");
    date_start=r12.getString("DATE_START");
    date_end=r12.getString("DATE_END");
    status=r12.getString("STATUS");
    closed=r12.getString("CLOSED");
  }
  st12.close();
}

public String getId() {
  return applicationid;
}

public String getName() {
  return name;
}

public void setName(String n) throws Exception {
  name = n;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET NAME='"+n+"' WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public String getStatus() {
  return status;
}

public void setStatus(String s) throws Exception {
  status = s;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET STATUS='"+s+"' WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}


public String getDescription() {
  return description;
}

public void setDescription(String d) throws Exception {
  description = d;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET DESCRIPTION='"+d+"' WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public int getScore() {
  return score;
}

public void setScore(int s) throws Exception {
  score = s;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET SCORE="+s+" WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}
public String getScoringgroupid() {
  return scoring_groupid;
}

public void setScoringgroupid(String s) throws Exception {
  scoring_groupid = s;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET SCORING_GROUPID='"+s+"' WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public String getFownerid() {
  return fownerid;
}

public void setFownerid(String o) throws Exception {
  fownerid = o;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET FOWNERID='"+o+"' WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}


public String getDatestart() {
  return date_start;
}

public void setDatestart(String d) throws Exception {
  date_start = d;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET DATE_START='"+d+"' WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public String getDateend() {
  return date_end;
}

public void setDateend(String d) throws Exception {
  date_end = d;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET DATE_END='"+d+"' WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public String getClosed() {
  return closed;
}

public void setClosed(String c) throws Exception {
  closed = c;
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "UPDATE APPLICATION SET CLOSED='"+c.substring(0,1)+"' WHERE ID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}


public void addBPO(String bpoid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "INSERT INTO APPBPO VALUES ('"+bpoid+"','"+applicationid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void addApplicationPortfolio(String portfolioid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "INSERT INTO APPPOR VALUES ('"+applicationid+"','"+portfolioid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void delApplicationPortfolio(String portfolioid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "DELETE FROM APPPOR WHERE APPLICATIONID='"+applicationid+"' AND PORTFOLIOID='"+portfolioid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void deleteBPO(String bpoid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "DELETE FROM APPBPO WHERE EMPLOYEEID='"+bpoid+"' AND APPLICATIONID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void addDivision(String divid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "INSERT INTO APPDIV VALUES ('"+applicationid+"','"+divid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void deleteDivision(String divid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "DELETE FROM APPDIV WHERE DIVISIONID='"+divid+"' AND APPLICATIONID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void addLocation(String locid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "INSERT INTO APPLOC VALUES ('"+applicationid+"','"+locid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void deleteLocation(String locid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "DELETE FROM APPLOC WHERE LOCATIONID='"+locid+"' AND APPLICATIONID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void addStrategy(String stratid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "INSERT INTO APPSI VALUES ('"+applicationid+"','"+stratid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void deleteStrategy(String stratid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "DELETE FROM APPSI WHERE SIID='"+stratid+"' AND APPLICATIONID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void addProductManager (String pmid) throws Exception {
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "INSERT INTO APPPM VALUES ('"+pmid+"','"+applicationid+"')";
  sti2.executeUpdate(i2);
}

public void deleteProductManager (String pmid) throws Exception{
  Statement sti2 = applicationConnection.createStatement();
  String i2 = "DELETE FROM APPPM WHERE EMPLOYEEID='"+pmid+"' AND APPLICATIONID='"+applicationid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public int setAnswer(String questionName,String questionId,int weight) throws Exception{
  Statement st12 = applicationConnection.createStatement();
  String q12 = "SELECT ID,NAME,SCORE FROM SCORING_QUESTION_ANSWER WHERE NAME='"+questionName+"' AND QUESTIONID='"+questionId+"'";
  ResultSet r12 = st12.executeQuery(q12);
  int qs = 0;
  if (r12.next()) {
    qs=r12.getInt("SCORE");
  }
  st12.close();
  Statement st13 = applicationConnection.createStatement();
  String q13 = "SELECT APPLICATIONID,QUESTIONID,ANSWERID FROM APPANS WHERE APPLICATIONID='"+applicationid+"' AND QUESTIONID='"+questionId+"'";
  ResultSet r13 = st13.executeQuery(q13);
  if (r13.next()) {
    Statement sti2 = applicationConnection.createStatement();
    String i2 = "UPDATE APPANS SET ANSWERID='"+r12.getString("ID")+"' WHERE APPLICATIONID='"+applicationid+"' AND QUESTIONID='"+questionId+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  } else {
    Statement sti3 = applicationConnection.createStatement();
    String i3 = "INSERT INTO APPANS VALUES('"+applicationid+"','"+questionId+"','"+r12.getString("ID")+"')";
    sti3.executeUpdate(i3);
    sti3.close();
  }
  st13.close();
  return qs*weight;
}

public void defineTemplate(String phasetemplate) throws Exception {
  String BDATE="2011-01-01";
  String EDATE="2011-01-01";
  Statement st12 = applicationConnection.createStatement();
  String q12 = "SELECT DATE_START,DATE_END FROM APPLICATION WHERE ID='"+applicationid+"'";
  ResultSet r12 = st12.executeQuery(q12);
  if (r12.next()) {
    BDATE=r12.getString("DATE_START");
    EDATE=r12.getString("DATE_END");
  }
  st12.close();
  SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
  SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
  long begincreneau = d1.parse(BDATE).getTime();
  long endcreneau = d2.parse(EDATE).getTime(); 
  long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
  long nday=0;
  for (long delta = begincreneau; delta <= endcreneau; delta = delta+ MILLISECONDS_PER_DAY) {
    Calendar cday = Calendar.getInstance();
    cday.setTimeInMillis(delta);
    if ((cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
      nday++;
    }
  }
  Statement sti1 = applicationConnection.createStatement();
  String i1 = "DELETE FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"'";
  sti1.executeUpdate(i1);
  sti1.close();
  int activity_id =0;
  Statement st31 = applicationConnection.createStatement();
  String q31 = "SELECT NAME,ORD FROM PHASE_TEMPLATE WHERE TEMPLATE='"+phasetemplate+"' ORDER BY ORD DESC";
  ResultSet r31 = st31.executeQuery(q31);
  if (r31.next()) {
    activity_id = r31.getInt("ORD")+1;
  }
  st31.close();
  Statement st11 = applicationConnection.createStatement();
  String q11 = "SELECT NAME,ORD FROM PHASE_TEMPLATE WHERE TEMPLATE='"+phasetemplate+"' ORDER BY ORD ASC";
  ResultSet r11 = st11.executeQuery(q11);
  boolean frs = true;
  while (r11.next()) {
    if (frs) {
      Statement sti4 = applicationConnection.createStatement();
      String i4 = "UPDATE APPLICATION SET STATUS='"+r11.getString("NAME")+"' WHERE ID='"+applicationid+"'";
      sti4.executeUpdate(i4);
      sti4.close();
      frs=false;
    }
    Statement sti2 = applicationConnection.createStatement();
    String i2 = "INSERT INTO APPLICATION_ACTIVITY VALUES ('"+applicationid+"',"+r11.getInt("ORD")+","+r11.getInt("ORD")+",'"+r11.getString("NAME")+"','ROOT','"+BDATE+"','"+EDATE+"',0,"+nday+",'"+r11.getInt("ORD")+"','NONE','N')";
    sti2.executeUpdate(i2);
    sti2.close();
    Statement sti3 = applicationConnection.createStatement();
    if (r11.getInt("ORD")>0) {
      String i3 = "INSERT INTO APPLICATION_ACTIVITY_LINK VALUES ('"+applicationid+"',"+(r11.getInt("ORD")-1)+","+r11.getInt("ORD")+",'EB')";
      sti3.executeUpdate(i3);
      sti3.close();
    }
    Statement st21 = applicationConnection.createStatement();
    String q21 = "SELECT NAME,WORKLOAD,DOCLINK FROM PHASE_TEMPLATE_ACTIVITY WHERE TEMPLATE='"+phasetemplate+"' AND ORD="+r11.getInt("ORD")+" ORDER BY ACTORD ASC";
    ResultSet r21 = st21.executeQuery(q21);
    int nbactivity=1;
    while (r21.next()) {
      Statement sti5 = applicationConnection.createStatement();
      String i5 = "INSERT INTO APPLICATION_ACTIVITY VALUES ('"+applicationid+"',"+activity_id+","+activity_id+",'"+r21.getString("NAME")+"','"+r11.getString("ORD")+"','"+BDATE+"','"+EDATE+"',"+r21.getInt("WORKLOAD")+","+nday+",'"+r11.getInt("ORD")+"."+nbactivity+"','"+r21.getString("DOCLINK")+"','N')";
      sti5.executeUpdate(i5);
      sti5.close();
      nbactivity++;
      activity_id++;
    }
    st21.close();
  }
  st11.close();
}

public void addDocumentToActivity(String ID,String DOCLINK) throws Exception {
	  if (!DOCLINK.startsWith("http")) {
	    DOCLINK="http://"+DOCLINK;
	  }
	  Statement sti1 = applicationConnection.createStatement();
	  String i1 = "UPDATE APPLICATION_ACTIVITY SET DOCLINK='"+DOCLINK+"' WHERE APPLICATIONID='"+applicationid+"' AND ID="+ID;
	  sti1.executeUpdate(i1);
	  sti1.close();
	}

	public void renameTask(String ID,String NAME) throws Exception {
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "UPDATE APPLICATION_ACTIVITY SET NAME='"+NAME+"' WHERE APPLICATIONID='"+applicationid+"' AND ID="+ID;
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public void setTaskWorkloadByDay(String ID,String WORKLOAD,String DAY,String MONTH, String YEAR) throws Exception {
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "UPDATE APPLICATION_ACTIVITY_WORKLOAD SET WORKLOAD="+WORKLOAD+" WHERE APPLICATIONID='"+applicationid+"' AND DAY="+DAY+" AND MONTH="+MONTH+" AND YEAR="+YEAR+" AND ACTIVITYID="+ID ;
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public void deleteLink(String FROMID, String TOID) throws Exception {
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "DELETE FROM APPLICATION_ACTIVITY_LINK WHERE APPLICATIONID='"+applicationid+"' AND FROMID="+FROMID+" AND TOID="+TOID;
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public void createBaseline(String NAME) throws Exception {
	  Statement st12 = applicationConnection.createStatement();
	  String q12 = "SELECT ID FROM APPLICATION_BASELINE WHERE APPLICATIONID='"+applicationid+"' ORDER BY ID DESC";
	  ResultSet r12 = st12.executeQuery(q12);
	  int ID=0;
	  if (r12.next()) {
	    ID=r12.getInt("ID")+1;
	  }
	  st12.close();   
	  st12 = applicationConnection.createStatement();
	  q12 = "SELECT DATE_START,DATE_END FROM APPLICATION WHERE ID='"+applicationid+"'";
	  r12 = st12.executeQuery(q12);
	  String DATE_START="2011-01-01";
	  String DATE_END="2011-01-01";
	  if (r12.next()) {
	    DATE_START=r12.getString("DATE_START");
	    DATE_END=r12.getString("DATE_END");
	  }
	  st12.close();  
	  Calendar now = Calendar.getInstance();
	  String DATE_BASELINE=""+now.get(Calendar.YEAR)+"-"+now.get(Calendar.MONTH)+"-"+now.get(Calendar.DAY_OF_MONTH);
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "INSERT INTO APPLICATION_BASELINE VALUES("+ID+",'"+applicationid+"','"+DATE_START+"','"+DATE_END+"','"+DATE_BASELINE+"','"+NAME+"')";
	  sti2.executeUpdate(i2);
	  sti2.close();
	  st12 = applicationConnection.createStatement();
	  q12 = "SELECT * FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"'";
	  r12 = st12.executeQuery(q12);
	  while (r12.next()) {
	    sti2 = applicationConnection.createStatement();
	    i2 = "INSERT INTO APPLICATION_BASELINE_ACTIVITY VALUES("+ID+",'"+applicationid+"',"+r12.getInt("ID")+",'"+r12.getString("DATE_START")+"','"+r12.getString("DATE_END")+"',"+r12.getInt("WORKLOAD")+","+r12.getInt("DURATION")+",'"+r12.getString("WBS")+"','"+r12.getString("NAME")+"')";
	    sti2.executeUpdate(i2);
	    sti2.close();
	  }
	  st12.close();
	}

	public void linkTask(String FROMID,String TOID,String TYPE) throws Exception {
	  SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	  long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
	  Statement st15 = applicationConnection.createStatement();
	  String q15 = "SELECT DATE_START,DATE_END FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND ID='"+TOID+"'";
	  ResultSet r15 = st15.executeQuery(q15);
	  long tobdate=0;
	  long toedate=0;
	  if (r15.next()) {
	    tobdate=d1.parse(r15.getString("DATE_START")).getTime();
	    toedate=d1.parse(r15.getString("DATE_END")).getTime();
	  }
	  st15.close();
	  Statement st16 = applicationConnection.createStatement();
	  String q16 = "SELECT DATE_START,DATE_END FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND ID='"+FROMID+"'";
	  ResultSet r16 = st16.executeQuery(q16);
	  long frombdate=0;
	  long fromedate=0;
	  if (r16.next()) {
	    frombdate=d1.parse(r16.getString("DATE_START")).getTime();
	    fromedate=d1.parse(r16.getString("DATE_END")).getTime();
	  }
	  st16.close();
	  if (TYPE.equals("EB")) {
	    long nd = 0;
	    if (fromedate>tobdate) {
	      nd=(fromedate-tobdate)/MILLISECONDS_PER_DAY;
	    } else {
	      nd=(tobdate-fromedate)/MILLISECONDS_PER_DAY;
	      nd=-nd;
	    }
	    changeactivitydate(TOID,nd);
	  }
	  if (TYPE.equals("EE")) {
	    long nd = 0;
	    if (fromedate>toedate) {
	      nd=(fromedate-toedate)/MILLISECONDS_PER_DAY;
	    } else {
	      nd=(toedate-fromedate)/MILLISECONDS_PER_DAY;
	      nd=-nd;
	    }
	    changeactivitydate(TOID,nd);
	  }
	  if (TYPE.equals("BB")) {
	    long nd = 0;
	    if (frombdate>tobdate) {
	      nd=(frombdate-tobdate)/MILLISECONDS_PER_DAY;
	    } else {
	      nd=(tobdate-frombdate)/MILLISECONDS_PER_DAY;
	      nd=-nd;
	    }
	    changeactivitydate(TOID,nd);
	  }
	  if (TYPE.equals("BE")) {
	    long nd = 0;
	    if (frombdate>toedate) {
	      nd=(frombdate-toedate)/MILLISECONDS_PER_DAY;
	    } else {
	      nd=(toedate-frombdate)/MILLISECONDS_PER_DAY;
	      nd=-nd;
	    }
	    changeactivitydate(TOID,nd);
	  }
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "INSERT INTO APPLICATION_ACTIVITY_LINK VALUES('"+applicationid+"',"+FROMID+","+TOID+",'"+TYPE+"')";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public void changeTask(String ID, String NAME,String DATE_START,String DATE_END,String WORKLOAD)  throws Exception{
	  SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	  SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
	  long begincreneau = d1.parse(DATE_START).getTime();
	  long endcreneau = d2.parse(DATE_END).getTime();  
	  long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
	  long nday=(endcreneau-begincreneau)/MILLISECONDS_PER_DAY;
	  Statement st14 = applicationConnection.createStatement();
	  String q14 = "SELECT DATE_START,DATE_END FROM APPLICATION WHERE ID='"+applicationid+"'";
	  ResultSet r14 = st14.executeQuery(q14);
	  long bdate = begincreneau;
	  long edate = endcreneau;
	  if (r14.next()) {
	    bdate=d1.parse(r14.getString("DATE_START")).getTime();
	    edate=d1.parse(r14.getString("DATE_END")).getTime();
	  }
	  st14.close(); 
	  if (begincreneau<bdate) {
	    Statement sti20 = applicationConnection.createStatement();
	    String i20 = "UPDATE APPLICATION SET DATE_START='"+DATE_START+"' WHERE ID='"+applicationid+"'";
	    sti20.executeUpdate(i20);
	    sti20.close();
	  }
	  if (endcreneau>edate) {
	    Statement sti20 = applicationConnection.createStatement();
	    String i20 = "UPDATE APPLICATION SET DATE_END='"+DATE_END+"' WHERE ID='"+applicationid+"'";
	    sti20.executeUpdate(i20);
	    sti20.close();
	  }
	  Statement st15 = applicationConnection.createStatement();
	  String q15 = "SELECT DATE_START,DATE_END FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND ID='"+ID+"'";
	  ResultSet r15 = st15.executeQuery(q15);
	  bdate = begincreneau;
	  edate = endcreneau;
	  if (r15.next()) {
	    bdate=d1.parse(r15.getString("DATE_START")).getTime();
	    edate=d1.parse(r15.getString("DATE_END")).getTime();
	  }
	  st15.close();
	  if (bdate!=begincreneau) {
	    long nd = 0;
	    if (begincreneau>bdate) {
	      nd=(begincreneau-bdate)/MILLISECONDS_PER_DAY;
	    } else {
	      nd=(bdate-begincreneau)/MILLISECONDS_PER_DAY;
	      nd=-nd;
	    }
	    Statement st31 = applicationConnection.createStatement();  
	    String q31 = "SELECT TOID,TYPE FROM APPLICATION_ACTIVITY_LINK WHERE APPLICATIONID='"+applicationid+"' AND FROMID="+ID+"";
	    ResultSet r31 = st31.executeQuery(q31);
	    while(r31.next()) {  
	      if (r31.getString("TYPE").equals("BE")) {
	        changeactivitydate(r31.getString("TOID"),nd);
	      }
	      if (r31.getString("TYPE").equals("BB")) {
	        changeactivitydate(r31.getString("TOID"),nd);
	      }
	    }
	    st31.close();
	  }
	  if (edate!=endcreneau){
	    long nd = 0;
	    if (endcreneau>edate) {
	      nd=(endcreneau-edate)/MILLISECONDS_PER_DAY;
	    } else {
	      nd=(edate-endcreneau)/MILLISECONDS_PER_DAY;
	      nd=-nd;
	    }         
	    Statement st31 = applicationConnection.createStatement();  
	    String q31 = "SELECT TOID,TYPE FROM APPLICATION_ACTIVITY_LINK WHERE APPLICATIONID='"+applicationid+"' AND FROMID="+ID+"";
	    ResultSet r31 = st31.executeQuery(q31);
	    while(r31.next()) {  
	      if (r31.getString("TYPE").equals("EE")) {
	        changeactivitydate(r31.getString("TOID"),nd);
	      }
	      if (r31.getString("TYPE").equals("EB")) {
	        changeactivitydate(r31.getString("TOID"),nd);
	      }
	    }
	    st31.close();
	  } 
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "UPDATE APPLICATION_ACTIVITY SET NAME='"+NAME+"',DATE_START='"+DATE_START+"',DATE_END='"+DATE_END+"',WORKLOAD="+WORKLOAD+",DURATION="+nday+" WHERE APPLICATIONID='"+applicationid+"' AND ID="+ID;
	  sti2.executeUpdate(i2);
	  sti2.close();
	  checkactivitydate(ID);
	  Calendar start = Calendar.getInstance();
	  start.setTime(d1.parse(DATE_START));
	  Calendar end = Calendar.getInstance();
	  end.setTime(d2.parse(DATE_END));
	  int start_month = start.get(Calendar.MONTH);
	  int start_year = start.get(Calendar.YEAR);
	  int start_day = start.get(Calendar.DAY_OF_MONTH);
	  int end_month = end.get(Calendar.MONTH);
	  int end_year = end.get(Calendar.YEAR);   
	  int end_day = end.get(Calendar.DAY_OF_MONTH);
	  int nbmonth=1;
	  int currentmonth=start_month;
	  int nbdays[] = new int[255];
	  nbdays[nbmonth]=0;
	  long sdt = start.getTimeInMillis();
	  while (sdt<=end.getTimeInMillis()) {
	    sdt=sdt+MILLISECONDS_PER_DAY;
	    Calendar caltmp = Calendar.getInstance();
	    caltmp.setTimeInMillis(sdt);
	    nbdays[nbmonth]++;
	    if (caltmp.get(Calendar.MONTH)!=currentmonth) {
	      currentmonth=caltmp.get(Calendar.MONTH);
	      nbmonth++;
	      nbdays[nbmonth]=0;
	    }
	  }
	}

	public void addTask(String FATHER,String NAME,String DATE_START,String DATE_END,String WORKLOAD) throws Exception {
	  int ORD=0;
	  int ID=0;
	  Statement st12 = applicationConnection.createStatement();
	  String q12 = "SELECT ID FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' ORDER BY ID DESC";
	  ResultSet r12 = st12.executeQuery(q12);
	  if (r12.next()) {
	    ID=r12.getInt("ID")+1;
	  }
	  st12.close();      
	  Statement st13 = applicationConnection.createStatement();
	  String q13 = "SELECT ORD FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' ORDER BY ORD DESC";
	  ResultSet r13 = st13.executeQuery(q13);
	  if (r13.next()) {
	    ORD=r13.getInt("ORD")+1;
	  }
	  st13.close();  
	  SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	  SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
	  long begincreneau = d1.parse(DATE_START).getTime();
	  long endcreneau = d2.parse(DATE_END).getTime(); 
	  long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
	  long nday=(endcreneau-begincreneau)/MILLISECONDS_PER_DAY;
	  Statement st14 = applicationConnection.createStatement();
	  String q14 = "SELECT DATE_START,DATE_END FROM APPLICATION WHERE ID='"+applicationid+"'";
	  ResultSet r14 = st14.executeQuery(q14);
	  long bdate = begincreneau;
	  long edate = endcreneau;
	  if (r14.next()) {
	    bdate=d1.parse(r14.getString("DATE_START")).getTime();
	    edate=d1.parse(r14.getString("DATE_END")).getTime();
	  }
	  st14.close(); 
	  if (begincreneau<bdate) {
	    Statement sti20 = applicationConnection.createStatement();
	    String i20 = "UPDATE APPLICATION SET DATE_START='"+DATE_START+"' WHERE ID='"+applicationid+"'";
	    sti20.executeUpdate(i20);
	    sti20.close();
	  }
	  if (endcreneau>edate) {
	    Statement sti20 = applicationConnection.createStatement();
	    String i20 = "UPDATE APPLICATION SET DATE_END='"+DATE_END+"' WHERE ID='"+applicationid+"'";
	    sti20.executeUpdate(i20);
	    sti20.close();
	  }
	  String WBS="";
	  if (FATHER.equals("ROOT")) {
	    WBS=""+ORD;
	  } else {
	    Statement st141 = applicationConnection.createStatement();
	    String q141 = "SELECT WBS FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND ID="+FATHER;
	    ResultSet r141 = st141.executeQuery(q141);
	    if (r141.next()) {
	      WBS=r141.getString("WBS");
	    }
	    st141.close();
	    WBS=WBS+"."+ORD;
	  }
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "INSERT INTO APPLICATION_ACTIVITY VALUES ('"+applicationid+"',"+ID+","+ORD+",'"+NAME+"','"+FATHER+"','"+DATE_START+"','"+DATE_END+"',"+WORKLOAD+","+nday+",'"+WBS+"','','')";
	  sti2.executeUpdate(i2);
	  sti2.close();
	  Statement sti20 = applicationConnection.createStatement();
	  String i20 = "UPDATE APPLICATION_ACTIVITY SET WORKLOAD=0 WHERE APPLICATIONID='"+applicationid+"' AND ID="+FATHER;
	  sti20.executeUpdate(i20);
	  sti20.close();
	  String father_start = calculatestartdate(FATHER);
	  String father_end = calculateenddate(FATHER);
	  sti20 = applicationConnection.createStatement();
	  i20 = "UPDATE APPLICATION_ACTIVITY SET DATE_START='"+father_start+"',DATE_END='"+father_end+"' WHERE APPLICATIONID='"+applicationid+"' AND ID="+FATHER;
	  sti20.executeUpdate(i20);
	  sti20.close();
	  Calendar start = Calendar.getInstance();
	  start.setTime(d1.parse(DATE_START));
	  Calendar end = Calendar.getInstance();
	  end.setTime(d2.parse(DATE_END));
	  int start_month = start.get(Calendar.MONTH);
	  int start_year = start.get(Calendar.YEAR);
	  int start_day = start.get(Calendar.DAY_OF_MONTH);
	  int end_month = end.get(Calendar.MONTH);
	  int end_year = end.get(Calendar.YEAR);  
	  int end_day = end.get(Calendar.DAY_OF_MONTH); 
	  int nbmonth=1;
	  int currentmonth=start_month;
	  int nbdays[] = new int[255];
	  nbdays[nbmonth]=0;
	  long sdt = start.getTimeInMillis();
	  while (sdt<=end.getTimeInMillis()) {
	    sdt=sdt+MILLISECONDS_PER_DAY;
	    Calendar caltmp = Calendar.getInstance();
	    caltmp.setTimeInMillis(sdt);
	    if ((caltmp.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (caltmp.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
	      nbdays[nbmonth]++;
	    }
	    if (caltmp.get(Calendar.MONTH)!=currentmonth) {
	      currentmonth=caltmp.get(Calendar.MONTH);
	      nbmonth++;
	      nbdays[nbmonth]=0;
	    }
	  }
	  currentmonth=1;
	  int tmpyear=start_year;
	  int tmpmonth=start_month;
	  int tmpday=start_day;
	  long sumwrkl=0;
	  while (tmpyear!=end_year || tmpmonth!=end_month || tmpday!=end_day) {
	    long wrkl =  Integer.parseInt(WORKLOAD)/nday;
	    sumwrkl=sumwrkl+wrkl;
	    tmpday++;;
	    Calendar monthday = Calendar.getInstance();
	    monthday.setTime(d1.parse(""+tmpyear+"-"+tmpmonth+"-"+tmpday));
	    if (tmpday>monthday.getActualMaximum(Calendar.DAY_OF_MONTH)) {
	      tmpday=1;
	      tmpmonth++;
	      currentmonth++;
	    } 
	    if (tmpmonth>11) {
	      tmpyear++;
	      tmpmonth=0;
	    } 
	  }
	  long wrkl =  Integer.parseInt(WORKLOAD)-sumwrkl;
	}

	public void setPlanningFromTemplate(String TEMPLATEID) throws Exception {
	  String BDATE="2011-01-01";
	  String EDATE="2011-01-01";
	  Statement st12 = applicationConnection.createStatement();
	  String q12 = "SELECT DATE_START,DATE_END FROM APPLICATION WHERE ID='"+applicationid+"'";
	  ResultSet r12 = st12.executeQuery(q12);
	  if (r12.next()) {
	    BDATE=r12.getString("DATE_START");
	    EDATE=r12.getString("DATE_END");
	  }
	  st12.close();
	  SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	  SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
	  long begincreneau = d1.parse(BDATE).getTime();
	  long endcreneau = d2.parse(EDATE).getTime();  
	  long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
	  long nday=0;
	  for (long delta = begincreneau; delta <= endcreneau; delta = delta+ MILLISECONDS_PER_DAY) {
	    Calendar cday = Calendar.getInstance();
	    cday.setTimeInMillis(delta);
	    if ((cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
	      nday++;
	    }
	  }
	  Statement sti1 = applicationConnection.createStatement();
	  String i1 = "DELETE FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"'";
	  sti1.executeUpdate(i1);
	  sti1.close();
	  Statement st11 = applicationConnection.createStatement();
	  String q11 = "SELECT NAME,ORD FROM PHASE_TEMPLATE WHERE TEMPLATE='"+TEMPLATEID+"' ORDER BY ORD ASC";
	  ResultSet r11 = st11.executeQuery(q11);
	  while (r11.next()) {
	    Statement sti2 = applicationConnection.createStatement();
	    String i2 = "INSERT INTO APPLICATION_ACTIVITY VALUES ('"+applicationid+"',"+r11.getInt("ORD")+","+r11.getInt("ORD")+",'"+r11.getString("NAME")+"','ROOT','"+BDATE+"','"+EDATE+"',0,"+nday+",'"+r11.getInt("ORD")+"','','')";
	    sti2.executeUpdate(i2);
	    sti2.close();
	    Statement sti3 = applicationConnection.createStatement();
	    if (r11.getInt("ORD")>0) {
	      String i3 = "INSERT INTO APPLICATION_ACTIVITY_LINK VALUES ('"+applicationid+"',"+(r11.getInt("ORD")-1)+","+r11.getInt("ORD")+",'EB')";
	      sti3.executeUpdate(i3);
	      sti3.close();
	    }
	  }
	  st11.close();
	}

	public void deleteactivity(String ID) throws Exception {
	  Statement st31 = applicationConnection.createStatement();  
	  String q31 = "SELECT ID FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND FATHER='"+ID+"'";
	  ResultSet r31 = st31.executeQuery(q31);
	  while(r31.next()) {  
	    deleteactivity(r31.getString("ID"));
	  }
	  st31.close();
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "DELETE FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND ID="+ID;
	  sti2.executeUpdate(i2);
	  sti2.close();
	}
	  
	public void checkactivitydate(String ID) throws Exception {
	  if (!ID.equals("ROOT")) {
	    Statement st30 = applicationConnection.createStatement();  
	    String q30 = "SELECT ID,DATE_START,DATE_END,FATHER FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND ID='"+ID+"'";
	    ResultSet r30 = st30.executeQuery(q30);
	    if (r30.next()) { 
	      String DATE_START = r30.getString("DATE_START");
	      String DATE_END = r30.getString("DATE_END");
	      if (!r30.getString("FATHER").equals("ROOT")) {
	        Statement st31 = applicationConnection.createStatement();  
	        String q31 = "SELECT ID,DATE_START,DATE_END,FATHER FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND ID='"+r30.getString("FATHER")+"'";
	        ResultSet r31 = st31.executeQuery(q31);
	        if (r31.next()) { 
	          SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	          long bdate = d1.parse(DATE_START).getTime();
	          long fbdate = d1.parse(r31.getString("DATE_START")).getTime();
	          if (bdate<fbdate) {
	            Statement sti1 = applicationConnection.createStatement();
	            String i1 = "UPDATE APPLICATION_ACTIVITY SET DATE_START='"+r30.getString("DATE_START")+"' WHERE APPLICATIONID='"+applicationid+"' AND ID='"+r30.getString("FATHER")+"'";
	            sti1.executeUpdate(i1);
	            sti1.close();          
	          }
	          long edate = d1.parse(DATE_END).getTime();
	          long fedate = d1.parse(r31.getString("DATE_END")).getTime();
	          if (edate>fedate) {
	            Statement sti1 = applicationConnection.createStatement();
	            String i1 = "UPDATE APPLICATION_ACTIVITY SET DATE_END='"+r30.getString("DATE_END")+"' WHERE APPLICATIONID='"+applicationid+"' AND ID='"+r30.getString("FATHER")+"'";
	            sti1.executeUpdate(i1);
	            sti1.close();          
	          }
	        }
	        st31.close();
	      }
	      checkactivitydate(r30.getString("FATHER"));
	    }
	    st30.close();
	  }
	}

	public void changeactivitydate(String ID, long nbdays) throws Exception {
	  Statement st30 = applicationConnection.createStatement();  
	  String q30 = "SELECT ID,DATE_START,DATE_END FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND ID='"+ID+"'";
	  ResultSet r30 = st30.executeQuery(q30);
	  String previous_start_date="";
	  String previous_end_date="";
	  if (r30.next()) { 
	    previous_start_date = r30.getString("DATE_START");
	    previous_end_date = r30.getString("DATE_END");
	  }
	  st30.close();
	  SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	  long bpdate = d1.parse(previous_start_date).getTime();
	  long epdate = d1.parse(previous_end_date).getTime();
	  long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
	  if (nbdays>0) {
	    for (int i = 0; i<nbdays ; i++) {
	      Calendar cday = Calendar.getInstance();
	      cday.setTimeInMillis(bpdate+MILLISECONDS_PER_DAY);
	      while ((cday.get(Calendar.DAY_OF_WEEK)==Calendar.SUNDAY) || (cday.get(Calendar.DAY_OF_WEEK)==Calendar.SATURDAY)) {
	        bpdate=bpdate+MILLISECONDS_PER_DAY;
	        epdate=epdate+MILLISECONDS_PER_DAY;
	        cday.setTimeInMillis(bpdate+MILLISECONDS_PER_DAY);
	      }
	      bpdate=bpdate+MILLISECONDS_PER_DAY;
	      epdate=epdate+MILLISECONDS_PER_DAY;
	    }
	  } else {
	    for (int i = 0; i>nbdays ; i--) {
	      Calendar cday = Calendar.getInstance();
	      cday.setTimeInMillis(bpdate-MILLISECONDS_PER_DAY);
	      while ((cday.get(Calendar.DAY_OF_WEEK)==Calendar.SUNDAY) || (cday.get(Calendar.DAY_OF_WEEK)==Calendar.SATURDAY)) {
	        bpdate=bpdate-MILLISECONDS_PER_DAY;
	        epdate=epdate-MILLISECONDS_PER_DAY;
	        cday.setTimeInMillis(bpdate-MILLISECONDS_PER_DAY); 
	      }
	      bpdate=bpdate-MILLISECONDS_PER_DAY;
	      epdate=epdate-MILLISECONDS_PER_DAY;
	    }
	  }
	  Calendar nbdate= Calendar.getInstance();
	  nbdate.setTimeInMillis(bpdate);
	  Calendar nedate= Calendar.getInstance();
	  nedate.setTimeInMillis(epdate);
	  Statement sti1 = applicationConnection.createStatement();
	  String i1 = "UPDATE APPLICATION_ACTIVITY SET DATE_START='"+nbdate.get(Calendar.YEAR)+"-"+(nbdate.get(Calendar.MONTH)+1)+"-"+nbdate.get(Calendar.DAY_OF_MONTH)+"',DATE_END='"+nedate.get(Calendar.YEAR)+"-"+(nedate.get(Calendar.MONTH)+1)+"-"+nedate.get(Calendar.DAY_OF_MONTH)+"' WHERE APPLICATIONID='"+applicationid+"' AND ID='"+ID+"'";
	  sti1.executeUpdate(i1);
	  sti1.close();
	  checkactivitydate(ID);
	  Statement st31 = applicationConnection.createStatement();  
	  String q31 = "SELECT TOID,TYPE FROM APPLICATION_ACTIVITY_LINK WHERE APPLICATIONID='"+applicationid+"' AND FROMID='"+ID+"'";
	  ResultSet r31 = st31.executeQuery(q31);
	  while(r31.next()) {  
	    changeactivitydate(r31.getString("TOID"),nbdays);
	  }
	  st31.close();
	}


	public String calculatestartdate(String ID) throws Exception {
	  String startdate="";
	  Statement st31 = applicationConnection.createStatement();  
	  String q31 = "SELECT ID,DATE_START FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND FATHER='"+ID+"'";
	  ResultSet r31 = st31.executeQuery(q31);
	  while(r31.next()) {
	    SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	    long currentdate = d1.parse(r31.getString("DATE_START")).getTime();
	    String dd = calculatestartdate(r31.getString("ID"));
	    if (startdate.equals("")) {
	      startdate=r31.getString("DATE_START");
	    } else {
	      long sd = d1.parse(startdate).getTime();
	      if (currentdate<sd) {
	        startdate=r31.getString("DATE_START");
	      }
	    }
	    if (!dd.equals("")) {
	      long downdate = d1.parse(dd).getTime();
	      if (currentdate<downdate) {
	        startdate=r31.getString("DATE_START");
	      }
	    }
	  }
	  st31.close();
	  return startdate;
	}

	public String calculateenddate(String ID) throws Exception {
	  String startdate="";
	  Statement st31 = applicationConnection.createStatement();  
	  String q31 = "SELECT ID,DATE_END FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND FATHER='"+ID+"'";
	  ResultSet r31 = st31.executeQuery(q31);
	  while(r31.next()) {
	    SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	    long currentdate = d1.parse(r31.getString("DATE_END")).getTime();
	    String dd = calculateenddate(r31.getString("ID"));
	    if (startdate.equals("")) {
	      startdate=r31.getString("DATE_END");
	    } else {
	      long sd = d1.parse(startdate).getTime();
	      if (currentdate>sd) {
	        startdate=r31.getString("DATE_END");
	      }
	    }
	    if (!dd.equals("")) {
	      long downdate = d1.parse(dd).getTime();
	      if (currentdate>downdate) {
	        startdate=r31.getString("DATE_END");
	      }
	    }
	  }
	  st31.close();
	  return startdate;
	}



	public int loadMSPFile(String saveFile) throws Exception {
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "DELETE FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"'";
	  sti2.executeUpdate(i2);
	  sti2 = applicationConnection.createStatement();
	  i2 = "DELETE FROM APPLICATION_ACTIVITY_LINK WHERE APPLICATIONID='"+applicationid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	  int error_format=0;
	  Namespace ns = Namespace.getNamespace("http://schemas.microsoft.com/project");
	  SAXBuilder builder = new SAXBuilder();
	  try {
	    Document doc = builder.build("/data/tomcat/strppm/upload/"+saveFile);
	    Element rootdoc = doc.getRootElement();
	    String resources[] = new String[1000];
	    Element resroot=rootdoc.getChild("Resources",ns);        
	    List reslist=resroot.getChildren();
	    Iterator r = reslist.iterator();
	    while (r.hasNext()) {
	      Element s = (Element) r.next();
	      boolean canres=true;
	      String RESNAME="";
	      int RESUID=0;
	      Element resname = s.getChild("Name",ns); 
	      if (resname==null) {
	        canres=false;
	      } else {
	        RESNAME=resname.getText();
	      }
	      Element resuid = s.getChild("UID",ns); 
	      if (resuid==null) {
	        canres=false;
	      } else {
	        RESUID=Integer.parseInt(resuid.getText());
	      }
	      if (canres) {
	        resources[RESUID]=RESNAME;
	      }
	    }
	    Element taskroot=rootdoc.getChild("Tasks",ns);        
	    List tasklist=taskroot.getChildren();
	    Iterator i = tasklist.iterator();
	    int ord=0;
	    while (i.hasNext() && error_format==0) {
	      Element p = (Element) i.next();
	      String UID="";
	      String WBS="";
	      String NAME="";
	      String FATHER="ROOT";
	      String DATE_START="2011-01-01";
	      String DATE_END="2011-01-01";
	      int WORKLOAD=0;
	      boolean cancreate=true;
	      Element taskname = p.getChild("Name",ns); 
	      if (taskname==null) {
	        cancreate=false;
	      } else {
	        NAME=taskname.getText();
	      }
	      Element taskuid = p.getChild("UID",ns); 
	      if (taskuid==null) {
	        cancreate=false;
	      } else {
	        UID=taskuid.getText();
	      }  
	      Element taskstart = p.getChild("Start",ns); 
	      if (taskstart==null) {
	        cancreate=false;
	      } else {
	        String dstmp=taskstart.getText();
	        DATE_START=dstmp.substring(0,dstmp.lastIndexOf("T"));
	      }  
	      Element taskfinish = p.getChild("Finish",ns); 
	      if (taskfinish==null) {
	        cancreate=false;
	      } else {
	        String dftmp=taskfinish.getText();
	        DATE_END=dftmp.substring(0,dftmp.lastIndexOf("T"));
	      }  
	      Element taskworkload = p.getChild("Work",ns); 
	      if (taskworkload==null) {
	        cancreate=false;
	      } else {
	        String wrktmp=taskworkload.getText();
	        String wrktmp2=wrktmp.substring(0,wrktmp.lastIndexOf("H"));
	        WORKLOAD=Integer.parseInt(wrktmp2.substring(2,wrktmp2.length()));
	      }  
	      Element taskwbs = p.getChild("WBS",ns); 
	      if (taskwbs==null) {
	        cancreate=false;
	      } else {
	        WBS=taskwbs.getText();
	      }  
	      if (WBS.lastIndexOf(".")!=-1) {
	        String fatherWBS=WBS.substring(0,WBS.lastIndexOf("."));
	        Statement st101 = applicationConnection.createStatement();
	        String q101 = "SELECT ID FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"' AND WBS='"+fatherWBS+"'";
	        ResultSet r101 = st101.executeQuery(q101);
	        if (r101.next()) {
	          FATHER=r101.getString("ID");
	        }
	        st101.close();
	      } else {
	        if (!UID.equals("0")) {
	          Statement st101 = applicationConnection.createStatement();
	          String q101 = "SELECT TEMPLATE FROM APPLICATION WHERE ID='"+applicationid+"'";
	          ResultSet r101 = st101.executeQuery(q101);          
	          if (r101.next()) {
	            Statement st102 = applicationConnection.createStatement();
	            String q102 = "SELECT NAME FROM PHASE_TEMPLATE WHERE TEMPLATE='"+r101.getString("TEMPLATE")+"' AND NAME='"+NAME+"'";
	            ResultSet r102 = st102.executeQuery(q102);
	            if (!r102.next()) {
	              error_format=1;
	              String BDATE="2011-01-01";
	              String EDATE="2011-01-01";
	              Statement st12 = applicationConnection.createStatement();
	              String q12 = "SELECT DATE_START,DATE_END FROM APPLICATION WHERE ID='"+applicationid+"'";
	              ResultSet r12 = st12.executeQuery(q12);
	              if (r12.next()) {
	                BDATE=r12.getString("DATE_START");
	                EDATE=r12.getString("DATE_END");
	              }
	              st12.close();
	              SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	              SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
	              long begincreneau = d1.parse(BDATE).getTime();
	              long endcreneau = d2.parse(EDATE).getTime();  
	              long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
	              long nday=0;
	              for (long delta = begincreneau; delta <= endcreneau; delta = delta+ MILLISECONDS_PER_DAY) {
	                Calendar cday = Calendar.getInstance();
	                cday.setTimeInMillis(delta);
	                if ((cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
	                  nday++;
	                }
	              }
	              Statement sti20 = applicationConnection.createStatement();
	              String i20 = "DELETE FROM APPLICATION_ACTIVITY WHERE APPLICATIONID='"+applicationid+"'";
	              sti20.executeUpdate(i20);
	              sti20 = applicationConnection.createStatement();
	              i20 = "DELETE FROM APPLICATION_ACTIVITY_LINK WHERE APPLICATIONID='"+applicationid+"'";
	              sti20.executeUpdate(i20);
	              sti20.close();
	              Statement st11 = applicationConnection.createStatement();
	              String q11 = "SELECT NAME,ORD FROM PHASE_TEMPLATE WHERE TEMPLATE='"+r101.getString("TEMPLATE")+"' ORDER BY ORD ASC";
	              ResultSet r11 = st11.executeQuery(q11);
	              while (r11.next()) {
	                Statement sti21 = applicationConnection.createStatement();
	                String i21 = "INSERT INTO APPLICATION_ACTIVITY VALUES ('"+applicationid+"',"+r11.getInt("ORD")+","+r11.getInt("ORD")+",'"+r11.getString("NAME")+"','ROOT','"+BDATE+"','"+EDATE+"',0,"+nday+",'"+r11.getInt("ORD")+"','','')";
	                sti21.executeUpdate(i21);
	                sti21.close();
	                Statement sti31 = applicationConnection.createStatement();
	                if (r11.getInt("ORD")>0) {
	                  String i31 = "INSERT INTO APPLICATION_ACTIVITY_LINK VALUES ('"+applicationid+"',"+(r11.getInt("ORD")-1)+","+r11.getInt("ORD")+",'EB')";
	                  sti31.executeUpdate(i31);
	                  sti31.close();
	                }
	              }
	              st11.close();
	              st102.close();
	            } else {
	              error_format=999;
	            }
	            st101.close();
	          }
	        }
	        SimpleDateFormat d1= new SimpleDateFormat("yyyy-MM-dd");
	        SimpleDateFormat d2= new SimpleDateFormat("yyyy-MM-dd");
	        long begincreneau = d1.parse(DATE_START).getTime();
	        long endcreneau = d2.parse(DATE_END).getTime(); 
	        long MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;
	        long nday=0;
	        for (long delta = begincreneau; delta <= endcreneau; delta = delta+ MILLISECONDS_PER_DAY) {
	          Calendar cday = Calendar.getInstance();
	          cday.setTimeInMillis(delta);
	          if ((cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (cday.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
	            nday++;
	          }
	        }
	        if (cancreate && error_format==0) {
	          sti2 = applicationConnection.createStatement();
	          i2 = "INSERT INTO APPLICATION_ACTIVITY VALUES('"+applicationid+"',"+UID+","+ord+",'"+NAME+"','"+FATHER+"','"+DATE_START+"','"+DATE_END+"',"+WORKLOAD+","+nday+",'"+WBS+"','','')";
	          sti2.executeUpdate(i2);
	          sti2.close();
	          Calendar start = Calendar.getInstance();
	          start.setTime(d1.parse(DATE_START));
	          Calendar end = Calendar.getInstance();
	          end.setTime(d2.parse(DATE_END));
	          int start_month = start.get(Calendar.MONTH);
	          int start_year = start.get(Calendar.YEAR);
	          int end_month = end.get(Calendar.MONTH);
	          int end_year = end.get(Calendar.YEAR);   
	          int nbmonth=1;
	          int currentmonth=start_month;
	          int nbdays[] = new int[255];
	          nbdays[nbmonth]=0;
	          long sdt = start.getTimeInMillis();
	          while (sdt<=end.getTimeInMillis()) {
	            sdt=sdt+MILLISECONDS_PER_DAY;
	            Calendar caltmp = Calendar.getInstance();
	            caltmp.setTimeInMillis(sdt);
	            if ((caltmp.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY) && (caltmp.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY)) {
	              nbdays[nbmonth]++;
	            }
	            if (caltmp.get(Calendar.MONTH)!=currentmonth) {
	              currentmonth=caltmp.get(Calendar.MONTH);
	              nbmonth++;
	              nbdays[nbmonth]=0;
	            }
	          }
	          ord++;
	          List linked = p.getChildren("PredecessorLink",ns);
	          Iterator j = linked.iterator();
	          while (j.hasNext() && error_format==0) {
	            Element q = (Element) j.next();
	            String FROMID="";
	            String TOID=UID;
	            String TYPE="";
	            boolean canlink=true;
	            Element taskpuid = q.getChild("PredecessorUID",ns); 
	            if (taskpuid==null) {
	              canlink=false;
	            } else {
	              FROMID=taskpuid.getText();
	            }
	            Element tasktype = q.getChild("Type",ns); 
	            if (tasktype==null) {
	              canlink=false;
	            } else {
	              if (tasktype.getText().equals("0")) {
	                TYPE="EE";
	              }
	              if (tasktype.getText().equals("1")) {
	                TYPE="EB";
	              }
	              if (tasktype.getText().equals("2")) {
	                TYPE="BE";
	              }
	              if (tasktype.getText().equals("3")) {
	                TYPE="BB";
	              }
	            }  
	            if (canlink) {
	              sti2 = applicationConnection.createStatement();
	              i2 = "INSERT INTO APPLICATION_ACTIVITY_LINK VALUES('"+applicationid+"',"+FROMID+","+TOID+",'"+TYPE+"')";
	              sti2.executeUpdate(i2);
	              sti2.close();
	            }
	          }
	        }
	      }

	    }
	  } catch (Exception e) {
	    error_format=2;
	  }
	  return error_format;
	}
	
	public void addBudget(String description,String type, String amount,String cer,String datebud) throws Exception {
	  int ORD=0;
	  Statement st43 = applicationConnection.createStatement();
	  String q43 = "SELECT ID FROM APPLICATION_BUDGET WHERE APPLICATIONID='"+applicationid+"' ORDER BY ID DESC";
	  ResultSet r43 = st43.executeQuery(q43);
	  if (r43.next()) {
	    ORD=r43.getInt("ID")+1;
	  }
	  st43.close();
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "INSERT INTO APPLICATION_BUDGET VALUES('"+applicationid+"',"+ORD+",'"+description+"','"+type+"',"+amount+",'"+cer+"','"+datebud+"')";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public void modifyBudget(String budgetid,String description,String type,String amount,String cer,String datebud) throws Exception {
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "UPDATE APPLICATION_BUDGET SET DESCRIPTION='"+description+"',TYPE='"+type+"',AMOUNT="+amount+",CER='"+cer+"',DATEBUD='"+datebud+"' WHERE APPLICATIONID='"+applicationid+"' AND ID="+budgetid;
	  sti2.executeUpdate(i2);
	  sti2.close();
	}
	public void addExpense(String description,String type, String amount,String dateexp,String vendorid,String invoice) throws Exception {
	  int ORD=0;
	  Statement st43 = applicationConnection.createStatement();
	  String q43 = "SELECT ID FROM APPLICATION_EXPENSE WHERE APPLICATIONID='"+applicationid+"' ORDER BY ID DESC";
	  ResultSet r43 = st43.executeQuery(q43);
	  if (r43.next()) {
	    ORD=r43.getInt("ID")+1;
	  }
	  st43.close();
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "INSERT INTO APPLICATION_EXPENSE VALUES('"+applicationid+"',"+ORD+",'"+description+"','"+type+"',"+amount+",'"+dateexp+"','"+vendorid+"','"+invoice+"')";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public void modifyExpense(String expenseid,String description,String type,String amount, String dateexp,String vendorid,String invoice) throws Exception {
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "UPDATE APPLICATION_EXPENSE SET DESCRIPTION='"+description+"',TYPE='"+type+"',AMOUNT="+amount+",DATEEXP='"+dateexp+"',VENDORID='"+vendorid+"',INVOICE='"+invoice+"' WHERE APPLICATIONID='"+applicationid+"' AND ID="+expenseid;
	  sti2.executeUpdate(i2);
	  sti2.close();
	}
	public void deleteBudget(String budgetid) throws Exception {
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "DELETE FROM APPLICATION_BUDGET WHERE ID="+budgetid+" AND APPLICATIONID='"+applicationid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}
	public void deleteExpense(String expenseid) throws Exception {
	  Statement sti2 = applicationConnection.createStatement();
	  String i2 = "DELETE FROM APPLICATION_EXPENSE WHERE ID="+expenseid+" AND APPLICATIONID='"+applicationid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}
}
