package com.surelution.tour

import groovy.time.TimeCategory

import java.text.SimpleDateFormat

import org.hibernate.Criteria;
import org.hibernate.FetchMode

import com.surelution.tour.vo.DepartmentPatrolSummary
import com.surelution.tour.vo.DepartmentPeriodStockTaking;
import com.surelution.tour.vo.DepartmentPoiClockKey
import com.surelution.tour.vo.PatrolDayPoiClockKey

class ReportsController {
	
	final static MAX_POI_COUNT_KEY = "MAX-POI-COUNT"

	def getSysInfo() {
		servletContext["system-info"]
	}

    def index = {
		redirect(action:datePatrolReport)
	}

	/**
	 * 按天巡检报表，适用于区域经理
	 */
	def datePatrolReport = {
		def date = params.date
		if(!date) { 
			date = new Date()
		}
		if(date.compareTo(sysInfo.to) >= 0) {
			redirect(controller:"systemInfo")
		}
		if(date) {
			def sdf = new SimpleDateFormat("yyyyMMdd")
			def cri = Patrol.createCriteria()
			def patrols = cri.list{
				createAlias("user", "u")
				createAlias("u.patrolType","t")
				and{
					eq("patrolDay",sdf.format(date))
					eq("t.code", PatrolType.BY_DAY)
				}
				order("user","asc")
				order("department", "asc")
				sort:"user"
			}
			
			[patrols:patrols, date:date]
		}
	}
	
	def clockPatrolReport = {
		def date = params.date
		if(!date) {
			date = new Date()
		}
		if(date.compareTo(sysInfo.to) >= 0) {
			redirect(controller:"systemInfo")
		}
		String maxPoiCounts = AppConfig.findValue(MAX_POI_COUNT_KEY)
		int maxPoiCount = 6
		if(maxPoiCounts) {
			maxPoiCount = Integer.parseInt(maxPoiCounts)
		}
		HashMap<DepartmentPoiClockKey, PatrolItem> values = new HashMap<DepartmentPoiClockKey, PatrolItem>()
		if(date) {
			def sdf = new SimpleDateFormat("yyyyMMdd")
			def cri = Patrol.createCriteria()
			def patrols = cri.list{
				createAlias("user", "u")
				createAlias("u.patrolType","t")
				and{
					eq("patrolDay",sdf.format(date))
					eq("t.code", PatrolType.BY_CLOCK)
					isNotNull("clock")
				}
				sort:"user"
			}
			
			if(patrols) {
				patrols.each {patrol->
					def items = patrol.items
					if(items) {
						items.each {item ->
							def poi = item.poi
							def clock = patrol.clock
							def department = patrol.department
							DepartmentPoiClockKey key = new DepartmentPoiClockKey(department:department, poi:poi, clock:clock)
							values[key] = item
						}
					}
				}
			}
		}
		def departments = Department.list()
		def clocks = PatrolClock.list()
		[departments:departments, clockList:clocks, values:values, date:date, maxPoiCount:maxPoiCount]
	}

	def departmentClockPatrolReport = {
		def sdf = new SimpleDateFormat("yyyyMMdd")
		def deptId = params['department.id']
		Date from
		Date to
		
		String sTo = params.dateTo
		if(sTo) {
			to = (new SimpleDateFormat("yyyy-MM-dd")).parse(sTo)
		}
		if(!to) {
			to = new Date()
		}

		String sFrom = params.dateFrom
		//'date-from' must be specified to avoid loading too much data
		if(sFrom) {
			from = (new SimpleDateFormat("yyyy-MM-dd")).parse(sFrom)
		}
		if(!from) {
			use(TimeCategory) {
				from = to - 1.month
			}
		}
		def days = (to .. from)
		use(TimeCategory) {
			to = to + 1.day
		}
		String maxPoiCounts = AppConfig.findValue(MAX_POI_COUNT_KEY)
		int maxPoiCount = 6
		if(maxPoiCounts) {
			maxPoiCount = Integer.parseInt(maxPoiCounts)
		}
		HashMap<PatrolDayPoiClockKey, PatrolItem> values = new HashMap<PatrolDayPoiClockKey, PatrolItem>()
		println "from:${from}"
		println "to:${to}"
		if(deptId) {
			def cri = Patrol.createCriteria()
			def patrols = cri.list{
				createAlias("user", "u")
				createAlias("u.patrolType","t")
				and{
					ge("patrolDate",from)
					if(to) {
						le("patrolDate", to)
					}
					eq("t.code", PatrolType.BY_CLOCK)
					isNotNull("clock")
				}
				eq("department.id", Long.parseLong(deptId))
			}

			if(patrols) {
				patrols.each {patrol->
					def patrolDay = patrol.patrolDay
					def items = patrol.items
					if(items) {
						items.each {item ->
							def poi = item.poi
							def clock = patrol.clock
							PatrolDayPoiClockKey key = new PatrolDayPoiClockKey(patrolDay:patrolDay, poi:poi, clock:clock)
							values[key] = item
						}
					}
				}
			}
		}
		def departments = Department.list()
		def clocks = PatrolClock.list()
		[department:Department.get(deptId), clockList:clocks, values:values, maxPoiCount:maxPoiCount, days:days]
	}
	
	def supervisorDepartmentMonthlyReport = {
		def datePattern = "yyyyMMdd"
		def patrols
		def thisMonth = params.date
		def departmentId = params["department.id"]
		def department
		if(departmentId) {
			department = Department.get(departmentId)
		}
		if(thisMonth && department) {
		
			if(thisMonth.compareTo(sysInfo.to) >= 0) {
				redirect(controller:"systemInfo")
			}
			
			def nextMonth
			use(TimeCategory) {
				nextMonth = thisMonth + 1.months
			}
			def cri = Patrol.createCriteria()
			patrols = cri {
				createAlias("user", "u")
				createAlias("u.patrolType","t")
				between("patrolDay", thisMonth.format(datePattern), nextMonth.format(datePattern))
				eq("department", department)
				eq("t.code", PatrolType.BY_DAY)
			}

			if(patrols) {
				patrols.each {patrol->
					def long first = Long.MAX_VALUE, last = Long.MIN_VALUE
					if(patrol.items) {
						patrol.items.each {item->
							long time = item.patrolTime.time
							if(time < first)
								first = time
							if(time > last)
								last = time
						}
					}
					patrol.metaClass.getUsername = {->
						delegate.user.username + "(" + (last - first)/60000 + ")" + ((delegate.remarked)?"√":"x")
						//"${elegate.user.username}(${(last - first)/60000})"
					}
				}
			}
		}
		["patrols":patrols, "month":thisMonth, "department":department]
	}

	/*
	 * 生成月度报表，数据量非常大，因此需要非常注意执行效率
	 */
	def departmentMonthlyReport = {
		def start = System.currentTimeMillis()
		def month = params.month
		def patrolSummaryMap = new HashMap()
		def departmentPoiCountMap = new HashMap()
		def daysInMonth = 0
		def departments = Department.list() // load all departments to avoid load n times
		if(month) {
		
			if(month.compareTo(sysInfo.to) >= 0) {
				redirect(controller:"systemInfo")
			}
			
			def datePattern = "yyyyMMdd"
			def nextMonth
			use(TimeCategory) {
				nextMonth = month + 1.months
			}
			
			daysInMonth = nextMonth.minus(month)

			def pois = Poi.list() // load all pois first to avoid load n times
			if(pois) {
				pois.each {poi->
					def department = poi.department
					def count = departmentPoiCountMap[department]
					if(!count) {
						count = 0
					}
					count++
					departmentPoiCountMap[department] = count
				}
			}
			
			//load patrol type first to avoid join in a long query
			def patrolType = PatrolType.findByCode(PatrolType.BY_CLOCK)

			def cri = Patrol.createCriteria()
			def patrols = cri.list {
				createAlias("user", "u")
				eq("u.patrolType", patrolType)
				ge("patrolDay", month.format(datePattern))
				lt("patrolDay", nextMonth.format(datePattern))
				fetchMode("items", FetchMode.JOIN)
				resultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			}
			patrols.each {patrol->
				def department = patrol.department
				def patrolSummary = patrolSummaryMap[department]
				if(!patrolSummary) {
					patrolSummary = new DepartmentPatrolSummary()
					patrolSummaryMap[department] = patrolSummary
				}
				patrolSummary.addPatrol(patrol)
			}
		}
		["patrolSummaryMap":patrolSummaryMap, "departments":departments, 
			"departmentPoiCountMap":departmentPoiCountMap, "month":month, 
			"daysInMonth":daysInMonth, "clockCount":PatrolClock.count(), "start":start]
	}
	
	def supervisorMonthlyReport = {
		def datePattern = "yyyyMMdd"
		def patrolType = PatrolType.findByCode(PatrolType.BY_DAY)
		def users = User.findAllByPatrolType(patrolType)
		def month = params.month
		def userId = params["user.id"]
		def patrols
		def user
		if(month && userId) {
		
			if(month.compareTo(sysInfo.to) >= 0) {
				redirect(controller:"systemInfo")
			}
		
			user = User.get(userId)
			def nextMonth
			use(TimeCategory) {
				nextMonth = month + 1.months
			}
			def cri = Patrol.createCriteria()
			patrols = cri {
				eq("user", user)
				between("patrolDay", month.format(datePattern), nextMonth.format(datePattern))
			}
			patrols.each {patrol->
				def long first = Long.MAX_VALUE, last = Long.MIN_VALUE
				if(patrol.items) {
					patrol.items.each {item->
						long time = item.patrolTime.time
						if(time < first)
							first = time
						if(time > last)
							last = time
					}
				}
				patrol.metaClass.getMessage = {->
					def name = delegate.department.shortName
					if(!name) {
						name = delegate.department.name
					}
					name + "(" + (last - first)/60000 + ")" + ((delegate.remarked)?"√":"x")
				}
			}
			
			//leave
			def cri2 = Leave.createCriteria()
			def leaves = cri2 {
				eq("user", user)
				not{
					or{
						lt("to", month)
						gt("from", nextMonth)
					}
				}
				
			}
			leaves.each {leave->
				def dates = leave.from .. leave.to
				dates.each {d->
					def o = new Object()
					o.metaClass.getMessage = {->
						leave.type.name
					}
					o.metaClass.getPatrolDate = {->
						d
					}
					o.metaClass.getId = {->
						"l-" + leave.id
					}
					patrols.add o
				}
			}
			
		}
		["patrols":patrols, "users":users, "user":user, "month":month]
	}
	
	def supervisorSumMonthlyReport = {
		def start = params.month
		def list
		if(start) {
			def end
			use(TimeCategory) {
				end = start + 1.months
			}
			def patrolType = PatrolType.findByCode(PatrolType.BY_DAY)
			def sb = new StringBuilder("select pli")
			def allTopics = PatrolLogTopic.list()
			allTopics.each {topic->
				sb.append ", max(case when pli.topic.id = '${topic.id}' then pli.answer else 0 end) "
			}
			def reporter = params.reporter
			if (reporter){
				sb.append '''
					 from PatrolLogItem pli where pli.patrolLog.patrol.patrolDate >= :dateStart 
						and pli.patrolLog.patrol.patrolDate < :endDate 
						and pli.patrolLog.patrol.user.username= :user
						group by pli.patrolLog.patrol 
						order by pli.patrolLog.patrol.patrolDate, pli.patrolLog.patrol.department
					'''
				list = PatrolLogItem.executeQuery(sb.toString(),['dateStart':start, 'endDate':end,'user':reporter])
			}
			else{
				sb.append '''
				from PatrolLogItem pli where pli.patrolLog.patrol.patrolDate >= :dateStart
				   and pli.patrolLog.patrol.patrolDate < :endDate
				   and pli.patrolLog.patrol.user.patrolType= :patrolType
				   group by pli.patrolLog.patrol
				   order by pli.patrolLog.patrol.patrolDate, pli.patrolLog.patrol.department
			   '''
				list = PatrolLogItem.executeQuery(sb.toString(),['dateStart':start, 'endDate':end, 'patrolType':patrolType])
			}
			["list":list, 'allTopics':allTopics,'reporter':reporter]
		}
	}

	/**
	 * 盘点报表
	 */
	def stockTakingReport = {
		def sdf = new SimpleDateFormat('yyyy-MM-dd')
		def periodStart = params.from? sdf.parse(params.from):null
		def periodEnd = params.to? sdf.parse(params.to):null
		if(!periodStart && !periodEnd) {
			return
		}
		def depts = params['department.id']?Department.get(params['department.id']):Department.list()
		
		def takings = depts.collect {dept->
			DepartmentPeriodStockTaking t = new DepartmentPeriodStockTaking()
			def deptTakings = StockTaking.findAllByDepartmentAndTakingTimeBetween(dept, periodStart, periodEnd)
			t.department = dept
			t.periodStart = periodStart
			t.periodEnd = periodEnd
			t.takings = deptTakings.sort{it.takingTime}
			t
		}
		['takings':takings]
	}

	def gasUnloadingReport = {
		def periodStart = params.from
		def periodEnd = params.to
		if(!periodStart && !periodEnd) {
			return
		}
		use(TimeCategory) {
			periodEnd = periodEnd + 1.day
		}
		def unloadings = GasUnloading.findAllByUnloadingTimeBetween(periodStart, periodEnd)
//		unloadings.sort {
//			def amount = it.amount
//			(it.planningAmount - amount)/it.planningAmount
//		}
		['unloadings':unloadings]
	}
}
