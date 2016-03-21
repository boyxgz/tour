package com.surelution.tour

class GasTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [gasTypeInstanceList: GasType.list(params), gasTypeInstanceTotal: GasType.count()]
    }

    def create = {
        def gasTypeInstance = new GasType()
        gasTypeInstance.properties = params
        return [gasTypeInstance: gasTypeInstance]
    }

    def save = {
        def gasTypeInstance = new GasType(params)
        if (gasTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasType.label', default: 'GasType'), gasTypeInstance.id])}"
            redirect(action: "show", id: gasTypeInstance.id)
        }
        else {
            render(view: "create", model: [gasTypeInstance: gasTypeInstance])
        }
    }

    def show = {
        def gasTypeInstance = GasType.get(params.id)
        if (!gasTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasType.label', default: 'GasType'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gasTypeInstance: gasTypeInstance]
        }
    }

    def edit = {
        def gasTypeInstance = GasType.get(params.id)
        if (!gasTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasType.label', default: 'GasType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [gasTypeInstance: gasTypeInstance]
        }
    }

    def update = {
        def gasTypeInstance = GasType.get(params.id)
        if (gasTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (gasTypeInstance.version > version) {
                    
                    gasTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gasType.label', default: 'GasType')] as Object[], "Another user has updated this GasType while you were editing")
                    render(view: "edit", model: [gasTypeInstance: gasTypeInstance])
                    return
                }
            }
            gasTypeInstance.properties = params
            if (!gasTypeInstance.hasErrors() && gasTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gasType.label', default: 'GasType'), gasTypeInstance.id])}"
                redirect(action: "show", id: gasTypeInstance.id)
            }
            else {
                render(view: "edit", model: [gasTypeInstance: gasTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasType.label', default: 'GasType'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def gasTypeInstance = GasType.get(params.id)
        if (gasTypeInstance) {
            try {
                gasTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gasType.label', default: 'GasType'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gasType.label', default: 'GasType'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasType.label', default: 'GasType'), params.id])}"
            redirect(action: "list")
        }
    }
}
