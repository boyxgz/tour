package com.surelution.tour

class Leave {

    static constraints = {
    }
	
	static mapping = {
		table name:"t_leave"
		user column:"user_id"
		type column:"type_id"
		from column:"time_from"
		to column:"time_to"
	}

	User user
	LeaveType type
	String description
	Date from
	Date to
}
