package com.surelution.tour

class LeaveController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [leaveInstanceList: Leave.list(params), leaveInstanceTotal: Leave.count()]
    }

    def create = {
        def leaveInstance = new Leave()
        leaveInstance.properties = params
		
		def users = User.findAllByPatrolType(PatrolType.get(2))
		
        return [leaveInstance: leaveInstance, users:users]
    }

    def save = {
        def leaveInstance = new Leave(params)
		if(leaveInstance.from > leaveInstance.to) {
            flash.message = "${message(code: 'default.date.error.message')}"
			redirect(action:"create")
			return
		}
        if (leaveInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'leave.label', default: 'Leave'), leaveInstance.id])}"
            redirect(action: "show", id: leaveInstance.id)
        }
        else {
            render(view: "create", model: [leaveInstance: leaveInstance])
        }
    }

    def show = {
        def leaveInstance = Leave.get(params.id)
        if (!leaveInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'leave.label', default: 'Leave'), params.id])}"
            redirect(action: "list")
        }
        else {
            [leaveInstance: leaveInstance]
        }
    }

    def edit = {
        def leaveInstance = Leave.get(params.id)
		        if (!leaveInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'leave.label', default: 'Leave'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [leaveInstance: leaveInstance]
        }
    }

    def update = {
        def leaveInstance = Leave.get(params.id)
        if (leaveInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (leaveInstance.version > version) {
                    
                    leaveInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'leave.label', default: 'Leave')] as Object[], "Another user has updated this Leave while you were editing")
                    render(view: "edit", model: [leaveInstance: leaveInstance])
                    return
                }
            }
			if(leaveInstance.from > leaveInstance.to) {
                flash.message = "${message(code: 'default.date.error.message')}"
                render(view: "edit", model: [leaveInstance: leaveInstance])
				return
			}
            leaveInstance.properties = params
            if (!leaveInstance.hasErrors() && leaveInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'leave.label', default: 'Leave'), leaveInstance.id])}"
                redirect(action: "show", id: leaveInstance.id)
            }
            else {
                render(view: "edit", model: [leaveInstance: leaveInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'leave.label', default: 'Leave'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def leaveInstance = Leave.get(params.id)
        if (leaveInstance) {
            try {
                leaveInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'leave.label', default: 'Leave'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'leave.label', default: 'Leave'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'leave.label', default: 'Leave'), params.id])}"
            redirect(action: "list")
        }
    }
}
