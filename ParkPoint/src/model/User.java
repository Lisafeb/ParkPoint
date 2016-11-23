package model;



public class User {
    
    //instance variables 
    private int userid;
    private String password;
    private String fname;
    private String lname;
    private String email;
    private String userType;
  

   
    public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	 @Override
	    public String toString() {
	        return "User [userid=" + userid + ", password=" + password
	                + ", fname=" + fname + ", lname=" + lname + ", email="
	                + email + ", userType=" + userType + "]";
	    }    
}