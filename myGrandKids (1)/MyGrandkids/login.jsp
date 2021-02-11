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
	<s:form action = "login">
	<s:textfield name="email" label="Email"></s:textfield>
	<s:textfield name="password" label="Password"></s:textfield>
	<s:submit/>
	</s:form>
  
    </body>
</html>
