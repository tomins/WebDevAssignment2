<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/struts-tags" prefix="s" %>

<%@ page import = "java.sql.*" %>
<%@ page import = "com.opensymphony.xwork2.ActionContext"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My GrandKids</title>
    </head>
    <body>
		<%-- This is a JSP Comment --%>
		<!--This section is just 2 buttons for seeing other users -->
		<s:form action="ViewAllUsers">
			<s:submit value="View All Users"/>
		</s:form>

		<s:form action="ViewFriends">
			<s:submit value="View Friends"/>
		</s:form>
		
		<s:form action ="logout">
		<s:submit value="Logout"/>
		</s:form>
	
			<!--This section is saying hello to the user and establishing a db connection -->
		<%
			Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/MyGrandKids","root", "root");
			String userID = (String)session.getAttribute("selectedUser");
			String sqlStr = "SELECT * FROM users WHERE userID =(?) ;";
			PreparedStatement stmt = conn.prepareStatement(sqlStr); 
			stmt.setString(1, userID);
			ResultSet rset = stmt.executeQuery();
		%>
		<%
			while (rset.next()) {
		%>
		<%	String user = rset.getString(1);
			session.setAttribute("selectedUserName", user);%>
			<h2>
		
		
		
			<p>Hello & welcome to <%= user %>'s page</p> 
			</h2>
		
		
			<!--Setting the page we are on -->
		<%
			session.setAttribute("currentPage",userID); 
			}
			rset.close();
			stmt.close();
			conn.close();
  %>
	  <h3>
	  Sorry, but you are not friends ,if you would like to add eachother as friends please click below
	  
				<s:form action = "addFriend">
				<s:hidden name="newFriend" value="%{#session.selectedUser}" ></s:hidden>
				<s:submit value="Add %{#session.selectedUserName} as a friend"/>
				</s:form>
    </body>
</html>
