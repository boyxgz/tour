package com.surelution.tour

class GasGunCheckingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [gasGunCheckingInstanceList: GasGunChecking.list(params), gasGunCheckingInstanceTotal: GasGunChecking.count()]
    }

    def create = {
        def gasGunCheckingInstance = new GasGunChecking()
        gasGunCheckingInstance.properties = params
        return [gasGunCheckingInstance: gasGunCheckingInstance]
    }

    def save = {
		def user = springSecurityService.currentUser
        def gasGunCheckingInstance = new GasGunChecking(params)
		gasGunCheckingInstance.user = user
        if (gasGunCheckingInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), gasGunCheckingInstance.id])}"
            redirect(action: "show", id: gasGunCheckingInstance.id)
        }
        else {
            render(view: "create", model: [gasGunCheckingInstance: gasGunCheckingInstance])
        }
    }

    def show = {
        def gasGunCheckingInstance = GasGunChecking.get(params.id)
        if (!gasGunCheckingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gasGunCheckingInstance: gasGunCheckingInstance]
        }
    }

    def edit = {
        def gasGunCheckingInstance = GasGunChecking.get(params.id)
        if (!gasGunCheckingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gasGunCheckingInstance: gasGunCheckingInstance]
        }
    }

    def update = {
        def gasGunCheckingInstance = GasGunChecking.get(params.id)
        if (gasGunCheckingInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gasGunCheckingInstance.version > version) {
                    
                    gasGunCheckingInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gasGunChecking.label', default: 'GasGunChecking')] as Object[], "Another user has updated this GasGunChecking while you were editing")
                    render(view: "edit", model: [gasGunCheckingInstance: gasGunCheckingInstance])
                    return
                }
            }
            gasGunCheckingInstance.properties = params
            if (!gasGunCheckingInstance.hasErrors() && gasGunCheckingInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), gasGunCheckingInstance.id])}"
                redirect(action: "show", id: gasGunCheckingInstance.id)
            }
            else {
                render(view: "edit", model: [gasGunCheckingInstance: gasGunCheckingInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gasGunCheckingInstance = GasGunChecking.get(params.id)
        if (gasGunCheckingInstance) {
            try {
                gasGunCheckingInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasGunChecking.label', default: 'GasGunChecking'), params.id])}"
            redirect(action: "list")
        }
    }
}
