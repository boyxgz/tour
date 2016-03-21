package com.surelution.tour

class DeliveryScoreItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [deliveryScoreItemInstanceList: DeliveryScoreItem.list(params), deliveryScoreItemInstanceTotal: DeliveryScoreItem.count()]
    }

    def create = {
        def deliveryScoreItemInstance = new DeliveryScoreItem()
        deliveryScoreItemInstance.properties = params
        return [deliveryScoreItemInstance: deliveryScoreItemInstance]
    }

    def save = {
        def deliveryScoreItemInstance = new DeliveryScoreItem(params)
        if (deliveryScoreItemInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem'), deliveryScoreItemInstance.id])}"
            redirect(action: "show", id: deliveryScoreItemInstance.id)
        }
        else {
            render(view: "create", model: [deliveryScoreItemInstance: deliveryScoreItemInstance])
        }
    }

    def show = {
        def deliveryScoreItemInstance = DeliveryScoreItem.get(params.id)
        if (!deliveryScoreItemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem'), params.id])}"
            redirect(action: "list")
        }
        else {
            [deliveryScoreItemInstance: deliveryScoreItemInstance]
        }
    }

    def edit = {
        def deliveryScoreItemInstance = DeliveryScoreItem.get(params.id)
        if (!deliveryScoreItemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [deliveryScoreItemInstance: deliveryScoreItemInstance]
        }
    }

    def update = {
        def deliveryScoreItemInstance = DeliveryScoreItem.get(params.id)
        if (deliveryScoreItemInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (deliveryScoreItemInstance.version > version) {
                    
                    deliveryScoreItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem')] as Object[], "Another user has updated this DeliveryScoreItem while you were editing")
                    render(view: "edit", model: [deliveryScoreItemInstance: deliveryScoreItemInstance])
                    return
                }
            }
            deliveryScoreItemInstance.properties = params
            if (!deliveryScoreItemInstance.hasErrors() && deliveryScoreItemInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem'), deliveryScoreItemInstance.id])}"
                redirect(action: "show", id: deliveryScoreItemInstance.id)
            }
            else {
                render(view: "edit", model: [deliveryScoreItemInstance: deliveryScoreItemInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def deliveryScoreItemInstance = DeliveryScoreItem.get(params.id)
        if (deliveryScoreItemInstance) {
            try {
                deliveryScoreItemInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItem.label', default: 'DeliveryScoreItem'), params.id])}"
            redirect(action: "list")
        }
    }
}
