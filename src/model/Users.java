package model;

import java.util.ArrayList;
import java.util.List;

public class Users {

	private static List<User> users = new ArrayList<User>();
	
	public static void register(User user){
		users.add(user);
	}

	public static boolean exists(User user){
		return users.contains(user);
	}

}
