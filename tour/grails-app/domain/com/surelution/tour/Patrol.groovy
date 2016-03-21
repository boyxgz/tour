package com.surelution.tour

class Patrol {
	
//	static hasOne = [remark:PatrolRemark]
	static hasMany = [items: PatrolItem]

    static constraints = {
		postScript(nullable:true)
		clock(nullable:true)
		remarked(nullable:false)
    }
	
	SortedSet<PatrolItem> items
	
	User user
	Department department
	PatrolClock clock
	String patrolDay

	Date patrolDate
	Date reportDate
	PatrolStatus status
	String postScript
	
	boolean remarked
}
