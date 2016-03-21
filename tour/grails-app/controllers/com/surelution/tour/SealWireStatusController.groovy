package com.surelution.tour

class SealWireStatusController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sealWireStatusInstanceList: SealWireStatus.list(params), sealWireStatusInstanceTotal: SealWireStatus.count()]
    }

    def create = {
        def sealWireStatusInstance = new SealWireStatus()
        sealWireStatusInstance.properties = params
        return [sealWireStatusInstance: sealWireStatusInstance]
    }

    def save = {
        def sealWireStatusInstance = new SealWireStatus(params)
        if (sealWireStatusInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'sealWireStatus.label', default: 'SealWireStatus'), sealWireStatusInstance.id])}"
            redirect(action: "show", id: sealWireStatusInstance.id)
        }
        else {
            render(view: "create", model: [sealWireStatusInstance: sealWireStatusInstance])
        }
    }

    def show = {
        def sealWireStatusInstance = SealWireStatus.get(params.id)
        if (!sealWireStatusInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWireStatus.label', default: 'SealWireStatus'), params.id])}"
            redirect(action: "list")
        }
        else {
            [sealWireStatusInstance: sealWireStatusInstance]
        }
    }

    def edit = {
        def sealWireStatusInstance = SealWireStatus.get(params.id)
        if (!sealWireStatusInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWireStatus.label', default: 'SealWireStatus'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [sealWireStatusInstance: sealWireStatusInstance]
        }
    }

    def update = {
        def sealWireStatusInstance = SealWireStatus.get(params.id)
        if (sealWireStatusInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (sealWireStatusInstance.version > version) {
                    
                    sealWireStatusInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'sealWireStatus.label', default: 'SealWireStatus')] as Object[], "Another user has updated this SealWireStatus while you were editing")
                    render(view: "edit", model: [sealWireStatusInstance: sealWireStatusInstance])
                    return
                }
            }
            sealWireStatusInstance.properties = params
            if (!sealWireStatusInstance.hasErrors() && sealWireStatusInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'sealWireStatus.label', default: 'SealWireStatus'), sealWireStatusInstance.id])}"
                redirect(action: "show", id: sealWireStatusInstance.id)
            }
            else {
                render(view: "edit", model: [sealWireStatusInstance: sealWireStatusInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWireStatus.label', default: 'SealWireStatus'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def sealWireStatusInstance = SealWireStatus.get(params.id)
        if (sealWireStatusInstance) {
            try {
                sealWireStatusInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'sealWireStatus.label', default: 'SealWireStatus'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'sealWireStatus.label', default: 'SealWireStatus'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'sealWireStatus.label', default: 'SealWireStatus'), params.id])}"
            redirect(action: "list")
        }
    }
}
