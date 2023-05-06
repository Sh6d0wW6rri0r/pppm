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

public class ProjectRiskActionList {

Connection actionConnection;
String query;
Vector actlist = new Vector();

public ProjectRiskActionList (Connection Conn,String q) throws Exception {
  actionConnection=Conn;
  actlist= new Vector();
  query = q;
  this.refresh();
}

public void refresh() throws Exception {
  actlist=new Vector();
  Statement st12 = actionConnection.createStatement();
  ResultSet r12 = st12.executeQuery(query);
  while (r12.next()) {
    actlist.add(new ProjectRiskAction(actionConnection,r12.getString("PROJECTID"), r12.getString("RISKID"),r12.getString("ID"))); 
  }
  st12.close();
}

public Vector getProjectRiskActionList() {
  return actlist;
}

public ProjectRiskAction getProjectRiskActionItem(int i) {
  return (ProjectRiskAction)actlist.elementAt(i);
}

public int length() {
  return actlist.size();
}
}
