package com.surelution.tour

import java.text.SimpleDateFormat
import groovy.time.TimeCategory;
import java.util.Date;

class GasRecirclingController {

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
		def gasRecircling = GasRecirclingSummary.createCriteria().list([max:params.max, offset:params.offset])  {
			if(department) {
				eq("department", department)
			}
			else{
				'in'("department",departmentList)
			}
			if(dateFrom) {
				ge("time", dateFrom)
			}
			if(dateTo) {
				le("time", dateTo)
			}
			order("id","asc")
		}
        [gasRecirclingInstanceList: gasRecircling, gasRecirclingInstanceTotal: gasRecircling.totalCount]
    }

    def create = {
        def gasRecirclingInstance = new GasRecircling()
        gasRecirclingInstance.properties = params
        return [gasRecirclingInstance: gasRecirclingInstance]
    }

    def save = {
        def gasRecirclingInstance = new GasRecircling(params)
		gasRecirclingInstance.user = springSecurityService.currentUser
		gasRecirclingInstance.reportTime = new Date()
        if (gasRecirclingInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasRecircling.label', default: 'GasRecircling'), gasRecirclingInstance.id])}"
            redirect(action: "show", id: gasRecirclingInstance.id)
        }
        else {
            render(view: "create", model: [gasRecirclingInstance: gasRecirclingInstance])
        }
    }

    def show = {
        def gasRecirclingInstance = GasRecircling.get(params.id)
        if (!gasRecirclingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasRecircling.label', default: 'GasRecircling'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gasRecirclingInstance: gasRecirclingInstance]
        }
    }

    def edit = {
        def gasRecirclingInstance = GasRecircling.get(params.id)
        if (!gasRecirclingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasRecircling.label', default: 'GasRecircling'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gasRecirclingInstance: gasRecirclingInstance]
        }
    }

    def update = {
        def gasRecirclingInstance = GasRecircling.get(params.id)
        if (gasRecirclingInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gasRecirclingInstance.version > version) {
                    
                    gasRecirclingInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gasRecircling.label', default: 'GasRecircling')] as Object[], "Another user has updated this GasRecircling while you were editing")
                    render(view: "edit", model: [gasRecirclingInstance: gasRecirclingInstance])
                    return
                }
            }
            gasRecirclingInstance.properties = params
            if (!gasRecirclingInstance.hasErrors() && gasRecirclingInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gasRecircling.label', default: 'GasRecircling'), gasRecirclingInstance.id])}"
                redirect(action: "show", id: gasRecirclingInstance.id)
            }
            else {
                render(view: "edit", model: [gasRecirclingInstance: gasRecirclingInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasRecircling.label', default: 'GasRecircling'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gasRecirclingInstance = GasRecircling.get(params.id)
        if (gasRecirclingInstance) {
            try {
                gasRecirclingInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gasRecircling.label', default: 'GasRecircling'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gasRecircling.label', default: 'GasRecircling'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasRecircling.label', default: 'GasRecircling'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def batchCreate = {
		
	}
	
	def batchCreateGunTable = {
		def department = Department.get(params.deptId)
		def guns = GasGun.findAllByDepartment(department)
		[guns:guns]
	}
	
	def batchSave = {
		def allInstances = []
		def type = GasRecirclingType.get(params."type.id")
		def user = springSecurityService.currentUser
		def reportTime = new Date()
		
		Date inputTime = params.inputTime
		def department = Department.get(params.deptId)
		
		def summary = new GasRecirclingSummary(user:user, department:department, type:type, time:inputTime)
		summary.save(flush:true)
		
		def guns = GasGun.findAllByDepartment(department)
		guns.each {gun->
			def volume = params."gun_volume_${gun.id }"
			def differAmount = params."gun_differAmount_${gun.id }"
			def description = params."gun_description_${gun.id }"
			if(volume && differAmount) {
				def recircling = new GasRecircling(gun:gun, type:type, user:user, reportTime:reportTime,
					inputTime:inputTime, outputTime:inputTime, volume:volume, differAmount:differAmount,
					description:description, summary:summary)
				recircling.save(flush:true)
				allInstances.add(recircling)
			}
		}
		[allInstances:allInstances]
	}
	
	def summaryShow = {
		def summary = GasRecirclingSummary.get(params.id)
		def recirclings
		if(summary) {
			recirclings = GasRecircling.findAllBySummary(summary)
		}
		[summary:summary, recirclings:recirclings]
	}
}
