<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/struts-tags" prefix="s" %>

<%@ page import = "java.sql.*" %>
<%@ page import = "com.opensymphony.xwork2.ActionContext"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyGrandKids</title>
    </head>
    <body>
	
	<s:form action ="logout">
		<s:submit value="Logout"/>
		</s:form>
     <!--This section is saying hello to the user and establishing a db connection -->
		<%
			Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/MyGrandKids","root", "root");
			String userID = (String)session.getAttribute("currentUser");
			String sqlStr = "SELECT * FROM users;";
			PreparedStatement stmt = conn.prepareStatement(sqlStr);
			ResultSet rset = stmt.executeQuery();
		%>
		<table border=1 cellpadding=5>
				<tr>
				<th>User</th>
				</tr>
		<%
			while (rset.next()) {
				String use = (String)rset.getString(4);
				String name = (String)rset.getString(1);
				session.setAttribute("selectedUser", use);
				session.setAttribute("selectedUserName", name);
		%>
		<tr>
					<td><s:form action = "ChooseProfile">
				<s:hidden name="selectedUser" value="%{#session.selectedUser}" ></s:hidden>
				<s:submit value="%{#session.selectedUserName}"/>
				</s:form></td>
					</tr>
	 
			
					<%}
				rset.close();
				stmt.close();
				conn.close();%>
				</table>
    </body>
</html>

