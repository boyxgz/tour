import com.surelution.core.ValidatorLoader
import com.surelution.tour.PatrolStatus
import com.surelution.tour.PatrolType
import com.surelution.tour.Role
import com.surelution.tour.User
import com.surelution.tour.UserRole
import com.surelution.tour.Wand
import com.surelution.tour.util.DataSourceUtils

class BootStrap {

    def init = { servletContext ->
		DataSourceUtils.tune(servletContext)
		
		Role adminRole = Role.findByAuthority("ROLE-ADMIN")
		if(!adminRole) {
			adminRole = new Role(authority:"ROLE-ADMIN")
			adminRole.save(flush:true)
		}

		Role bizRole = Role.findByAuthority("ROLE-BUSINESS")
		if(!bizRole) {
			bizRole = new Role(authority:"ROLE-BUSINESS")
			bizRole.save(flush:true)
		}

		User user = User.findByUsername("admin")
		if(!user) {
			user = new User()
			user.username = "admin"
			user.password = "admin"
			user.enabled = true
			user.save(flush:true)
			
			UserRole userRole = new UserRole()
			userRole.user = user
			userRole.role = adminRole
			userRole.save(flush:true)
		}
		
		PatrolStatus newStatus = PatrolStatus.findByCode("NEW")
		if(!newStatus) {
			newStatus = new PatrolStatus(code:"NEW", title:"新建")
			newStatus.save(flush:true)
		}
		PatrolStatus remarkedStatus = PatrolStatus.findByCode("REMARKED")
		if(!remarkedStatus) {
			remarkedStatus = new PatrolStatus(code:"REMARKED", title:"已备注")
			remarkedStatus.save(flush:true)
		}
		
		PatrolType byClock = PatrolType.findByCode(PatrolType.BY_CLOCK)
		if(!byClock) {
			byClock = new PatrolType(code:PatrolType.BY_CLOCK, title:"按巡检时刻")
			byClock.save(flush:true)
		}
		PatrolType byDay = PatrolType.findByCode(PatrolType.BY_DAY)
		if(!byDay) {
			byDay = new PatrolType(code:PatrolType.BY_DAY, title:"按天")
			byDay.save(flush:true)
		}
		
		InputStream is = servletContext.getResourceAsStream("/sn.key")
		def info = ValidatorLoader.load(is)
		is.close()
		servletContext["system-info"] = info
		
		for(String wandSn : info.wandsSn) {
			def wand = Wand.findBySn(wandSn)
			if(!wand) {
				wand = new Wand(sn:wandSn)
				wand.save()
			}
		}
		
    }

    def destroy = {
    }
}
