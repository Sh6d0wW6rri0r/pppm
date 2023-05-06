
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

public class ProjectRiskAction {

  Connection actionConnection;
  String projectid;
  String riskid;
  String actionid;
  String name;
  String description;
  String date_creation;
  String date_closing;
  String status;
  String employeeid;
  String impact;
  String likelihood;
  String implement;
  String closed;
  String strategy;

  public ProjectRiskAction (Connection Conn,String prjid, String rid) throws Exception {
    actionConnection=Conn;
    int ORD=0;
    Statement st43 = actionConnection.createStatement();
    String q43 = "SELECT ID FROM PROJECT_RISK_ACTION WHERE PROJECTID='"+prjid+"' AND RISKID='"+rid+"' ORDER BY ID DESC";
    ResultSet r43 = st43.executeQuery(q43);
    if (r43.next()) {
      ORD=r43.getInt("ID")+1;
    }
    st43.close();
    actionid=""+ORD;
    projectid=prjid;
    riskid=rid;
    name="";
    description="";
    date_creation="";	
    date_closing="";
    status="";
    employeeid="";
    impact="";
    likelihood="";
    implement="";
    closed="";
    strategy="";
    Statement sti2 = actionConnection.createStatement();
    String i2 = "INSERT INTO PROJECT_RISK_ACTION VALUES('"+projectid+"',"+riskid+","+ORD+",'"+name+"','"+description+"','"+date_creation+"','"+date_creation+"','"+status+"','"+employeeid+"',"+impact+","+likelihood+",'"+implement+"','"+closed+"','"+strategy+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  public ProjectRiskAction (Connection Conn, String prjid, String rid, String actid) throws Exception {
	  actionConnection=Conn;
	  projectid=prjid;
	  riskid=rid;
	  actionid=actid;
	  Statement st12 = actionConnection.createStatement();
	  String q12 = "SELECT * FROM PROJECT_RISK_ACTION WHERE PROJECTID='"+projectid+"' AND RISKID='"+riskid+"' AND ID='"+actionid+"'";
	  ResultSet r12 = st12.executeQuery(q12);
	  if (r12.next()) {
	    name=r12.getString("NAME");
	    description=r12.getString("DESCRIPTION");
	    date_creation=r12.getString("DATE_CREATION");
	    date_closing=r12.getString("DATE_CLOSING");
	    status=r12.getString("STATUS");
	    employeeid=r12.getString("EMPLOYEEID");
	    impact=r12.getString("IMPACT");
	    likelihood=r12.getString("LIKELIHOOD");
	    implement=r12.getString("IMPLEMENT");
	    closed=r12.getString("CLOSED");
	    strategy=r12.getString("STRATEGY");
	  }
	  st12.close();
	}

	public void refresh () throws Exception {
		  Statement st12 = actionConnection.createStatement();
		  String q12 = "SELECT * FROM PROJECT_RISK_ACTION WHERE PROJECTID='"+projectid+"' AND RISKID='"+riskid+"' AND ID='"+actionid+"'";
		  ResultSet r12 = st12.executeQuery(q12);
		  if (r12.next()) {
		    name=r12.getString("NAME");
		    description=r12.getString("DESCRIPTION");
		    date_creation=r12.getString("DATE_CREATION");
		    date_closing=r12.getString("DATE_CLOSING");
		    status=r12.getString("STATUS");
		    employeeid=r12.getString("EMPLOYEEID");
		    impact=r12.getString("IMPACT");
		    likelihood=r12.getString("LIKELIHOOD");
		    implement=r12.getString("IMPLEMENT");
		    closed=r12.getString("CLOSED");
		    strategy=r12.getString("STRATEGY");
		  }
		  st12.close();
	}

	public String getId() {
	  return actionid;
	}

	public String getName() throws Exception {
	  this.refresh();
	  return name;
	}

	public void setName(String n) throws Exception {
	  name = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET NAME='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}
 

	public String getDescription() throws Exception {
	  this.refresh();
	  return description;
	}

	public void setDescription(String n) throws Exception {
	  description = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET DESCRIPTION='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getDateCreation() throws Exception {
	  this.refresh();
	  return date_creation;
	}

	public void setDateCreation(String n) throws Exception {
	  date_creation = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET DATE_CREATION='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getDateClosing() throws Exception {
	  this.refresh();
	  return date_closing;
	}

	public void setDateClosing(String n) throws Exception {
	  date_closing = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET DATE_CLOSING='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getStatus() throws Exception {
	  this.refresh();
	  return status;
	}

	public void setStatus(String n) throws Exception {
	  status = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET STATUS='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getEmployeeid() throws Exception {
	  this.refresh();
	  return employeeid;
	}

	public void setEmployeeid(String n) throws Exception {
	  employeeid = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET EMPLOYEEID='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getImpact() throws Exception {
	  this.refresh();
	  return impact;
	}

	public void setImpact(String n) throws Exception {
	  impact = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET IMPACT='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getLikelihood() throws Exception {
	  this.refresh();
	  return likelihood;
	}

	public void setLikelihood(String n) throws Exception {
	  likelihood = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET LIKELIHOOD='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getImplement() throws Exception {
	  this.refresh();
	  return implement;
	}

	public void setImplement(String n) throws Exception {
	  implement = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET IMPLEMENT='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getClosed() throws Exception {
	  this.refresh();
	  return closed;
	}

	public void setClosed(String n) throws Exception {
	  closed = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET CLOSED='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}

	public String getStrategy() throws Exception {
	  this.refresh();
	  return strategy;
	}

	public void setStrategy(String n) throws Exception {
	  strategy = n;
	  Statement sti2 = actionConnection.createStatement();
	  String i2 = "UPDATE PROJECT_RISK_ACTION SET STRATEGY='"+n+"' WHERE ID='"+actionid+"' AND PROJECTID='"+projectid+"' AND RISKID='"+riskid+"'";
	  sti2.executeUpdate(i2);
	  sti2.close();
	}
}
