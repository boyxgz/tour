/**
 * 
 */
package com.surelution.tour.vo

import java.io.Serializable

import com.surelution.tour.Department;
import com.surelution.tour.PatrolClock;
import com.surelution.tour.Poi;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class PatrolDayPoiClockKey implements Serializable {

	def String patrolDay
	def PatrolClock clock
	def Poi poi

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((clock == null) ? 0 : clock.hashCode());
		result = prime * result
				+ ((patrolDay == null) ? 0 : patrolDay.hashCode());
		result = prime * result + ((poi == null) ? 0 : poi.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
//		if (this == obj)
//			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PatrolDayPoiClockKey other = (PatrolDayPoiClockKey) obj;
		return patrolDay == other.patrolDay && clock.id == other.clock.id & poi.id == other.poi.id;
	}	
	
}
