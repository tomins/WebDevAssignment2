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
     <!--This section is saying hello to the user and establishing a db connection 
		Just to describe how i'm doing this, basically the rset loop goes over the friends list taking out and showing each time someone is friends with the user in one way and then r3 does the same but shows a different column-->
		<%
			Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/MyGrandKids","root", "root");
			String userID = (String)session.getAttribute("currentUser");
			String sqlStr = "SELECT * FROM friends WHERE user1ID = (?);";
			PreparedStatement stmt = conn.prepareStatement(sqlStr);
			stmt.setString(1, userID);
			
			ResultSet rset = stmt.executeQuery();
		%>
		<table border=1 cellpadding=5>
				<tr>
				<th>User</th>
				</tr>
		<%
			while (rset.next()) {
				String use = (String)rset.getString(3);
				session.setAttribute("selectedUser", use);
				String userName = "Select * from users where userID = (?);";
				PreparedStatement stat = conn.prepareStatement(userName);
				stat.setString(1,use);
				ResultSet r2 = stat.executeQuery();
			
				while(r2.next()){
					String name = (String)r2.getString(1);
					session.setAttribute("selectedUserName", name);
				}
				r2.close();
				
				
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
