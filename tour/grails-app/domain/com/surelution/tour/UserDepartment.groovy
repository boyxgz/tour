package com.surelution.tour

class UserDepartment {

    static constraints = {
    }
	
	User user
	Department department
	
	public static List<Department> getUserDepartments(String username) {
		def user = User.findByUsername(username)
		if(user){
			def uds = UserDepartment.findAllByUser(user)
			if(uds) {
				return uds.collect {
					it.department
				}
			}
		}
		return null
	}
}
