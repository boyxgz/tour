package com.surelution.tour

class PatrolType {
	
	public static final String BY_CLOCK = "by-clock"
	public static final String BY_DAY = "by-day"

    static constraints = {
		code(unique:true)
    }
	
	String title
	String code
}
