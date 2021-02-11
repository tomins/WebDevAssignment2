import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class MyGrandkids extends ActionSupport implements SessionAware{

	public MyGrandkids() {
		// TODO Auto-generated constructor stub
	}
	//Session declaration
	
	private SessionMap userSession ;

	@Override
	public void setSession(Map map) {
		this.userSession= (SessionMap) map;  
		
	}
	//end session declaration
	
	//start index page
	
	private boolean login, register;
	
	public String homeLogin() throws Exception {
	    // submit button logic here
		login = true;
	    return "SUCCESS";
	}
	 
	public String homeRegister() throws Exception {
	    // clear button logic here
		register = true;
	    return "SUCCESS";
	}
	
	public boolean getLogin() {
		return login;
	}

	public void setLogin(boolean login) {
		this.login = login;
	}

	public boolean getRegister() {
		return register;
	}

	public void setRegister(boolean register) {
		this.register = register;
	}
	
	//end index page
	
	//start login page
	private String email, password, userID;
	
	public String login() throws Exception {
		try {
			Connection connection;
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/MyGrandKids","root","root");
			
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("select * from users");
			
			while(rs.next()) {
				
				String mail = rs.getString(2);
				String pWord = rs.getString(3);
			
				if(this.email.equalsIgnoreCase(mail)&& this.password.equals(pWord)) {
					this.userID = rs.getString(4);
					userSession.put("currentUser", this.userID);
					return "SUCCESS";
					
				}
			}
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "FAILURE";
	}
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public SessionMap getUserSession() {
		return userSession;
	}
	
	//end login page
	
	//start register page
	private String username;
	public String register() throws Exception{
		try {
			
			Connection connection;
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/MyGrandKids","root","root");
			
			
			PreparedStatement createUser = connection.prepareStatement(
					"INSERT into users " + "(username, email, password)" + "VALUES (?,?,?)");
			
			
			
			createUser.setString(1, username);
			createUser.setString(2, email);
			createUser.setString(3, password);
			int rowUpdated = createUser.executeUpdate();
			createUser.close();	
			
		} catch (Exception e) {
			e.printStackTrace();
			return "FAILURE";
		}
		
		return "SUCCESS";
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	//end registration page
	
	//start covid page
	private String temperature, cough, breath, smell;
	
	public String covid() throws Exception{
		double temp = Double.parseDouble(temperature);
		if(temp> 38.0 || cough.equalsIgnoreCase("Yes")|| breath.equalsIgnoreCase("Yes") || smell.equalsIgnoreCase("Yes"))
			return "FAILURE";
		else
			return "SUCCESS";
		
	}
	public String getTemperature() {
		return temperature;
	}
	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}
	public String getCough() {
		return cough;
	}
	public void setCough(String cough) {
		this.cough = cough;
	}
	public String getBreath() {
		return breath;
	}
	public void setBreath(String breath) {
		this.breath = breath;
	}
	public String getSmell() {
		return smell;
	}
	public void setSmell(String smell) {
		this.smell = smell;
	}
	
	//end covid page
	
	//start view users
	
	private boolean allUsers, friendsButton;
	
	public String viewAllUsers() throws Exception {
		allUsers = true;
	    return "SUCCESS";
	}
	 
	public String viewFriends() throws Exception {
		friendsButton = true;
	    return "SUCCESS";
	}

	public boolean isAllUsers() {
		return allUsers;
	}
	public void setAllUsers(boolean allUsers) {
		this.allUsers = allUsers;
	}
	public boolean isFriendsButton() {
		return friendsButton;
	}
	public void setFriendsButton(boolean friendsButton) {
		this.friendsButton = friendsButton;
	}
	
	//end view users
	
	//start add post
	private String postMessage;
	
	public String addPost() {
		if(this.postMessage.equals(" ")) 
			return "FAILURE";
		else {
			try {
			Connection connection;
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/MyGrandKids","root","root");
			
			
			PreparedStatement addPost = connection.prepareStatement(
					"INSERT into posts " + "(pageID, userID, message)" + "VALUES (?,?,?)");
			
			
			
			addPost.setString(1, (String) userSession.get("currentPage"));
			addPost.setString(2, (String) userSession.get("currentUser"));
			addPost.setString(3, this.postMessage);
			int rowUpdated = addPost.executeUpdate();
			addPost.close();
			return "SUCCESS";
			}
			
		 catch (Exception e) {
			e.printStackTrace();
			return "FAILURE";
		 }
			
		}
			
		
	}

	
	
	public String getPostMessage() {
		return postMessage;
	}

	public void setPostMessage(String postMessage) {
		this.postMessage = postMessage;
	}
	//end add post
	
	//start add comment
	private String commentMessage, postIDCheat;
	
	public String addComment() {
		if(this.commentMessage.equals(" ")) 
			return "FAILURE";
		else {
			try {
			Connection connection;
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/MyGrandKids","root","root");
			
			
			PreparedStatement addComment = connection.prepareStatement(
					"INSERT into comments " + "(postID, userID, message)" + "VALUES (?,?,?)");
			
			
			
			addComment.setString(1, this.postIDCheat);
			addComment.setString(2, (String) userSession.get("currentUser"));
			addComment.setString(3, this.commentMessage);
			int rowUpdated = addComment.executeUpdate();
			addComment.close();
			return "SUCCESS";
			}
			
		 catch (Exception e) {
			e.printStackTrace();
			return "FAILURE";
		 }
			
		}
			
		
	}

	public String getCommentMessage() {
		return commentMessage;
	}

	public void setCommentMessage(String commentMessage) {
		this.commentMessage = commentMessage;
	}

	public String getPostIDCheat() {
		return postIDCheat;
	}

	public void setPostIDCheat(String postIDCheat) {
		this.postIDCheat = postIDCheat;
	}
	
	private String selectedUser;
	
	public String selectedUser() {
		String friends = "FRIENDS";
		try {
			Connection connection;
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/MyGrandKids","root","root");
			
			userSession.put("selectedUser", this.selectedUser);
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("select * from friends");
			
			while(rs.next()) {
				
				String user1 = rs.getString(2);
				String user2 = rs.getString(3);
			
				if(user1.equalsIgnoreCase((String) userSession.get("currentUser"))&& user2.equalsIgnoreCase(this.selectedUser))					
					friends =  "FRIENDS";
				else if(user1.equalsIgnoreCase(this.selectedUser)&& user2.equalsIgnoreCase((String) userSession.get("currentUser")))
					friends = "FRIENDS";				
				else 
					friends = "NOTFRIENDS";
				}
		}
		 catch (Exception e) {
			e.printStackTrace();
			friends = "FAILURE";
		 }
		return friends;
	}

	public String getSelectedUser() {
		return selectedUser;
	}

	public void setSelectedUser(String selectedUser) {
		this.selectedUser = selectedUser;
	}
	
	private String newFriend;
	
	public String addFriend() {
		try {
			Connection connection;
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/MyGrandKids","root","root");
			
			
			PreparedStatement addFriend = connection.prepareStatement(
					"INSERT into friends " + "(user1ID, user2ID)" + "VALUES (?,?)");
			
			
			
			addFriend.setString(1, (String)userSession.get("currentUser"));
			addFriend.setString(2, this.newFriend);
			
			int rowUpdated = addFriend.executeUpdate();
			addFriend.close();
			return "SUCCESS";
			}
			
		 catch (Exception e) {
			e.printStackTrace();
			return "FAILURE";
		 }
	}

	public String getNewFriend() {
		return newFriend;
	}

	public void setNewFriend(String newFriend) {
		this.newFriend = newFriend;
	}
	
	public String logout() {
		userSession.invalidate();
		return "SUCCESS";
	}

}
