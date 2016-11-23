<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">


<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<title>Add new user</title>
</head>
<body>
   

    <form method="POST" action='UserController' name="frmAddUser">
        User ID : <input type="text" readonly="readonly" name="userid"
            value="<c:out value="${user.userid}" />" /> <br /> 
        Password : <input 
        	type="password" name="password"
       		value="<c:out value="${user.password}"    />" /> <br /> 
        First Name : <input
            type="text" name="fname"
            value="<c:out value="${user.fname}" />" /> <br /> 
        Last Name : <input
            type="text" name="lname"
            value="<c:out value="${user.lname}" />" /> <br /> 
        
        Email : <input type="text" name="email"
            value="<c:out value="${user.email}" />" /> <br /> 
            
        UserType :<select name="userType">
    <option value="citizen">Citizen</option>
    <option value="municipality">Municipality</option>
    <option value="admin">Admin</option>
  
  </select>
            <c:out value="${user.userType}" /> <br /> 
     
            <input
            type="submit" value="Submit" />
        
    </form>
</body>
</html>