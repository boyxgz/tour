package com.surelution.tour

import java.text.SimpleDateFormat
import groovy.time.TimeCategory;

class GasTankLevelController {

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
		def tankNo = params['tank.id']?GasTank.get(params['tank.id']).tankNo:null
		if(dateTo) {
			use(TimeCategory) {
				dateTo += 1.days
			}
		}
		def departmentList = UserDepartment.getUserDepartments(springSecurityService.currentUser.toString())
		def department = params['department.id']?Department.get(params['department.id']):null
		def tankLevel = GasTankLevel.createCriteria().list([max:params.max, offset:params.offset])  {
			createAlias("tank", "t")
			if(department) {
				eq("t.department", department)
			}
			else{
				'in'("t.department",departmentList)
			}
			if(tankNo) {
				eq("t.tankNo", tankNo)
			}
			if(dateFrom) {
				ge("checkTime", dateFrom)
			}
			if(dateTo) {
				le("checkTime", dateTo)
			}
		}
		def tankList = GasTank.createCriteria().list()  {
			if(department) {
				eq("department", department)
			}
		}
        [gasTankLevelInstanceList: tankLevel, gasTankLevelInstanceTotal: tankLevel.totalCount, tankList:tankList]
    }

    def create = {
        def gasTankLevelInstance = new GasTankLevel()
        gasTankLevelInstance.properties = params
        return [gasTankLevelInstance: gasTankLevelInstance]
    }

    def save = {
        def gasTankLevelInstance = new GasTankLevel(params)
		gasTankLevelInstance.user = springSecurityService.currentUser
        if (gasTankLevelInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), gasTankLevelInstance.id])}"
            redirect(action: "show", id: gasTankLevelInstance.id)
        }
        else {
            render(view: "create", model: [gasTankLevelInstance: gasTankLevelInstance])
        }
    }

    def show = {
        def gasTankLevelInstance = GasTankLevel.get(params.id)
        if (!gasTankLevelInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gasTankLevelInstance: gasTankLevelInstance]
        }
    }

    def edit = {
        def gasTankLevelInstance = GasTankLevel.get(params.id)
        if (!gasTankLevelInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gasTankLevelInstance: gasTankLevelInstance]
        }
    }

    def update = {
        def gasTankLevelInstance = GasTankLevel.get(params.id)
        if (gasTankLevelInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gasTankLevelInstance.version > version) {
                    
                    gasTankLevelInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gasTankLevel.label', default: 'GasTankLevel')] as Object[], "Another user has updated this GasTankLevel while you were editing")
                    render(view: "edit", model: [gasTankLevelInstance: gasTankLevelInstance])
                    return
                }
            }
            gasTankLevelInstance.properties = params
            if (!gasTankLevelInstance.hasErrors() && gasTankLevelInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), gasTankLevelInstance.id])}"
                redirect(action: "show", id: gasTankLevelInstance.id)
            }
            else {
                render(view: "edit", model: [gasTankLevelInstance: gasTankLevelInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gasTankLevelInstance = GasTankLevel.get(params.id)
        if (gasTankLevelInstance) {
            try {
                gasTankLevelInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasTankLevel.label', default: 'GasTankLevel'), params.id])}"
            redirect(action: "list")
        }
    }
}
