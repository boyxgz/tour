/**
 * 
 */
package com.surelution.tour.vo

import com.surelution.tour.Department
import com.surelution.tour.PatrolClock
import com.surelution.tour.Poi

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class DepartmentPoiClockKey implements Serializable {

	private static final long serialVersionUID = 2783673415790925244L;

	private Department department;
	private PatrolClock clock;
	private Poi poi;


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("poi id:");
		sb.append(poi.id);
		sb.append(",clock id");
		sb.append(clock.id);
		sb.append(",department id");
		sb.append(department.id);
		return sb.toString();
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		int ret = department.id;
		ret = ret * 13 + poi.id;
		ret = ret * 13 + clock.id;
		return ret;
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if(obj == null)
			return false;
		if (obj instanceof DepartmentPoiClockKey) {
			DepartmentPoiClockKey key = (DepartmentPoiClockKey) obj;
			return key.clock.id == clock.id && key.department.id == department.id && key.poi.id == poi.id;
		}
		return false;
	}
}
