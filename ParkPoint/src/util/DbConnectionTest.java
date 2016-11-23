package util;


import junit.framework.TestCase;



public class DbConnectionTest extends TestCase {

	
	public void test() {
		System.out.println("---------- MySQL Connection Testing --------------");
		DbUtil dbCon = DbUtil.getInstance();
		if(dbCon != null)
		{
			System.out.println("You have successfully connected to the database");
		}
		else{
		    fail("Cannot connect to database.");
		}
		System.out.println("---------- MySQL Connection Testing --------------");
	}

}