package com.surelution.tour

import java.util.Date;

class PatrolLog {

    static constraints = {
    }
	static hasMany = [items:PatrolLogItem]
	
	Patrol patrol
	Date logTime
	String remark
	SortedSet<PatrolLogItem> items
}
