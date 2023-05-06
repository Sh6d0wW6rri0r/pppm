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

public class Group {
	  Connection groupConnection;
	  String groupid;
	  String name;

	  public Group (Connection Conn) throws Exception {
	    groupConnection=Conn;
	    int ORD=0;
	    Statement st43 = groupConnection.createStatement();
	    String q43 = "SELECT ID,SEQ FROM INDX WHERE ID='GROUP'";
	    ResultSet r43 = st43.executeQuery(q43);
	    if (r43.next()) {
	      ORD=r43.getInt("SEQ");
	    }
	    st43.close();
	    Statement sti1 = groupConnection.createStatement();
	    String i1 = "UPDATE INDX SET SEQ="+(ORD+1)+" WHERE ID='GROUP'";
	    sti1.executeUpdate(i1);
	    sti1.close();
	    groupid="GRP"+ORD;
	    name="";
	    Statement sti2 = groupConnection.createStatement();
	    String i2 = "INSERT INTO GROUPS VALUES('"+groupid+"','"+name+"')";
	    sti2.executeUpdate(i2);
	    sti2.close();
	  }

	  public Group (Connection Conn, String pid) throws Exception {
		  groupConnection=Conn;
		  groupid = pid;
		  Statement st12 = groupConnection.createStatement();
		  String q12 = "SELECT * FROM GROUPS WHERE ID='"+groupid+"'";
		  ResultSet r12 = st12.executeQuery(q12);
		  if (r12.next()) {
		    name=r12.getString("NAME");
		  }
		  st12.close();
		}

		public void refresh () throws Exception {
		  Statement st12 = groupConnection.createStatement();
		  String q12 = "SELECT * FROM GROUPS WHERE ID='"+groupid+"'";
		  ResultSet r12 = st12.executeQuery(q12);
		  if (r12.next()) {
		    name=r12.getString("NAME");
		  }
		  st12.close();
		}

		public String getId() {
		  return groupid;
		}

		public String getName() throws Exception {
		  this.refresh();
		  return name;
		}

		public void setName(String n) throws Exception {
		  name = n;
		  Statement sti2 = groupConnection.createStatement();
		  String i2 = "UPDATE GROUPS SET NAME='"+n+"' WHERE ID='"+groupid+"'";
		  sti2.executeUpdate(i2);
		  sti2.close();
		}

  public int profileNB() throws Exception{
    int nbprofile = 0;
    Statement st131 = groupConnection.createStatement();
    String q131 = "SELECT COUNT(USERRIGHT) FROM GROUP_RIGHT WHERE GROUPID='"+groupid+"'";
    ResultSet r131 = st131.executeQuery(q131);
    if (r131.next()) {
      nbprofile=r131.getInt("COUNT(USERRIGHT)");
    }
    st131.close();
    return(nbprofile);
  }

  public void addRight(String right) throws Exception {
    Statement sti2 = groupConnection.createStatement();
    String i2 = "INSERT INTO GROUP_RIGHT VALUES ('"+groupid+"','"+right+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  public void deleteRight(String right) throws Exception {
    Statement sti2 = groupConnection.createStatement();
    String i2 = "DELETE FROM GROUP_RIGHT WHERE USERRIGHT='"+right+"' AND GROUPID='"+groupid+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }
 
}
