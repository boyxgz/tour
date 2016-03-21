package com.surelution.tour

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
//		def userDepartments = UserDepartment.findAllByUser(userInstance)
        [userInstance: userInstance]
    }

    def save = {
        def userInstance = new User(params)
        if (userInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
            redirect(action: "show", id: userInstance.id)
        }
        else {
            render(view: "create", model: [userInstance: userInstance])
        }
    }

    def show = {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
			def userDepartments = UserDepartment.findAllByUser(userInstance)
            [userInstance: userInstance, userDepartments:userDepartments]
        }
    }

    def edit = {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
			def userDepartments = UserDepartment.findAllByUser(userInstance)
			def userPageEntries = UserPageEntry.findAllByUser(userInstance)
            [userInstance: userInstance, userDepartments:userDepartments, userPageEntries:userPageEntries]
        }
    }

    def update = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userInstance.version > version) {
                    
                    userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
                    render(view: "edit", model: [userInstance: userInstance])
                    return
                }
            }
            userInstance.properties = params
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
				def userDepartment = params.userDepartment
				if(userDepartment instanceof String) {
					userDepartment = [userDepartment]
				}
				def userPageEntry = params.userPageEntry
				if(userPageEntry instanceof String) {
					userPageEntry = [userPageEntry]
				}
				UserDepartment.findAllByUser(userInstance).each {
					it.delete()
				}
				userDepartment.each {deptId->
					def dept = Department.get(deptId)
					if(dept) {
						def userDept = new UserDepartment(user:userInstance, department:dept)
						userDept.save(flush:true)
					}
				}
				UserPageEntry.findAllByUser(userInstance).each{
					it.delete()
				}
				userPageEntry.each {pId->
					def pe = PageEntry.get(pId)
					if(pe) {
						def userPe = new UserPageEntry(user:userInstance, entry:pe)
						userPe.save(flush:true)
					}
				}
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
                redirect(action: "show", id: userInstance.id)
            }
            else {
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            try {
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def showChangePw = {
		if(springSecurityService.isLoggedIn()) {
			def username = springSecurityService.authentication.name
			def user = User.findByUsername(username)
			[user:user]
		}
	}
	
	def changePw = {
		if(springSecurityService.isLoggedIn()) {
			def oPw = params.oPw.trim()
			def newPw = params.newPw.trim()
			def confirmPw = params.confirmPw.trim()
			def user = User.findByUsername(springSecurityService.principal.username)
			if(user.password == springSecurityService.encodePassword(oPw)) {
				if(newPw != "" && newPw == confirmPw) {
					user.password = newPw
					user.save()
					flash.message = "${message(code: 'password.change.succeed')}"
				} else {
					flash.message = "${message(code: 'password.change.pwNotMatch')}"
				}
			} else {
				flash.message = "${message(code: 'password.change.wrongPw')}"
			}
		} else {
			flash.message = "${message(code: 'password.change.loginFirst')}"
		}
		render(view:"showChangePw")
	}
	
	def addDepartment = {
		def user = User.get(params.id)
		def department = Department.get(params["department.id"])
//		if(user != null && department != null) {
//		}
		
	}
	
	def resetPsw = {
		def user = User.get(params.id)
		user.password = "123"
		user.save(flush:true)
		redirect(action:"show", params:[id:params.id])
	}
}
