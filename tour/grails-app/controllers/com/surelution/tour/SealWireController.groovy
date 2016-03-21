package com.surelution.tour

import java.text.SimpleDateFormat

class SealWireController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	def springSecurityService
	
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def departmentList = UserDepartment.getUserDepartments(springSecurityService.currentUser.toString())
		def department = params['department.id']?Department.get(params['department.id']):null
		def sealWireSn = params.sealWireSn?params.sealWireSn:null
		def sealWireList = SealWire.createCriteria().list([max:params.max, offset:params.offset])  {
			if(department) {
				eq("department", department)
			}
			else{
				'in'("department",departmentList)
			}
			if(sealWireSn) {
				eq("sn", sealWireSn)
			}
		}
        [sealWireInstanceList: sealWireList, sealWireInstanceTotal: sealWireList.totalCount]
    }

    def create = {
        def sealWireInstance = new SealWire()
        sealWireInstance.properties = params
        return [sealWireInstance: sealWireInstance]
    }

    def save = {
        def sealWireInstance = new SealWire(params)
        if (sealWireInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'sealWire.label', default: 'SealWire'), sealWireInstance.id])}"
            redirect(action: "show", id: sealWireInstance.id)
        }
        else {
            render(view: "create", model: [sealWireInstance: sealWireInstance])
        }
    }

    def show = {
        def sealWireInstance = SealWire.get(params.id)
        if (!sealWireInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWire.label', default: 'SealWire'), params.id])}"
            redirect(action: "list")
        }
        else {
            [sealWireInstance: sealWireInstance]
        }
    }

    def edit = {
        def sealWireInstance = SealWire.get(params.id)
        if (!sealWireInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWire.label', default: 'SealWire'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [sealWireInstance: sealWireInstance]
        }
    }

    def update = {
        def sealWireInstance = SealWire.get(params.id)
        if (sealWireInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sealWireInstance.version > version) {
                    
                    sealWireInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sealWire.label', default: 'SealWire')] as Object[], "Another user has updated this SealWire while you were editing")
                    render(view: "edit", model: [sealWireInstance: sealWireInstance])
                    return
                }
            }
            sealWireInstance.properties = params
            if (!sealWireInstance.hasErrors() && sealWireInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sealWire.label', default: 'SealWire'), sealWireInstance.id])}"
                redirect(action: "show", id: sealWireInstance.id)
            }
            else {
                render(view: "edit", model: [sealWireInstance: sealWireInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWire.label', default: 'SealWire'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def sealWireInstance = SealWire.get(params.id)
        if (sealWireInstance) {
            try {
                sealWireInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sealWire.label', default: 'SealWire'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'sealWire.label', default: 'SealWire'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWire.label', default: 'SealWire'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def loadAvailableSeal = {
		def dept = Department.get(params.departmentId)
		def ss = SealWire.findAllByDepartmentAndAvailable(dept, true)
		render(contentType:"text/xml") {
			seals() {
				ss.each {t->
					seal("id":t.id, "prefix":t.prefix, "sn":t.sn)
				}
			}
		
		}
	
	}
}
