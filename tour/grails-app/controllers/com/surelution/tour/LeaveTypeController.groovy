package com.surelution.tour

class LeaveTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [leaveTypeInstanceList: LeaveType.list(params), leaveTypeInstanceTotal: LeaveType.count()]
    }

    def create = {
        def leaveTypeInstance = new LeaveType()
        leaveTypeInstance.properties = params
        return [leaveTypeInstance: leaveTypeInstance]
    }

    def save = {
        def leaveTypeInstance = new LeaveType(params)
        if (leaveTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'leaveType.label', default: 'LeaveType'), leaveTypeInstance.id])}"
            redirect(action: "show", id: leaveTypeInstance.id)
        }
        else {
            render(view: "create", model: [leaveTypeInstance: leaveTypeInstance])
        }
    }

    def show = {
        def leaveTypeInstance = LeaveType.get(params.id)
        if (!leaveTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'leaveType.label', default: 'LeaveType'), params.id])}"
            redirect(action: "list")
        }
        else {
            [leaveTypeInstance: leaveTypeInstance]
        }
    }

    def edit = {
        def leaveTypeInstance = LeaveType.get(params.id)
        if (!leaveTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'leaveType.label', default: 'LeaveType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [leaveTypeInstance: leaveTypeInstance]
        }
    }

    def update = {
        def leaveTypeInstance = LeaveType.get(params.id)
        if (leaveTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (leaveTypeInstance.version > version) {
                    
                    leaveTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'leaveType.label', default: 'LeaveType')] as Object[], "Another user has updated this LeaveType while you were editing")
                    render(view: "edit", model: [leaveTypeInstance: leaveTypeInstance])
                    return
                }
            }
            leaveTypeInstance.properties = params
            if (!leaveTypeInstance.hasErrors() && leaveTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'leaveType.label', default: 'LeaveType'), leaveTypeInstance.id])}"
                redirect(action: "show", id: leaveTypeInstance.id)
            }
            else {
                render(view: "edit", model: [leaveTypeInstance: leaveTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'leaveType.label', default: 'LeaveType'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def leaveTypeInstance = LeaveType.get(params.id)
        if (leaveTypeInstance) {
            try {
                leaveTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'leaveType.label', default: 'LeaveType'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'leaveType.label', default: 'LeaveType'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'leaveType.label', default: 'LeaveType'), params.id])}"
            redirect(action: "list")
        }
    }
}
