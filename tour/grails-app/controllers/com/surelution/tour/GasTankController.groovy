package com.surelution.tour

class GasTankController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def department = params['department.id']?Department.get(params['department.id']):null
		def result = GasTank.createCriteria().list ([max:params.max, offset:params.offset]){
			if(department) {
				eq("department", department)
			}
		}
		result.sort{
			it.department.id
		}
        [gasTankInstanceList: result, gasTankInstanceTotal: result.totalCount]
    }

    def create = {
        def gasTankInstance = new GasTank()
        gasTankInstance.properties = params
        return [gasTankInstance: gasTankInstance]
    }

    def save = {
        def gasTankInstance = new GasTank(params)
        if (gasTankInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasTank.label', default: 'GasTank'), gasTankInstance.id])}"
            redirect(action: "show", id: gasTankInstance.id)
        }
        else {
            render(view: "create", model: [gasTankInstance: gasTankInstance])
        }
    }

    def show = {
        def gasTankInstance = GasTank.get(params.id)
        if (!gasTankInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasTank.label', default: 'GasTank'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gasTankInstance: gasTankInstance]
        }
    }

    def edit = {
        def gasTankInstance = GasTank.get(params.id)
        if (!gasTankInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasTank.label', default: 'GasTank'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gasTankInstance: gasTankInstance]
        }
    }

    def update = {
        def gasTankInstance = GasTank.get(params.id)
        if (gasTankInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gasTankInstance.version > version) {
                    
                    gasTankInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gasTank.label', default: 'GasTank')] as Object[], "Another user has updated this GasTank while you were editing")
                    render(view: "edit", model: [gasTankInstance: gasTankInstance])
                    return
                }
            }
            gasTankInstance.properties = params
            if (!gasTankInstance.hasErrors() && gasTankInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gasTank.label', default: 'GasTank'), gasTankInstance.id])}"
                redirect(action: "show", id: gasTankInstance.id)
            }
            else {
                render(view: "edit", model: [gasTankInstance: gasTankInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasTank.label', default: 'GasTank'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gasTankInstance = GasTank.get(params.id)
        if (gasTankInstance) {
            try {
                gasTankInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gasTank.label', default: 'GasTank'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gasTank.label', default: 'GasTank'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasTank.label', default: 'GasTank'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def loadTanksByDepartment = {
		def dept = Department.get(params.departmentId)
		def tanks
		if(dept) 
			tanks = GasTank.findAllByDepartment(dept)
		render(contentType:"text/xml") {
			department("id":dept.id, "name":dept.name) {
				tanks.each {t->
					tank("id":t.id, "tankNo":t.tankNo, "description":t.description, "volume":t.volume, "gasType":t.gasType.title)
				}
			}
		
		}
	}
	
	def loadTanksByDepartmentAndGasType = {
		def dept = Department.get(params.departmentId)
		def gasType = GasType.get(params.gasTypeId)
		def tanks = GasTank.findAllByDepartmentAndGasType(dept, gasType)
		render(contentType:"text/xml") {
			department("id":dept.id, "name":dept.name) {
				tanks.each {t->
					tank("id":t.id, "tankNo":t.tankNo, "description":t.description, "volume":t.volume, "gasType":t.gasType.title)
				}
			}
		
		}
	}
}
