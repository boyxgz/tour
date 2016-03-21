package com.surelution.tour

class SystemMessageController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [systemMessageInstanceList: SystemMessage.list(params), systemMessageInstanceTotal: SystemMessage.count()]
    }

//    def create = {
//        def systemMessageInstance = new SystemMessage()
//        systemMessageInstance.properties = params
//        return [systemMessageInstance: systemMessageInstance]
//    }
//
//    def save = {
//        def systemMessageInstance = new SystemMessage(params)
//        if (systemMessageInstance.save(flush: true)) {
//            flash.message = "${message(code: 'default.created.message', args: [message(code: 'systemMessage.label', default: 'SystemMessage'), systemMessageInstance.id])}"
//            redirect(action: "show", id: systemMessageInstance.id)
//        }
//        else {
//            render(view: "create", model: [systemMessageInstance: systemMessageInstance])
//        }
//    }

    def show = {
        def systemMessageInstance = SystemMessage.get(params.id)
        if (!systemMessageInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'systemMessage.label', default: 'SystemMessage'), params.id])}"
            redirect(action: "list")
        }
        else {
            [systemMessageInstance: systemMessageInstance]
        }
    }
//
//    def edit = {
//        def systemMessageInstance = SystemMessage.get(params.id)
//        if (!systemMessageInstance) {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'systemMessage.label', default: 'SystemMessage'), params.id])}"
//            redirect(action: "list")
//        }
//        else {
//            return [systemMessageInstance: systemMessageInstance]
//        }
//    }
//
//    def update = {
//        def systemMessageInstance = SystemMessage.get(params.id)
//        if (systemMessageInstance) {
//            if (params.version) {
//                def version = params.version.toLong()
//                if (systemMessageInstance.version > version) {
//                    
//                    systemMessageInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'systemMessage.label', default: 'SystemMessage')] as Object[], "Another user has updated this SystemMessage while you were editing")
//                    render(view: "edit", model: [systemMessageInstance: systemMessageInstance])
//                    return
//                }
//            }
//            systemMessageInstance.properties = params
//            if (!systemMessageInstance.hasErrors() && systemMessageInstance.save(flush: true)) {
//                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'systemMessage.label', default: 'SystemMessage'), systemMessageInstance.id])}"
//                redirect(action: "show", id: systemMessageInstance.id)
//            }
//            else {
//                render(view: "edit", model: [systemMessageInstance: systemMessageInstance])
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'systemMessage.label', default: 'SystemMessage'), params.id])}"
//            redirect(action: "list")
//        }
//    }
//
//    def delete = {
//        def systemMessageInstance = SystemMessage.get(params.id)
//        if (systemMessageInstance) {
//            try {
//                systemMessageInstance.delete(flush: true)
//                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'systemMessage.label', default: 'SystemMessage'), params.id])}"
//                redirect(action: "list")
//            }
//            catch (org.springframework.dao.DataIntegrityViolationException e) {
//                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'systemMessage.label', default: 'SystemMessage'), params.id])}"
//                redirect(action: "show", id: params.id)
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'systemMessage.label', default: 'SystemMessage'), params.id])}"
//            redirect(action: "list")
//        }
//    }
}
