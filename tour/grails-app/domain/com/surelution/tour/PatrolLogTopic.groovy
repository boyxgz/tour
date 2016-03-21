package com.surelution.tour

class PatrolLogTopic {

    static constraints = {
    }
	
	static mapping = {
		index column:"s_index"
	}
	
	String title
	String shortTitle
	int index
}
