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
		<%	String user = rset.getString(1);%>
			<h2> 
		
		
		
			<p>>Hello & welcome to <%= user %>'s page</p> 
			</h2>
		
		
			<!--Setting the page we are on -->
		<%
			session.setAttribute("currentPage",userID); 
			}
			rset.close();
		%>
  
			<!--Adding a post form -->
			<s:form action = "AddPostFriend">
			<s:textfield name="postMessage" label="Message"></s:textfield>
			<s:submit/>
			</s:form>
	
			<!--This section is The start of seeing all posts on this page -->
		<% 
			String seePosts = "SELECT * FROM posts WHERE pageID =(?) ;";
			PreparedStatement post = conn.prepareStatement(seePosts); 
			post.setString(1, userID);
			
			ResultSet r1 = post.executeQuery();%>
	  
	  
	  <%
			while (r1.next()) {
		%>
  
  
				<!-- First table to show actual messages on posts-->
				<table border=1 cellpadding=5>
				<tr>
				<th>Post ID</th>
				<th>Post User</th>
				<th>Post Message</th>
				</tr>
				<!-- Another statement to get the username of who put the message there-->
		  
				<%
				String postID = (String)r1.getString(1);
				session.setAttribute("currentPost", postID);
				stmt.setString(1, r1.getString(3));
				ResultSet r2 = stmt.executeQuery();
				while(r2.next()){
				%>
					<tr>
					<td><%= r1.getString(1) %></td>
					<td><%= r2.getString(1) %></td>
					<%}
				r2.close();%>
				<td><%= r1.getString(4) %></td>
            
				</tr>
	 
			</table>
				<s:form action = "AddCommentFriend">
				<s:textfield name="commentMessage" label="Comment"></s:textfield>	
				<s:hidden name="postIDCheat" value="%{#session.currentPost}" ></s:hidden>
				<s:submit/>
				</s:form>
				
			<% 
				String seeComments = "SELECT * FROM comments WHERE postID =(?) ;";
				PreparedStatement commen = conn.prepareStatement(seeComments); 
				
				
				commen.setString(1, postID);		
				ResultSet r3 = commen.executeQuery();%>
		
				<table border=1 cellpadding=5>
				<tr>
				<th>Comment User</th>
				<th>Comment Message</th>
				</tr>
		  
				<!-- Next table is to store al comments on each post-->  
				<%
				
				while (r3.next()) {
					%>
					<tr>
					<%
					stmt.setString(1, r3.getString(3));
					ResultSet r4 = stmt.executeQuery();
					 
					while(r4.next()){
						
						%>
						<td><%= r4.getString(1) %></td>
						<%	}
					r4.close();%>
					<td><%= r3.getString(4) %></td>
            
					</tr>
	 
					
					<%
					
					}
					r3.close();
			
				%>
				</table>
				
				<!-- Add comment button to go here-->
				
				<%  }
			r1.close();
			post.close();
			stmt.close();
			conn.close();
  %>
	  
    </body>
</html>
