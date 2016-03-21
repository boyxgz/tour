package com.surelution.tour

class DeliveryScoreItemTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [deliveryScoreItemTypeInstanceList: DeliveryScoreItemType.list(params), deliveryScoreItemTypeInstanceTotal: DeliveryScoreItemType.count()]
    }

    def create = {
        def deliveryScoreItemTypeInstance = new DeliveryScoreItemType()
        deliveryScoreItemTypeInstance.properties = params
        return [deliveryScoreItemTypeInstance: deliveryScoreItemTypeInstance]
    }

    def save = {
        def deliveryScoreItemTypeInstance = new DeliveryScoreItemType(params)
        if (deliveryScoreItemTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType'), deliveryScoreItemTypeInstance.id])}"
            redirect(action: "show", id: deliveryScoreItemTypeInstance.id)
        }
        else {
            render(view: "create", model: [deliveryScoreItemTypeInstance: deliveryScoreItemTypeInstance])
        }
    }

    def show = {
        def deliveryScoreItemTypeInstance = DeliveryScoreItemType.get(params.id)
        if (!deliveryScoreItemTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType'), params.id])}"
            redirect(action: "list")
        }
        else {
            [deliveryScoreItemTypeInstance: deliveryScoreItemTypeInstance]
        }
    }

    def edit = {
        def deliveryScoreItemTypeInstance = DeliveryScoreItemType.get(params.id)
        if (!deliveryScoreItemTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [deliveryScoreItemTypeInstance: deliveryScoreItemTypeInstance]
        }
    }

    def update = {
        def deliveryScoreItemTypeInstance = DeliveryScoreItemType.get(params.id)
        if (deliveryScoreItemTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (deliveryScoreItemTypeInstance.version > version) {
                    
                    deliveryScoreItemTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType')] as Object[], "Another user has updated this DeliveryScoreItemType while you were editing")
                    render(view: "edit", model: [deliveryScoreItemTypeInstance: deliveryScoreItemTypeInstance])
                    return
                }
            }
            deliveryScoreItemTypeInstance.properties = params
            if (!deliveryScoreItemTypeInstance.hasErrors() && deliveryScoreItemTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType'), deliveryScoreItemTypeInstance.id])}"
                redirect(action: "show", id: deliveryScoreItemTypeInstance.id)
            }
            else {
                render(view: "edit", model: [deliveryScoreItemTypeInstance: deliveryScoreItemTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def deliveryScoreItemTypeInstance = DeliveryScoreItemType.get(params.id)
        if (deliveryScoreItemTypeInstance) {
            try {
                deliveryScoreItemTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScoreItemType.label', default: 'DeliveryScoreItemType'), params.id])}"
            redirect(action: "list")
        }
    }
}
