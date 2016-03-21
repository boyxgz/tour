package com.surelution.tour

class PatrolController {
	
	def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [patrolInstanceList: Patrol.list(params), patrolInstanceTotal: Patrol.count()]
    }

    def create = {
        def patrolInstance = new Patrol()
        patrolInstance.properties = params
        return [patrolInstance: patrolInstance]
    }

    def save = {
        def patrolInstance = new Patrol(params)
        if (patrolInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'patrol.label', default: 'Patrol'), patrolInstance.id])}"
            redirect(action: "show", id: patrolInstance.id)
        }
        else {
            render(view: "create", model: [patrolInstance: patrolInstance])
        }
    }

    def show = {
		//yes, it's strange!
		//just for show the content when user click the link on the report
		//I know it shits a lot
		def id = params.id
		if(id.startsWith("l-")) {
			id = id.substring(2)
			redirect(controller:"leave", action:"show", id:id)
			return
		}
        def patrolInstance = Patrol.get(params.id)
        if (!patrolInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrol.label', default: 'Patrol'), params.id])}"
            redirect(action: "list")
        }
        else {
			def patrolLog = PatrolLog.findByPatrol(patrolInstance)
			def patrolLogAudits
			if(patrolLog)
				patrolLogAudits = PatrolLogAudit.findAllByPatrolLog(patrolLog)
            [patrolInstance: patrolInstance, patrolLog:patrolLog, patrolLogAudits:patrolLogAudits]
        }
    }

    def edit = {
        def patrolInstance = Patrol.get(params.id)
        if (!patrolInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrol.label', default: 'Patrol'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [patrolInstance: patrolInstance]
        }
    }

    def update = {
        def patrolInstance = Patrol.get(params.id)
        if (patrolInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (patrolInstance.version > version) {
                    
                    patrolInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'patrol.label', default: 'Patrol')] as Object[], "Another user has updated this Patrol while you were editing")
                    render(view: "edit", model: [patrolInstance: patrolInstance])
                    return
                }
            }
            patrolInstance.properties = params
            if (!patrolInstance.hasErrors() && patrolInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'patrol.label', default: 'Patrol'), patrolInstance.id])}"
                redirect(action: "show", id: patrolInstance.id)
            }
            else {
                render(view: "edit", model: [patrolInstance: patrolInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrol.label', default: 'Patrol'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def patrolInstance = Patrol.get(params.id)
        if (patrolInstance) {
            try {
                patrolInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'patrol.label', default: 'Patrol'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'patrol.label', default: 'Patrol'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'patrol.label', default: 'Patrol'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def unremarked = {
		def newStatus = PatrolStatus.findByCode("NEW")
		if(springSecurityService.isLoggedIn()) {
			def username = springSecurityService.authentication.name
			def user = User.findByUsername(username)
			if(user) {
		        params.max = Math.min(params.max ? params.int('max') : 10, 100)
				def cri = Patrol.createCriteria()
				def patrols = cri.list(params) {
					eq("status", newStatus)
					eq("user", user)
				}
		        [patrolInstanceList: patrols, patrolInstanceTotal: patrols.totalCount]
			}
		
		}
	}
	
	def remarkShow = {
		def id = params.id
		def patrol = Patrol.get(id)
		[patrolInstance:patrol]
	}
	
	def remark = {
		def status = PatrolStatus.findByCode("REMARKED")
		def patrolId = params.patrolId
		def patrol = Patrol.get(patrolId)
		patrol.status = status;
		def patrolRemark = new PatrolRemark(params)
		patrolRemark.patrol = patrol
		patrolRemark.save(flush:true)
		patrol.remark = patrolRemark
		patrol.save(flush: true)
		redirect(action:remarkShow, id:patrolId)
	}
	
	def patrolLogAudit = {
		if(springSecurityService.isLoggedIn()) {
			def username = springSecurityService.authentication.name
			def user = User.findByUsername(username)
			def patrolLogId = params["patrolLog.id"]
			println "patrol Id:" + patrolLogId
			if(user) {
				def patrolLogAudit = new PatrolLogAudit(params)
				println patrolLogAudit
				patrolLogAudit.user = user
				if (patrolLogAudit.save(flush: true)) {
					def patrolLog = patrolLogAudit.patrolLog
					redirect(action:show, id:patrolLog.patrol.id)
					return
				}
			}
			
			
		}
	}
}
