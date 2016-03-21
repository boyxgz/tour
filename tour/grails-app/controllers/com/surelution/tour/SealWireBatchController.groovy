package com.surelution.tour

class SealWireBatchController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	def springSecurityService
	
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def departmentList = UserDepartment.getUserDepartments(springSecurityService.currentUser.toString())
		def department = params['department.id']?Department.get(params['department.id']):null
		def sealWireBatchList = SealWireBatch.createCriteria().list([max:params.max, offset:params.offset])  {
			if(department) {
				eq("department", department)
			}
			else{
				'in'("department",departmentList)
			}
		}
        [sealWireBatchInstanceList: sealWireBatchList, sealWireBatchInstanceTotal: sealWireBatchList.totalCount]
    }

    def create = {
        def sealWireBatchInstance = new SealWireBatch()
        sealWireBatchInstance.properties = params
        return [sealWireBatchInstance: sealWireBatchInstance]
    }

    def save = {
        def sealWireBatchInstance = new SealWireBatch(params)
		
		def prefix = sealWireBatchInstance.prefix
		def start = sealWireBatchInstance.start
		def end = sealWireBatchInstance.end
		if(end >= start) {
			def overlapCount = SealWireBatch.createCriteria().count {
				eq("prefix", prefix)
				and {
					le("start", end)
					ge("end", start)
				}
			}
			if(overlapCount <= 0) {
				sealWireBatchInstance.importUser = User.findByUsername(springSecurityService.principal.username)
				sealWireBatchInstance.importDate = new Date()
		        if (sealWireBatchInstance.save(flush: true)) {
					(sealWireBatchInstance.start .. sealWireBatchInstance.end).each {
						def sealWire = new SealWire(prefix:sealWireBatchInstance.prefix, 
							sn:"${it}", department:sealWireBatchInstance.department, 
							available:true, importBatch:sealWireBatchInstance)
						sealWire.save(flush:true)
					}
		            flash.message = "${message(code: 'default.created.message', args: [message(code: 'sealWireBatch.label', default: 'SealWireBatch'), sealWireBatchInstance.id])}"
		            redirect(action: "show", id: sealWireBatchInstance.id)
					return
		        }
				
			}
			
		}
		flash.message = "导入铅封有着非常严格的检查，请仔细核对您输入的铅封信息是否与您领到的铅封信息一致，或联系系统管理员"
        render(view: "create", model: [sealWireBatchInstance: sealWireBatchInstance])
    }

    def show = {
        def sealWireBatchInstance = SealWireBatch.get(params.id)
        if (!sealWireBatchInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWireBatch.label', default: 'SealWireBatch'), params.id])}"
            redirect(action: "list")
        }
        else {
            [sealWireBatchInstance: sealWireBatchInstance]
        }
    }

    def edit = {
        def sealWireBatchInstance = SealWireBatch.get(params.id)
        if (!sealWireBatchInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWireBatch.label', default: 'SealWireBatch'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [sealWireBatchInstance: sealWireBatchInstance]
        }
    }

    def update = {
        def sealWireBatchInstance = SealWireBatch.get(params.id)
        if (sealWireBatchInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sealWireBatchInstance.version > version) {
                    
                    sealWireBatchInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sealWireBatch.label', default: 'SealWireBatch')] as Object[], "Another user has updated this SealWireBatch while you were editing")
                    render(view: "edit", model: [sealWireBatchInstance: sealWireBatchInstance])
                    return
                }
            }
            sealWireBatchInstance.properties = params
            if (!sealWireBatchInstance.hasErrors() && sealWireBatchInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sealWireBatch.label', default: 'SealWireBatch'), sealWireBatchInstance.id])}"
                redirect(action: "show", id: sealWireBatchInstance.id)
            }
            else {
                render(view: "edit", model: [sealWireBatchInstance: sealWireBatchInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWireBatch.label', default: 'SealWireBatch'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def sealWireBatchInstance = SealWireBatch.get(params.id)
        if (sealWireBatchInstance) {
            try {
                sealWireBatchInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sealWireBatch.label', default: 'SealWireBatch'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'sealWireBatch.label', default: 'SealWireBatch'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWireBatch.label', default: 'SealWireBatch'), params.id])}"
            redirect(action: "list")
        }
    }
}
