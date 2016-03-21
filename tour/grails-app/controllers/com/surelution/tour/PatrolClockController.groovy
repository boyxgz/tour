package com.surelution.tour

class PatrolClockController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [patrolClockInstanceList: PatrolClock.list(params), patrolClockInstanceTotal: PatrolClock.count()]
    }

    def create = {
        def patrolClockInstance = new PatrolClock()
        patrolClockInstance.properties = params
        return [patrolClockInstance: patrolClockInstance]
    }

    def save = {
        def patrolClockInstance = new PatrolClock(params)
        if (patrolClockInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'patrolClock.label', default: 'PatrolClock'), patrolClockInstance.id])}"
            redirect(action: "show", id: patrolClockInstance.id)
        }
        else {
            render(view: "create", model: [patrolClockInstance: patrolClockInstance])
        }
    }

    def show = {
        def patrolClockInstance = PatrolClock.get(params.id)
        if (!patrolClockInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolClock.label', default: 'PatrolClock'), params.id])}"
            redirect(action: "list")
        }
        else {
            [patrolClockInstance: patrolClockInstance]
        }
    }

    def edit = {
        def patrolClockInstance = PatrolClock.get(params.id)
        if (!patrolClockInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolClock.label', default: 'PatrolClock'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [patrolClockInstance: patrolClockInstance]
        }
    }

    def update = {
        def patrolClockInstance = PatrolClock.get(params.id)
        if (patrolClockInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (patrolClockInstance.version > version) {
                    
                    patrolClockInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'patrolClock.label', default: 'PatrolClock')] as Object[], "Another user has updated this PatrolClock while you were editing")
                    render(view: "edit", model: [patrolClockInstance: patrolClockInstance])
                    return
                }
            }
            patrolClockInstance.properties = params
            if (!patrolClockInstance.hasErrors() && patrolClockInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'patrolClock.label', default: 'PatrolClock'), patrolClockInstance.id])}"
                redirect(action: "show", id: patrolClockInstance.id)
            }
            else {
                render(view: "edit", model: [patrolClockInstance: patrolClockInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolClock.label', default: 'PatrolClock'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def patrolClockInstance = PatrolClock.get(params.id)
        if (patrolClockInstance) {
            try {
                patrolClockInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'patrolClock.label', default: 'PatrolClock'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'patrolClock.label', default: 'PatrolClock'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolClock.label', default: 'PatrolClock'), params.id])}"
            redirect(action: "list")
        }
    }
}
