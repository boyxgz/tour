package com.surelution.tour

import grails.plugins.springsecurity.SpringSecurityService;

class PatrolLogController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    
    }

    def list = {
		def userId = springSecurityService.principal.id
		def user = User.get(userId)
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
//		def patrolInstanceList = Patrol.findAllByRemarkedAndUser(false, user)
		def cri = Patrol.createCriteria()
		def patrolInstanceList = cri {
			eq "user", user
			or{
				eq "remarked",false
				isNull "remarked"
			}
			order "patrolDate","desc"
		}
		
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [patrolInstanceList: patrolInstanceList]
    }

    def create = {
        def patrolLogInstance = new PatrolLog()
//        patrolLogInstance.properties = params
		
		def patrolId = params.patrolId
		if(patrolId) {
			def patrol = Patrol.get(patrolId)
			patrolLogInstance.patrol = patrol
		}
		def patrolLogTopics = PatrolLogTopic.list()
        return [patrolLogInstance: patrolLogInstance, patrolLogTopics:patrolLogTopics]
    }

    def save = {
		def patrolLogTopics = PatrolLogTopic.list()
        def patrolLogInstance = new PatrolLog(params)
		patrolLogInstance.logTime = new Date()
        if (patrolLogInstance.save(flush: true)) {
			
			def patrol = patrolLogInstance.patrol
			patrol.remarked = true
			
			if(patrolLogTopics) {
				patrolLogTopics.each {topic->
					def id = topic.id
					if(!id)
						id = 1
					def answer = params["topic_" + id]
					def remark = params["topic_" + id + "_remark"]
					def item = new PatrolLogItem(patrolLog:patrolLogInstance, 
						topic:topic, answer:answer, description:remark)
					item.save(flush:true)
				}
			}
			
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'patrolLog.label', default: 'PatrolLog'), patrolLogInstance.id])}"
            redirect(controller: "patrol", action: "show", id: patrolLogInstance.patrol.id)
        }
        else {
            render(view: "create", model: [patrolLogInstance: patrolLogInstance])
        }
    }

    def show = {
        def patrolLogInstance = PatrolLog.get(params.id)
        if (!patrolLogInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLog.label', default: 'PatrolLog'), params.id])}"
            redirect(action: "list")
        }
        else {
            [patrolLogInstance: patrolLogInstance]
        }
    }

    def edit = {
        def patrolLogInstance = PatrolLog.get(params.id)
        if (!patrolLogInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLog.label', default: 'PatrolLog'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [patrolLogInstance: patrolLogInstance]
        }
    }

    def update = {
        def patrolLogInstance = PatrolLog.get(params.id)
        if (patrolLogInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (patrolLogInstance.version > version) {
                    
                    patrolLogInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'patrolLog.label', default: 'PatrolLog')] as Object[], "Another user has updated this PatrolLog while you were editing")
                    render(view: "edit", model: [patrolLogInstance: patrolLogInstance])
                    return
                }
            }
            patrolLogInstance.properties = params
            if (!patrolLogInstance.hasErrors() && patrolLogInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'patrolLog.label', default: 'PatrolLog'), patrolLogInstance.id])}"
                redirect(action: "show", id: patrolLogInstance.id)
            }
            else {
                render(view: "edit", model: [patrolLogInstance: patrolLogInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLog.label', default: 'PatrolLog'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def patrolLogInstance = PatrolLog.get(params.id)
        if (patrolLogInstance) {
            try {
                patrolLogInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'patrolLog.label', default: 'PatrolLog'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'patrolLog.label', default: 'PatrolLog'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrolLog.label', default: 'PatrolLog'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def showWithPatrolId = {
		def patrolId = params.patrolId
		println patrolId
		def patrol = Patrol.get(patrolId)
		def cri = PatrolLog.createCriteria() 
		def patrolLogs = cri{
			eq("patrol", patrol)
		}
		
		if(patrolLogs && patrolLogs.size() > 0) {
			render(view:"show", model: [patrolLogInstance: patrolLogs[0]])
		}
		redirect(action:"list")
	}
}
