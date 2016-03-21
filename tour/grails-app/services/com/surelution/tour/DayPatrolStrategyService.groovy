package com.surelution.tour

import java.text.SimpleDateFormat

import com.surelution.tour.core.PatrolStrategy

class DayPatrolStrategyService implements PatrolStrategy {

    static transactional = true

    def serviceMethod() {

    }
	/* (non-Javadoc)
	 * @see com.surelution.tour.core.PatrolStrategy#save(com.surelution.tour.PatrolItem)
	 */
	@Override
	public PatrolItem save(PatrolItem item) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd")
		String patrolDay = sdf.format(item.patrolTime)
		Date now = new Date()
		PatrolStatus newStatus = PatrolStatus.findByCode("NEW")
		
		Calendar c = Calendar.getInstance()
		c.setTime(item.patrolTime)
		
		def wand = Wand.findBySn(item.wandSn)
		def user = wand.user
		def poi = Poi.findBySn(item.addressCardSn)
		if(!poi) {
			def msg = new SystemMessage()
			msg.occuredWhen = new Date()
			msg.key = "poi sn not exists"
			msg.detail = "poi sn:" + item.addressCardSn
			msg.save(flush:true)
			return item
		}
		
		def cri = Patrol.createCriteria()
		List<Patrol> ps = cri {
			and {
				eq("user", user)
				eq("department", poi.department)
				eq("patrolDay", patrolDay)
			}
		}
		Patrol p
		if(ps != null && ps.size() > 0) {
			p = ps.get(0)
		} else {
			p = new Patrol()
			p.user = user
			p.department = poi.department
			p.patrolDay = patrolDay
			p.patrolDate = item.patrolTime
			p.reportDate = now
			p.status = newStatus
			p.save(flush:true)
		}
		item.patrol = p
		item.save(flush:true)
		
		return item;
	}
}
