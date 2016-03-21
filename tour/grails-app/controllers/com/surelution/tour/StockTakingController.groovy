package com.surelution.tour

import com.surelution.tour.vo.DepartmentPeriodStockTaking;
import groovy.time.TimeCategory;

import java.text.SimpleDateFormat

class StockTakingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def sdf = new SimpleDateFormat('yyyy-MM-dd')
		def dateFrom = params.dateFrom? sdf.parse(params.dateFrom):null
		def dateTo = params.dateTo? sdf.parse(params.dateTo):null
		if(dateTo) {
			use(TimeCategory) {
				dateTo += 1.days
			}
		}
		def departmentList = UserDepartment.getUserDepartments(springSecurityService.currentUser.toString())
		def department = params['department.id']?Department.get(params['department.id']):null
		def stockTaking = StockTaking.createCriteria().list([max:params.max, offset:params.offset])  {
			if(department) {
				eq("department", department)
			}
			else{
				'in'("department",departmentList)
			}
			if(dateFrom) {
				ge("takingTime", dateFrom)
			}
			if(dateTo) {
				le("takingTime", dateTo)
			}
		}
        [stockTakingInstanceList: stockTaking, stockTakingInstanceTotal: stockTaking.totalCount]
    }

    def create = {
        def stockTakingInstance = new StockTaking()
        stockTakingInstance.properties = params
		
		def stockTaking = StockTaking.findByPatrol(stockTakingInstance.patrol)
		if(stockTaking) {
			redirect(action:'show', id:stockTaking.id)
		} else {
			def cri = StockTaking.createCriteria()
			
			def previousTakings = cri.list() {
				eq("department", stockTakingInstance.patrol.department)
				order("takingTime", "desc")
				maxResults(20)
			}
			
	        return [stockTakingInstance: stockTakingInstance, previousTakings:previousTakings]
		}
    }

    def save = {
        def stockTakingInstance = new StockTaking(params)
		stockTakingInstance.user = springSecurityService.currentUser
		
        if (stockTakingInstance.save(flush: true)) {
			def takingDept = stockTakingInstance.department
			def tanksOfDept = GasTank.findAllByDepartment(takingDept)
			tanksOfDept.each {tank->
				def takingItem = new StockTakingItem(taking:stockTakingInstance, tank:tank, )
				takingItem.save()
			}
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'stockTaking.label', default: 'StockTaking'), stockTakingInstance.id])}"
            redirect(action: "show", id: stockTakingInstance.id)
        }
        else {
            render(view: "create", model: [stockTakingInstance: stockTakingInstance])
        }
    }

    def show = {
        def stockTakingInstance = StockTaking.get(params.id)
        if (!stockTakingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'stockTaking.label', default: 'StockTaking'), params.id])}"
            redirect(action: "list")
        }
        else {
			def department = stockTakingInstance.department
			def start
			def hasPrevious = stockTakingInstance.previousTaking != null
			if(hasPrevious) 
				start = stockTakingInstance.previousTaking.takingTime
			def end = stockTakingInstance.takingTime
//			def unloadings = GasUnloading.findAllByUnloadingTimeBetween(stockTakingInstance.previousTaking.takingTime,stockTakingInstance.takingTime)
//			def gunCheckings = GasGunChecking.findAllByTaking(stockTakingInstance)
			
			def takingItems = StockTakingItem.findAllByTaking(stockTakingInstance)
			
			def unloadings
			def gasRecirclings
//			def gasTankLevels
			
			if(hasPrevious) {
				unloadings = GasUnloading.createCriteria().list {
					between("unloadingTime", start, end)
					eq("department", department)
				}
				
				gasRecirclings = GasRecircling.createCriteria().list() {
					createAlias("gun", "g")
					createAlias("g.tank", "t")
					between("inputTime", start, end)
					eq("t.department", department)
				}

//				gasTankLevels = GasTankLevel.createCriteria().list {
//					createAlias("tank", "t")
//					between("checkTime", start, end)
//					eq("t.department", department)
//				}
			}
            [stockTakingInstance: stockTakingInstance, 
				stockTakingItemInstanceList:takingItems,
				gasUnloadings:unloadings, gasRecirclings:gasRecirclings]
        }
    }

    def edit = {
        def stockTakingInstance = StockTaking.get(params.id)
        if (!stockTakingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'stockTaking.label', default: 'StockTaking'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [stockTakingInstance: stockTakingInstance]
        }
    }

    def update = {
        def stockTakingInstance = StockTaking.get(params.id)
        if (stockTakingInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (stockTakingInstance.version > version) {
                    
                    stockTakingInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'stockTaking.label', default: 'StockTaking')] as Object[], "Another user has updated this StockTaking while you were editing")
                    render(view: "edit", model: [stockTakingInstance: stockTakingInstance])
                    return
                }
            }
            stockTakingInstance.properties = params
            if (!stockTakingInstance.hasErrors() && stockTakingInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'stockTaking.label', default: 'StockTaking'), stockTakingInstance.id])}"
                redirect(action: "show", id: stockTakingInstance.id)
            }
            else {
                render(view: "edit", model: [stockTakingInstance: stockTakingInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'stockTaking.label', default: 'StockTaking'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def stockTakingInstance = StockTaking.get(params.id)
        if (stockTakingInstance) {
            try {
                stockTakingInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'stockTaking.label', default: 'StockTaking'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'stockTaking.label', default: 'StockTaking'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'stockTaking.label', default: 'StockTaking'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def saveGasUnloading = {
        def gasUnloading = new GasUnloading(params)
		gasUnloading.user = springSecurityService.currentUser
        if (gasUnloading.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), gasUnloading.id])}"
        }
		redirect(action: "show", id: gasUnloading.taking.id)
    }
	
	def saveGasGunChecking = {
		def user = springSecurityService.currentUser
        def gasGunCheckingInstance = new GasGunChecking(params)
		gasGunCheckingInstance.user = user
        if (gasGunCheckingInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), gasGunCheckingInstance.id])}"
            redirect(action: "show", id: gasGunCheckingInstance.taking.id)
        }
    }
	
	def saveGasTankLevel = {
        def gasTankLevelInstance = new GasTankLevel(params)
        if (gasTankLevelInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), gasTankLevelInstance.id])}"
            redirect(action: "show", id: gasTankLevelInstance.taking.id)
        }
    }
	
	def saveStockTaking = {
        def stockTakingItemInstance = new StockTakingItem(params)
        if (stockTakingItemInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), stockTakingItemInstance.id])}"
            redirect(action: "show", id: stockTakingItemInstance.taking.id)
        }
	}
	
	def loadStockTakingItem = {
		def taking = StockTaking.get(params.takingId)
		def tank = GasTank.get(params.tankId)
		
		def takingItem = StockTakingItem.findByTakingAndTank(taking, tank)
		render(contentType:"text/xml") {
			stockTakingItem(stockTakingId:taking.id,
				saleAmount:takingItem?takingItem.saleAmount:'不存在',
				stockAmount:takingItem?takingItem.stockAmount:'不存在') {}
		}
	}
	
	def listPatrolls = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		params.offset = params.offset ? params.int('offset') : 0
		def patrolls = Patrol.createCriteria().list([max:params.max, offset:params.offset]) {
			eq('user', springSecurityService.currentUser)
			order("patrolDay", "desc")
		}
		
        [patrolInstanceList: patrolls, patrolInstanceTotal: patrolls.totalCount]
    }
	
	def saveStockTakingItemOfTank = {
		def takingItemId = params.stockTakingItemId
//		def stockAmount = params.float('stockAmount')
		def stockAmount = new BigDecimal(params.stockAmount)
		def takingItem = StockTakingItem.get(takingItemId)
		
		takingItem.stockAmount = stockAmount
		
		def prefix = 'gun_saleAmount_'
		def tank = takingItem.tank
		def guns = GasGun.findAllByTank(tank)
		guns.each {g->
//			def salesAmount = params.float(prefix + g.id)
			def salesAmount = new BigDecimal(params."${prefix + g.id}")
			def tmp = StockTakingItemGun.findByItemAndGun(takingItem,g)
			if(tmp) {
				tmp.salesAmount = salesAmount
			} else {
				def stig = new StockTakingItemGun(item:takingItem,gun:g,salesAmount:salesAmount)
				stig.save(flush:true)
			}
		}
		redirect(action:'show', id:takingItem.taking.id)
	}
	
	def loadTankGunForm = {
		def tankId = params.tankId
		def takingItemId = params.takingItemId
		def tank = GasTank.get(tankId)
		def guns = GasGun.findAllByTank(tank)
		[guns:guns, takingItemId:takingItemId]
	}
	
	def contrast = {
		def start = StockTaking.get(params.start)
		def end = StockTaking.get(params.end)
		def department = Department.get(params.'department.id')
		
		DepartmentPeriodStockTaking taking = new DepartmentPeriodStockTaking(department:department, takings:[start, end])
		if(taking.firstTaking)
			return [taking:taking]
		else 
			render("系统没有找到盘点信息，无法生成报表")
	}
}
