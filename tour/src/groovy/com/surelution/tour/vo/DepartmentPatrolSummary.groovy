/**
 * 
 */
package com.surelution.tour.vo

import com.surelution.tour.Department
import com.surelution.tour.Patrol

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class DepartmentPatrolSummary {

	Department department

	Integer patrolCount = 0

	public Integer getPatrolCount() {
		patrolCount
	}

	Integer patrolItemCount = 0
	public Integer getPatrolItemCount() {
		patrolItemCount
	}
	
	public void addPatrol(Patrol patrol) {
		patrolCount++
		def set = new HashSet() // just count 1, even patrolled more than 1 time at one poi
		if(patrol && patrol.items) {
			patrol.items.each {item->
				set.add(item.poi)
			}
		}
		patrolItemCount += set.size()
	}
}
