package com.surelution.tour

class PatrolClock {

    static constraints = {
    }
	/**
	 * 点
	 */
	int clock
	
	/**
	 * 分
	 */
	int minute
	
	/**
	 * 延迟
	 */
	int delay
	
	/**
	 * 为了数据库查询方便，设此字段，值永远都为 
	 * clock * 60 + minute
	 */
	int start
	
	/**
	 * 为了数据库查询方便，设此字段，值永远都为 
	 * clock * 60 + minute + delay
	 */
	int end
	
	public int getStart() {
		return getClock() * 60 + getMinute();
	}
	
	public int getEnd() {
		return getClock() * 60 + getMinute() + getDelay();
	}
	
	/**
	 * exceptions throws if the object is not from db
	 */
	public int hashCode() {
		id
	}
	
	/**
	* exceptions throws if the object is not from db
	*/
	public boolean equals(Object o) {
		if(o instanceof PatrolClock) {
			return o.id == id
		}
		return false
	}
}
