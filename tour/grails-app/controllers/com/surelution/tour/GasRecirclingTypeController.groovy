package com.surelution.tour

class GasRecirclingTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [gasRecirclingTypeInstanceList: GasRecirclingType.list(params), gasRecirclingTypeInstanceTotal: GasRecirclingType.count()]
    }

    def create = {
        def gasRecirclingTypeInstance = new GasRecirclingType()
        gasRecirclingTypeInstance.properties = params
        return [gasRecirclingTypeInstance: gasRecirclingTypeInstance]
    }

    def save = {
        def gasRecirclingTypeInstance = new GasRecirclingType(params)
        if (gasRecirclingTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType'), gasRecirclingTypeInstance.id])}"
            redirect(action: "show", id: gasRecirclingTypeInstance.id)
        }
        else {
            render(view: "create", model: [gasRecirclingTypeInstance: gasRecirclingTypeInstance])
        }
    }

    def show = {
        def gasRecirclingTypeInstance = GasRecirclingType.get(params.id)
        if (!gasRecirclingTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gasRecirclingTypeInstance: gasRecirclingTypeInstance]
        }
    }

    def edit = {
        def gasRecirclingTypeInstance = GasRecirclingType.get(params.id)
        if (!gasRecirclingTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gasRecirclingTypeInstance: gasRecirclingTypeInstance]
        }
    }

    def update = {
        def gasRecirclingTypeInstance = GasRecirclingType.get(params.id)
        if (gasRecirclingTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gasRecirclingTypeInstance.version > version) {
                    
                    gasRecirclingTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType')] as Object[], "Another user has updated this GasRecirclingType while you were editing")
                    render(view: "edit", model: [gasRecirclingTypeInstance: gasRecirclingTypeInstance])
                    return
                }
            }
            gasRecirclingTypeInstance.properties = params
            if (!gasRecirclingTypeInstance.hasErrors() && gasRecirclingTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType'), gasRecirclingTypeInstance.id])}"
                redirect(action: "show", id: gasRecirclingTypeInstance.id)
            }
            else {
                render(view: "edit", model: [gasRecirclingTypeInstance: gasRecirclingTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gasRecirclingTypeInstance = GasRecirclingType.get(params.id)
        if (gasRecirclingTypeInstance) {
            try {
                gasRecirclingTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasRecirclingType.label', default: 'GasRecirclingType'), params.id])}"
            redirect(action: "list")
        }
    }
}
