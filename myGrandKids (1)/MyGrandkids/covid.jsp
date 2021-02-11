<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/struts-tags" prefix="s" %>

<%@ page import = "java.sql.*" %>
<%@ page import = "com.opensymphony.xwork2.ActionContext"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Grandkids Book</title>
    </head>
    <body>
	
	<%
	
      Connection conn = DriverManager.getConnection(
         "jdbc:mysql://localhost:3306/MyGrandKids","root", "root");
     
      
      String userID = (String)session.getAttribute("currentUser");
	 
      String sqlStr = "SELECT * FROM users WHERE userID =(?) ;";
	  PreparedStatement stmt = conn.prepareStatement(sqlStr); 
		stmt.setString(1, userID);
      ResultSet rset = stmt.executeQuery();
  %>
  <%
      while (rset.next()) {
  %>
	
		User 
		
		<%= rset.getString(1)%>, hello, This is the covid test to acertain if you are eligable for this site!
		
		<%
	 
	  }
	  rset.close();
      stmt.close();
      conn.close();
  %>
  
     
		
		<s:form action = "covid">
		<s:textfield name="temperature" label="Temperature"></s:textfield>
		<s:radio label="Breath easy??" list="#{true:'Yes',false:'No'}" name="breath" value="%{breath}"></s:radio>
		<s:radio label="Do you have a cough?" list="#{true:'No',false:'Yes'}" name="cough" value="%{cough}"></s:radio>
		<s:radio label="Have you lost or had a change in your sense of smell?" list="#{true:'No',false:'Yes'}" name="smell" value="%{smell}"></s:radio>
		<s:submit/>
		</s:form>
    </body>
</html>


