package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import dao.LoginDao;

public class LoginServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  

        response.setContentType("text/html");  
        PrintWriter out = response.getWriter();  
        
        String n=request.getParameter("username");  
        String p=request.getParameter("password"); 
        String hashed_pass = null;
        hashed_pass = LoginDao.validatePass(n);
        
        HttpSession session = request.getSession();
        
        if(session!=null)
        session.setAttribute("name", n);
        session.setAttribute("password", p);
       
        if(LoginDao.validateEmail(n) & BCrypt.checkpw(p, hashed_pass))
        //if (LoginDao.validateEmail(n) & BCrypt.checkpw("a", "$2a$06$m0CrhHm10qJ3lXRY.5zDGO3rS2KdeeWLuGmsfGlMfOxih58VYVfxe"))
        {
        	 out.println("<p entered pass: p </p>");
        	out.println(p);
        	 out.println("<p hashed pass </p>");
        	 out.print(hashed_pass); 
        	 out.println("<p end </p>");
            RequestDispatcher rd=request.getRequestDispatcher("welcome.jsp");  
            rd.forward(request,response);  
        	}  
        else{  
            out.print("<p style=\"color:red\">Sorry, username or password error</p>");  
            
            out.println("<p entered pass: p </p>");
        	out.println(p);
        	 out.println("<p hashed pass </p>");
        	 out.print(hashed_pass); 
        	 out.println("<p end </p>");
            RequestDispatcher rd=request.getRequestDispatcher("index.jsp");  
            
            
            rd.include(request,response);  
        }  

        out.close();  
    }  
} 