
// Vortex PPM, the OpenSource PPM (Portfolio, Project and Program management) system
package fr.pppm;
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

public class Employee {

  Connection employeeConnection;
  String employeeid;
  String name;
  String forname;
  String ouid;
  String contractor;
  String siteid;
  String profileid;
  int skill;
  String rate;
  String capacity;

  public Employee (Connection Conn) throws Exception {
    employeeConnection=Conn;
    int ORD=0;
    Statement st43 = employeeConnection.createStatement();
    String q43 = "SELECT ID,SEQ FROM INDX WHERE ID='EMPLOYEE'";
    ResultSet r43 = st43.executeQuery(q43);
    if (r43.next()) {
      ORD=r43.getInt("SEQ");
    }
    st43.close();
    Statement sti1 = employeeConnection.createStatement();
    String i1 = "UPDATE INDX SET SEQ="+(ORD+1)+" WHERE ID='EMPLOYEE'";
    sti1.executeUpdate(i1);
    sti1.close();
    employeeid="EMP"+ORD;
    name="";
    forname="";
    ouid="";	
    contractor="N";
    siteid="";
    profileid="";
    skill=0;
    rate="0";
    capacity="0";
    Statement sti2 = employeeConnection.createStatement();
    String i2 = "INSERT INTO EMPLOYEE VALUES('"+employeeid+"','"+name+"','"+forname+"','"+ouid+"','"+contractor+"','"+siteid+"','"+profileid+"',"+skill+","+capacity+","+rate+")";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  public Employee (Connection Conn, String pid) throws Exception {
	  employeeConnection=Conn;
	  employeeid = pid;
	  Statement st12 = employeeConnection.createStatement();
	  String q12 = "SELECT * FROM EMPLOYEE WHERE ID='"+employeeid+"'";
	  ResultSet r12 = st12.executeQuery(q12);
	  if (r12.next()) {
	    name=r12.getString("NAME");
	    forname=r12.getString("FORNAME");
	    ouid=r12.getString("OUID");
	    contractor=r12.getString("CONTRACTOR");
	    siteid=r12.getString("SITEID");
	    profileid=r12.getString("PROFILEID");
	    skill=r12.getInt("SKILL");
	    rate=r12.getString("RATE");
	    capacity=r12.getString("CAPACITY");
	  }
	  st12.close();
	}

	public void refresh () throws Exception {
	  Statement st12 = employeeConnection.createStatement();
	  String q12 = "SELECT * FROM EMPLOYEE WHERE ID='"+employeeid+"'";
	  ResultSet r12 = st12.executeQuery(q12);
	  if (r12.next()) {
	    name=r12.getString("NAME");
	    forname=r12.getString("FORNAME");
	    ouid=r12.getString("OUID");
	    contractor=r12.getString("CONTRACTOR");
	    siteid=r12.getString("SITEID");
	    profileid=r12.getString("PROFILEID");
	    skill=r12.getInt("SKILL");
	    rate=r12.getString("RATE");
	    capacity=r12.getString("CAPACITY");
	  }
	  st12.close();
	}

	public String getId() {
	  return employeeid;
	}

	public String getName() throws Exception {
	  this.refresh();
	  return name;
	}

	public void setName(String n) throws Exception {
	  name = n;
	  Statement sti2 = employeeConnection.createStatement();
	  String i2 = "UPDATE EMPLOYEE SET NAME='"+n+"' WHERE ID='"+employeeid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getForname() throws Exception {
		  this.refresh();
		  return forname;
	}

	public void setForname(String n) throws Exception {
		  forname = n;
		  Statement sti2 = employeeConnection.createStatement();
		  String i2 = "UPDATE EMPLOYEE SET FORNAME='"+n+"' WHERE ID='"+employeeid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
	}

	public String getOuid() throws Exception {
		  this.refresh();
		  return ouid;
	}

	public void setOuid(String o) throws Exception {
		  ouid = o;
		  Statement sti2 = employeeConnection.createStatement();
		  String i2 = "UPDATE EMPLOYEE SET OUID='"+o+"' WHERE ID='"+employeeid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
	}
	public String getContractor() throws Exception {
		  this.refresh();
		  return contractor;
	}

	public void setContractor(String c) throws Exception {
		  contractor = c;
		  Statement sti2 = employeeConnection.createStatement();
		  String i2 = "UPDATE EMPLOYEE SET CONTRACTOR='"+c+"' WHERE ID='"+employeeid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
	}
	public String getSiteid() throws Exception {
		  this.refresh();
		  return siteid;
	}

	public void setSiteid(String s) throws Exception {
		  siteid = s;
		  Statement sti2 = employeeConnection.createStatement();
		  String i2 = "UPDATE EMPLOYEE SET SITEID='"+s+"' WHERE ID='"+employeeid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
	}
	public String getProfileid() throws Exception {
		  this.refresh();
		  return profileid;
	}

	public void setProfileid(String p) throws Exception {
		  profileid = p;
		  Statement sti2 = employeeConnection.createStatement();
		  String i2 = "UPDATE EMPLOYEE SET PROFILEID='"+p+"' WHERE ID='"+employeeid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
	}
	public int getSkill() throws Exception {
		  this.refresh();
		  return skill;
	}

	public void setSkill(int s) throws Exception {
		  skill = s;
		  Statement sti2 = employeeConnection.createStatement();
		  String i2 = "UPDATE EMPLOYEE SET SKILL="+s+" WHERE ID='"+employeeid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
	}
	public String getRate() throws Exception {
		  this.refresh();
		  return rate;
	}

	public void setRate(String r) throws Exception {
		  rate = r;
		  Statement sti2 = employeeConnection.createStatement();
		  String i2 = "UPDATE EMPLOYEE SET RATE='"+r+"' WHERE ID='"+employeeid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
	}
	public String getCapacity() throws Exception {
		  this.refresh();
		  return capacity;
	}

	public void setCapacity(String c) throws Exception {
		  capacity = c;
		  Statement sti2 = employeeConnection.createStatement();
		  String i2 = "UPDATE EMPLOYEE SET CAPACITY='"+c+"' WHERE ID='"+employeeid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
	}
 
}
