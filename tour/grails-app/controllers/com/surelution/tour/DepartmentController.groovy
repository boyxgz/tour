package com.surelution.tour

import com.surelution.core.SystemInfo

class DepartmentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def departmentInstanceList = Department.list(params)
		def totalCount = departmentInstanceList.count()
		def departmentId = params['department.id']?params['department.id']:null
		if (departmentId){
			departmentInstanceList = Department.get(departmentId)
			totalCount = 0
		}
        [departmentInstanceList: departmentInstanceList, departmentInstanceTotal: totalCount]
    }

    def create = {
        def departmentInstance = new Department()
        departmentInstance.properties = params
        return [departmentInstance: departmentInstance]
    }

    def save = {
        def departmentInstance = new Department(params)
        if (departmentInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])}"
            redirect(action: "show", id: departmentInstance.id)
        }
        else {
            render(view: "create", model: [departmentInstance: departmentInstance])
        }
    }

    def show = {
        def departmentInstance = Department.get(params.id)
        if (!departmentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
            redirect(action: "list")
        }
        else {
			def pois = Poi.findAllByDepartment(departmentInstance)
            [departmentInstance: departmentInstance, poiInstanceList: pois]
        }
    }

    def edit = {
        def departmentInstance = Department.get(params.id)
        if (!departmentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [departmentInstance: departmentInstance]
        }
    }

    def update = {
        def departmentInstance = Department.get(params.id)
        if (departmentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (departmentInstance.version > version) {
                    
                    departmentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'department.label', default: 'Department')] as Object[], "Another user has updated this Department while you were editing")
                    render(view: "edit", model: [departmentInstance: departmentInstance])
                    return
                }
            }
            departmentInstance.properties = params
            if (!departmentInstance.hasErrors() && departmentInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'department.label', default: 'Department'), departmentInstance.id])}"
                redirect(action: "show", id: departmentInstance.id)
            }
            else {
                render(view: "edit", model: [departmentInstance: departmentInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def departmentInstance = Department.get(params.id)
        if (departmentInstance) {
            try {
                departmentInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'department.label', default: 'Department'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def poiAdd = {
		def department = Department.get(params["department.id"])
		if(department) {
			SystemInfo si = servletContext["system-info"]
			def sn = params.sn
			if(sn && si.poiContains(sn)) {
				def name = params.name
				def description = params.description
				def poi = new Poi(department:department, sn:sn, name:name, description:description)
				println poi
				poi.save(flush:true)
			} else {
			    flash.message ="${message(code: 'poi.wrongsn.message')}"
			}
		}
		
		def pois = Poi.findAllByDepartment(department)
		
		render(view:"show", model:[departmentInstance: department, poiInstanceList: pois])
	}
	
	def searchAJAX = {
		def depts = Department.findAllByNameLike("%${params.query}%")

		//Create XML response
		render(contentType: "text/xml") {
			results() {
				depts.each { dept ->
					result(){
						name(dept.name)
						id(dept.id)
					}
				}
			}
		}
	}
}
