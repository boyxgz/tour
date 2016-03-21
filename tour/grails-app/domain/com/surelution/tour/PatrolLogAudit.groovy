package com.surelution.tour

class PatrolLogAudit {

    static constraints = {
    }
	
	static mapping = {
		user column:"user_"
	}
	
	PatrolLog patrolLog
	Date auditTime
	Boolean correct
	String descript
	User user

	@Override
	public String toString() {
		return "PatrolLogAudit [patrolLog=" + patrolLog + ", auditTime="
				+ auditTime + ", correct=" + correct + ", descript=" + descript
				+ ", user=" + user + "]";
	}	
	
}
