package org.mindrot.jbcrypt;

import org.mindrot.jbcrypt.BCrypt;
import junit.framework.TestCase;

public class Test1ofBCrypt extends TestCase {
	public void test1(){
		String pw_hash = BCrypt.hashpw("password", BCrypt.gensalt());
		System.out.println("pw_hash: ");
		System.out.println(pw_hash);
		
		
		if (BCrypt.checkpw("password", pw_hash)) {
	        System.out.println("It matches");
	    }else{
	        System.out.println("It does not match");
	    }
		System.out.println("end test1");
		}
}
