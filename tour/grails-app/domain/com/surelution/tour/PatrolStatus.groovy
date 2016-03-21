package com.surelution.tour

class PatrolStatus {

    static constraints = {
		code(unique:true)
    }
	
	String code
	String title
}
