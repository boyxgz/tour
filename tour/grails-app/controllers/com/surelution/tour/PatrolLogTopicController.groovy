package com.surelution.tour

class PatrolLogTopicController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [patrolLogTopicInstanceList: PatrolLogTopic.list(params), patrolLogTopicInstanceTotal: PatrolLogTopic.count()]
    }

    def create = {
        def patrolLogTopicInstance = new PatrolLogTopic()
        patrolLogTopicInstance.properties = params
        return [patrolLogTopicInstance: patrolLogTopicInstance]
    }

    def save = {
        def patrolLogTopicInstance = new PatrolLogTopic(params)
        if (patrolLogTopicInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic'), patrolLogTopicInstance.id])}"
            redirect(action: "show", id: patrolLogTopicInstance.id)
        }
        else {
            render(view: "create", model: [patrolLogTopicInstance: patrolLogTopicInstance])
        }
    }

    def show = {
        def patrolLogTopicInstance = PatrolLogTopic.get(params.id)
        if (!patrolLogTopicInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic'), params.id])}"
            redirect(action: "list")
        }
        else {
            [patrolLogTopicInstance: patrolLogTopicInstance]
        }
    }

    def edit = {
        def patrolLogTopicInstance = PatrolLogTopic.get(params.id)
        if (!patrolLogTopicInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [patrolLogTopicInstance: patrolLogTopicInstance]
        }
    }

    def update = {
        def patrolLogTopicInstance = PatrolLogTopic.get(params.id)
        if (patrolLogTopicInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (patrolLogTopicInstance.version > version) {
                    
                    patrolLogTopicInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic')] as Object[], "Another user has updated this PatrolLogTopic while you were editing")
                    render(view: "edit", model: [patrolLogTopicInstance: patrolLogTopicInstance])
                    return
                }
            }
            patrolLogTopicInstance.properties = params
            if (!patrolLogTopicInstance.hasErrors() && patrolLogTopicInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic'), patrolLogTopicInstance.id])}"
                redirect(action: "show", id: patrolLogTopicInstance.id)
            }
            else {
                render(view: "edit", model: [patrolLogTopicInstance: patrolLogTopicInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def patrolLogTopicInstance = PatrolLogTopic.get(params.id)
        if (patrolLogTopicInstance) {
            try {
                patrolLogTopicInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLogTopic.label', default: 'PatrolLogTopic'), params.id])}"
            redirect(action: "list")
        }
    }
}
