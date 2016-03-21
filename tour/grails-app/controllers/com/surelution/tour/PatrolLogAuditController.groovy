package com.surelution.tour

class PatrolLogAuditController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [patrolLogAuditInstanceList: PatrolLogAudit.list(params), patrolLogAuditInstanceTotal: PatrolLogAudit.count()]
    }

    def create = {
        def patrolLogAuditInstance = new PatrolLogAudit()
        patrolLogAuditInstance.properties = params
        return [patrolLogAuditInstance: patrolLogAuditInstance]
    }

    def save = {
        def patrolLogAuditInstance = new PatrolLogAudit(params)
        if (patrolLogAuditInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit'), patrolLogAuditInstance.id])}"
            redirect(action: "show", id: patrolLogAuditInstance.id)
        }
        else {
            render(view: "create", model: [patrolLogAuditInstance: patrolLogAuditInstance])
        }
    }

    def show = {
        def patrolLogAuditInstance = PatrolLogAudit.get(params.id)
        if (!patrolLogAuditInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit'), params.id])}"
            redirect(action: "list")
        }
        else {
			def patrolLog = patrolLogAuditInstance.patrolLog
			def patrol = patrolLog.patrol
            redirect(controller:"patrol", action: "show", id:patrol.id)
        }
    }

    def edit = {
        def patrolLogAuditInstance = PatrolLogAudit.get(params.id)
        if (!patrolLogAuditInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [patrolLogAuditInstance: patrolLogAuditInstance]
        }
    }

    def update = {
        def patrolLogAuditInstance = PatrolLogAudit.get(params.id)
        if (patrolLogAuditInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (patrolLogAuditInstance.version > version) {
                    
                    patrolLogAuditInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit')] as Object[], "Another user has updated this PatrolLogAudit while you were editing")
                    render(view: "edit", model: [patrolLogAuditInstance: patrolLogAuditInstance])
                    return
                }
            }
            patrolLogAuditInstance.properties = params
            if (!patrolLogAuditInstance.hasErrors() && patrolLogAuditInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit'), patrolLogAuditInstance.id])}"
                redirect(action: "show", id: patrolLogAuditInstance.id)
            }
            else {
                render(view: "edit", model: [patrolLogAuditInstance: patrolLogAuditInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def patrolLogAuditInstance = PatrolLogAudit.get(params.id)
        if (patrolLogAuditInstance) {
            try {
                patrolLogAuditInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogAudit.label', default: 'PatrolLogAudit'), params.id])}"
            redirect(action: "list")
        }
    }
}
