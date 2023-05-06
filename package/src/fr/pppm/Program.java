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

public class Program {

Connection programConnection;
String programid;
String name;
String description;
String fownerid;
String date_start;
String date_end;
String status;
String closed;

public Program(Connection Conn) throws Exception {
  programConnection=Conn;
  int ORD=0;
  Statement st43 = programConnection.createStatement();
  String q43 = "SELECT ID,SEQ FROM INDX WHERE ID='PROGRAM'";
  ResultSet r43 = st43.executeQuery(q43);
  if (r43.next()) {
    ORD=r43.getInt("SEQ");
  }
  st43.close();
  Statement sti1 = programConnection.createStatement();
  String i1 = "UPDATE INDX SET SEQ="+(ORD+1)+" WHERE ID='PROGRAM'";
  sti1.executeUpdate(i1);
  sti1.close();
  programid="PGM"+ORD;
  name="";
  description="";
  status="REQUEST";
  fownerid="";
  date_start="2011-01-01";
  date_end="2011-01-01";
  closed="N";
  Statement sti2 = programConnection.createStatement();
  String i2 = "INSERT INTO PROGRAM VALUES('"+programid+"','"+name+"','"+description+"','"+fownerid+"','"+date_start+"','"+date_end+"','"+status+"','"+closed+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public Program (Connection Conn, String pid) throws Exception {
	  programConnection=Conn;
	  programid = pid;
	  Statement st12 = programConnection.createStatement();
	  String q12 = "SELECT * FROM PROGRAM WHERE ID='"+programid+"'";
	  ResultSet r12 = st12.executeQuery(q12);
	  if (r12.next()) {
	    name=r12.getString("NAME");
	    description=r12.getString("DESCRIPTION");
	    fownerid=r12.getString("FOWNERID");
	    date_start=r12.getString("DATE_START");
	    date_end=r12.getString("DATE_END");
	    status=r12.getString("STATUS");
	    closed=r12.getString("CLOSED");
	  }
	  st12.close();
	}

	public void refresh () throws Exception {
	  Statement st12 = programConnection.createStatement();
	  String q12 = "SELECT * FROM PROGRAM WHERE ID='"+programid+"'";
	  ResultSet r12 = st12.executeQuery(q12);
	  if (r12.next()) {
	    name=r12.getString("NAME");
	    description=r12.getString("DESCRIPTION");
	    fownerid=r12.getString("FOWNERID");
	    date_start=r12.getString("DATE_START");
	    date_end=r12.getString("DATE_END");
	    status=r12.getString("STATUS");
	    closed=r12.getString("CLOSED");
	  }
	  st12.close();
	}

	public String getId() {
	  return programid;
	}

	public String getName() {
	  return name;
	}

	public void setName(String n) throws Exception {
	  name = n;
	  Statement sti2 = programConnection.createStatement();
	  String i2 = "UPDATE PROGRAM SET NAME='"+n+"' WHERE ID='"+programid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getStatus() {
	  return status;
	}

	public void setStatus(String s) throws Exception {
	  status = s;
	  Statement sti2 = programConnection.createStatement();
	  String i2 = "UPDATE PROGRAM SET STATUS='"+s+"' WHERE ID='"+programid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}


	public String getDescription() {
	  return description;
	}

	public void setDescription(String d) throws Exception {
	  description = d;
	  Statement sti2 = programConnection.createStatement();
	  String i2 = "UPDATE PROGRAM SET DESCRIPTION='"+d+"' WHERE ID='"+programid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}


	public String getFownerid() {
	  return fownerid;
	}

	public void setFownerid(String o) throws Exception {
	  fownerid = o;
	  Statement sti2 = programConnection.createStatement();
	  String i2 = "UPDATE PROGRAM SET FOWNERID='"+o+"' WHERE ID='"+programid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}


	public String getDatestart() {
	  return date_start;
	}

	public void setDatestart(String d) throws Exception {
	  date_start = d;
	  Statement sti2 = programConnection.createStatement();
	  String i2 = "UPDATE PROGRAM SET DATE_START='"+d+"' WHERE ID='"+programid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getDateend() {
	  return date_end;
	}

	public void setDateend(String d) throws Exception {
	  date_end = d;
	  Statement sti2 = programConnection.createStatement();
	  String i2 = "UPDATE PROGRAM SET DATE_END='"+d+"' WHERE ID='"+programid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getClosed() {
	  return closed;
	}

	public void setClosed(String c) throws Exception {
	  closed = c;
	  Statement sti2 = programConnection.createStatement();
	  String i2 = "UPDATE PROGRAM SET CLOSED='"+c+"' WHERE ID='"+programid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

public void createBaseline(String baselinename) throws Exception {
  Statement st12 = programConnection.createStatement();
  String q12 = "SELECT ID FROM PROGRAM_BASELINE WHERE PROGRAMID='"+programid+"' ORDER BY ID DESC";
  ResultSet r12 = st12.executeQuery(q12);
  int ID=0;
  if (r12.next()) {
    ID=r12.getInt("ID")+1;
  }
  st12.close();   
  st12 = programConnection.createStatement();
  q12 = "SELECT DATE_START,DATE_END FROM PROGRAM WHERE ID='"+programid+"'";
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
  Statement sti2 = programConnection.createStatement();
  String i2 = "INSERT INTO PROGRAM_BASELINE VALUES("+ID+",'"+programid+"','"+DATE_START+"','"+DATE_END+"','"+DATE_BASELINE+"','"+baselinename+"')";
  sti2.executeUpdate(i2);
  sti2.close();
  Statement st13 = programConnection.createStatement();
  String q13 = "SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+programid+"'";
  ResultSet r13 = st13.executeQuery(q13);
  while (r13.next()) { 
    st12 = programConnection.createStatement();
    q12 = "SELECT * FROM PROJECT_ACTIVITY WHERE PROJECTID='"+r13.getString("PROJECTID")+"' AND FATHER='ROOT'";
    r12 = st12.executeQuery(q12);
    while (r12.next()) {
      sti2 = programConnection.createStatement();
      i2 = "INSERT INTO PROGRAM_BASELINE_ACTIVITY VALUES("+ID+",'"+programid+"','"+r13.getString("PROJECTID")+"',"+r12.getInt("ID")+",'"+r12.getString("DATE_START")+"','"+r12.getString("DATE_END")+"',"+r12.getInt("WORKLOAD")+","+r12.getInt("DURATION")+",'"+r12.getString("WBS")+"','"+r12.getString("NAME")+"')";
      sti2.executeUpdate(i2);
      sti2.close();
    }
    st12.close();
  }
  st13.close();
}


public void addProject(String projectid) throws Exception{
  Statement sti2 = programConnection.createStatement();
  String i2 = "INSERT INTO PRJPGM VALUES ('"+projectid+"','"+programid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void deleteProject(String projectid) throws Exception {
  Statement sti2 = programConnection.createStatement();
  String i2 = "DELETE FROM PRJPGM WHERE PROJECTID='"+projectid+"' AND PROGRAMID='"+programid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void addBPO(String bpoid) throws Exception {
  Statement sti2 = programConnection.createStatement();
  String i2 = "INSERT INTO PGMBPO VALUES ('"+bpoid+"','"+programid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void deleteBPO(String bpoid) throws Exception {
  Statement sti2 = programConnection.createStatement();
  String i2 = "DELETE FROM PGMBPO WHERE EMPLOYEEID='"+bpoid+"' AND PROGRAMID='"+programid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void addPM(String pmid) throws Exception {
  Statement sti2 = programConnection.createStatement();
  String i2 = "INSERT INTO PGMPM VALUES ('"+pmid+"','"+programid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void deletePM(String pmid) throws Exception {
  Statement sti2 = programConnection.createStatement();
  String i2 = "DELETE FROM PGMPM WHERE EMPLOYEEID='"+pmid+"' AND PROGRAMID='"+programid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void closeProgram(String closed) throws Exception {
  Statement sti2 = programConnection.createStatement();
  String i2="";
  i2 = "UPDATE PROGRAM SET CLOSED='"+closed.substring(0,1)+"' WHERE ID='"+programid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void addRequestPortfolio(String portfolioid) throws Exception{
  Statement sti2 = programConnection.createStatement();
  String i2 = "INSERT INTO PGMPOR VALUES ('"+programid+"','"+portfolioid+"')";
  sti2.executeUpdate(i2);
  sti2.close();
}

public void delRequestPortfolio(String portfolioid) throws Exception{
  Statement sti2 = programConnection.createStatement();
  String i2 = "DELETE FROM PGMPOR WHERE PROGRAMID='"+programid+"' AND PORTFOLIOID='"+portfolioid+"'";
  sti2.executeUpdate(i2);
  sti2.close();
}
   
public void defineTemplate(String phasetemplate) throws Exception {
  Statement sti4 = programConnection.createStatement();
  String i4 = "UPDATE PROGRAM SET STATUS='PROGRAM' WHERE ID='"+programid+"'";
  sti4.executeUpdate(i4);
  sti4.close();
}

}
 
