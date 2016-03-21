package com.surelution.tour

class WandController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [wandInstanceList: Wand.list(params), wandInstanceTotal: Wand.count()]
    }

//    def create = {
//        def wandInstance = new Wand()
//        wandInstance.properties = params
//        return [wandInstance: wandInstance]
//    }

//    def save = {
//        def wandInstance = new Wand(params)
//        if (wandInstance.save(flush: true)) {
//            flash.message = "${message(code: 'default.created.message', args: [message(code: 'wand.label', default: 'Wand'), wandInstance.id])}"
//            redirect(action: "show", id: wandInstance.id)
//        }
//        else {
//            render(view: "create", model: [wandInstance: wandInstance])
//        }
//    }

    def show = {
        def wandInstance = Wand.get(params.id)
        if (!wandInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'wand.label', default: 'Wand'), params.id])}"
            redirect(action: "list")
        }
        else {
            [wandInstance: wandInstance]
        }
    }

    def edit = {
        def wandInstance = Wand.get(params.id)
        if (!wandInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'wand.label', default: 'Wand'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [wandInstance: wandInstance]
        }
    }

    def update = {
        def wandInstance = Wand.get(params.id)
        if (wandInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (wandInstance.version > version) {
                    
                    wandInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'wand.label', default: 'Wand')] as Object[], "Another user has updated this Wand while you were editing")
                    render(view: "edit", model: [wandInstance: wandInstance])
                    return
                }
            }
//            wandInstance.properties = params
			def user = User.get(params["user.id"])
			wandInstance.user = user
			wandInstance.description = params["description"]
            if (!wandInstance.hasErrors() && wandInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'wand.label', default: 'Wand'), wandInstance.id])}"
                redirect(action: "show", id: wandInstance.id)
            }
            else {
                render(view: "edit", model: [wandInstance: wandInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'wand.label', default: 'Wand'), params.id])}"
            redirect(action: "list")
        }
    }

//    def delete = {
//        def wandInstance = Wand.get(params.id)
//        if (wandInstance) {
//            try {
//                wandInstance.delete(flush: true)
//                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'wand.label', default: 'Wand'), params.id])}"
//                redirect(action: "list")
//            }
//            catch (org.springframework.dao.DataIntegrityViolationException e) {
//                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'wand.label', default: 'Wand'), params.id])}"
//                redirect(action: "show", id: params.id)
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'wand.label', default: 'Wand'), params.id])}"
//            redirect(action: "list")
//        }
//    }
}
