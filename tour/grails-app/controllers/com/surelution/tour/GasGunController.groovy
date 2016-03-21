package com.surelution.tour

class GasGunController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def deptId = params.'department.id'
		def dept
		if(deptId) {
			dept = Department.get(deptId)
		}
		def result = GasGun.createCriteria().list([max:(params.max), offset:params.offset]){
			createAlias("tank", "t")
			if(dept) {
				eq("t.department",dept)
			}
		}
        [gasGunInstanceList: result.sort{it.tank.department.id * 1000 + it.tank.id}, gasGunInstanceTotal: result.totalCount]
    }

    def create = {
        def gasGunInstance = new GasGun()
        gasGunInstance.properties = params
        return [gasGunInstance: gasGunInstance]
    }

    def save = {
        def gasGunInstance = new GasGun(params)
        if (gasGunInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasGun.label', default: 'GasGun'), gasGunInstance.id])}"
            redirect(action: "show", id: gasGunInstance.id)
        }
        else {
            render(view: "create", model: [gasGunInstance: gasGunInstance])
        }
    }

    def show = {
        def gasGunInstance = GasGun.get(params.id)
        if (!gasGunInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasGun.label', default: 'GasGun'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gasGunInstance: gasGunInstance]
        }
    }

    def edit = {
        def gasGunInstance = GasGun.get(params.id)
        if (!gasGunInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasGun.label', default: 'GasGun'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gasGunInstance: gasGunInstance]
        }
    }

    def update = {
        def gasGunInstance = GasGun.get(params.id)
        if (gasGunInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gasGunInstance.version > version) {
                    
                    gasGunInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gasGun.label', default: 'GasGun')] as Object[], "Another user has updated this GasGun while you were editing")
                    render(view: "edit", model: [gasGunInstance: gasGunInstance])
                    return
                }
            }
            gasGunInstance.properties = params
            if (!gasGunInstance.hasErrors() && gasGunInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gasGun.label', default: 'GasGun'), gasGunInstance.id])}"
                redirect(action: "show", id: gasGunInstance.id)
            }
            else {
                render(view: "edit", model: [gasGunInstance: gasGunInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasGun.label', default: 'GasGun'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gasGunInstance = GasGun.get(params.id)
        if (gasGunInstance) {
            try {
                gasGunInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gasGun.label', default: 'GasGun'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gasGun.label', default: 'GasGun'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasGun.label', default: 'GasGun'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def loadGasGunsByDepartment = {
		def deptId = params.departmentId
		def dept = Department.get(deptId)
		def cri = GasGun.createCriteria()
		def guns = cri.list() {
			createAlias("tank", "t")
			eq("t.department", dept)
		}
		render(contentType:"text/xml") {
			department("id":dept.id, "name":dept.name) {
				guns.each {g->
					gun("id":g.id, "gunNo":g.gunNo)
				}
			}
		}
	}
	
	def loadGasGunsByTank = {
		def tankId = params.tankId
		def t = GasTank.get(tankId)
		def guns = GasGun.findAllByTank(t)
		render(contentType:"text/xml") {
			tank("id":t.id, "tankNo":t.tankNo) {
				guns.each {g->
					gun("id":g.id, "gunNo":g.gunNo)
				}
			}
		}
	}
}
