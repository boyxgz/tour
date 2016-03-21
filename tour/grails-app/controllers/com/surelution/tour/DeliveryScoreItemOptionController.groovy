package com.surelution.tour

class DeliveryScoreItemOptionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [deliveryScoreItemOptionInstanceList: DeliveryScoreItemOption.list(params), deliveryScoreItemOptionInstanceTotal: DeliveryScoreItemOption.count()]
    }

    def create = {
        def deliveryScoreItemOptionInstance = new DeliveryScoreItemOption()
        deliveryScoreItemOptionInstance.properties = params
        return [deliveryScoreItemOptionInstance: deliveryScoreItemOptionInstance]
    }

    def save = {
        def deliveryScoreItemOptionInstance = new DeliveryScoreItemOption(params)
        if (deliveryScoreItemOptionInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption'), deliveryScoreItemOptionInstance.id])}"
            redirect(action: "show", id: deliveryScoreItemOptionInstance.id)
        }
        else {
            render(view: "create", model: [deliveryScoreItemOptionInstance: deliveryScoreItemOptionInstance])
        }
    }

    def show = {
        def deliveryScoreItemOptionInstance = DeliveryScoreItemOption.get(params.id)
        if (!deliveryScoreItemOptionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption'), params.id])}"
            redirect(action: "list")
        }
        else {
            [deliveryScoreItemOptionInstance: deliveryScoreItemOptionInstance]
        }
    }

    def edit = {
        def deliveryScoreItemOptionInstance = DeliveryScoreItemOption.get(params.id)
        if (!deliveryScoreItemOptionInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [deliveryScoreItemOptionInstance: deliveryScoreItemOptionInstance]
        }
    }

    def update = {
        def deliveryScoreItemOptionInstance = DeliveryScoreItemOption.get(params.id)
        if (deliveryScoreItemOptionInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (deliveryScoreItemOptionInstance.version > version) {
                    
                    deliveryScoreItemOptionInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption')] as Object[], "Another user has updated this DeliveryScoreItemOption while you were editing")
                    render(view: "edit", model: [deliveryScoreItemOptionInstance: deliveryScoreItemOptionInstance])
                    return
                }
            }
            deliveryScoreItemOptionInstance.properties = params
            if (!deliveryScoreItemOptionInstance.hasErrors() && deliveryScoreItemOptionInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption'), deliveryScoreItemOptionInstance.id])}"
                redirect(action: "show", id: deliveryScoreItemOptionInstance.id)
            }
            else {
                render(view: "edit", model: [deliveryScoreItemOptionInstance: deliveryScoreItemOptionInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def deliveryScoreItemOptionInstance = DeliveryScoreItemOption.get(params.id)
        if (deliveryScoreItemOptionInstance) {
            try {
                deliveryScoreItemOptionInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItemOption.label', default: 'DeliveryScoreItemOption'), params.id])}"
            redirect(action: "list")
        }
    }
}
