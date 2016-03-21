package com.surelution.tour

class PatrolLogItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [patrolLogItemInstanceList: PatrolLogItem.list(params), patrolLogItemInstanceTotal: PatrolLogItem.count()]
    }

    def create = {
        def patrolLogItemInstance = new PatrolLogItem()
        patrolLogItemInstance.properties = params
        return [patrolLogItemInstance: patrolLogItemInstance]
    }

    def save = {
        def patrolLogItemInstance = new PatrolLogItem(params)
        if (patrolLogItemInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'patrolLogItem.label', default: 'PatrolLogItem'), patrolLogItemInstance.id])}"
            redirect(action: "show", id: patrolLogItemInstance.id)
        }
        else {
            render(view: "create", model: [patrolLogItemInstance: patrolLogItemInstance])
        }
    }

    def show = {
        def patrolLogItemInstance = PatrolLogItem.get(params.id)
        if (!patrolLogItemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogItem.label', default: 'PatrolLogItem'), params.id])}"
            redirect(action: "list")
        }
        else {
            [patrolLogItemInstance: patrolLogItemInstance]
        }
    }

    def edit = {
        def patrolLogItemInstance = PatrolLogItem.get(params.id)
        if (!patrolLogItemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogItem.label', default: 'PatrolLogItem'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [patrolLogItemInstance: patrolLogItemInstance]
        }
    }

    def update = {
        def patrolLogItemInstance = PatrolLogItem.get(params.id)
        if (patrolLogItemInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (patrolLogItemInstance.version > version) {
                    
                    patrolLogItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'patrolLogItem.label', default: 'PatrolLogItem')] as Object[], "Another user has updated this PatrolLogItem while you were editing")
                    render(view: "edit", model: [patrolLogItemInstance: patrolLogItemInstance])
                    return
                }
            }
            patrolLogItemInstance.properties = params
            if (!patrolLogItemInstance.hasErrors() && patrolLogItemInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'patrolLogItem.label', default: 'PatrolLogItem'), patrolLogItemInstance.id])}"
                redirect(action: "show", id: patrolLogItemInstance.id)
            }
            else {
                render(view: "edit", model: [patrolLogItemInstance: patrolLogItemInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogItem.label', default: 'PatrolLogItem'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def patrolLogItemInstance = PatrolLogItem.get(params.id)
        if (patrolLogItemInstance) {
            try {
                patrolLogItemInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'patrolLogItem.label', default: 'PatrolLogItem'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'patrolLogItem.label', default: 'PatrolLogItem'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogItem.label', default: 'PatrolLogItem'), params.id])}"
            redirect(action: "list")
        }
    }
}
