package com.surelution.tour

class Wand {

    static constraints = {
		sn unique:true
		user nullable:true
		description nullable:true
    }

	String sn
	User user
	String description
	
	public String toString() {
		"SN:$sn"
	}
}
