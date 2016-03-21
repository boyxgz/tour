package com.surelution.tour

class SystemMessage {

    static constraints = {
    }
	
	static mapping = {
		detail type:'text'
		key column:'s_key'
	}
	
	Date occuredWhen
	String key
	String detail
}
