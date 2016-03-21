package com.surelution.tour

class StockTakingItemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [stockTakingItemInstanceList: StockTakingItem.list(params), stockTakingItemInstanceTotal: StockTakingItem.count()]
    }

    def create = {
        def stockTakingItemInstance = new StockTakingItem()
        stockTakingItemInstance.properties = params
        return [stockTakingItemInstance: stockTakingItemInstance]
    }

    def save = {
        def stockTakingItemInstance = new StockTakingItem(params)
        if (stockTakingItemInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), stockTakingItemInstance.id])}"
            redirect(action: "show", id: stockTakingItemInstance.id)
        }
        else {
            render(view: "create", model: [stockTakingItemInstance: stockTakingItemInstance])
        }
    }

    def show = {
        def stockTakingItemInstance = StockTakingItem.get(params.id)
        if (!stockTakingItemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), params.id])}"
            redirect(action: "list")
        }
        else {
            [stockTakingItemInstance: stockTakingItemInstance]
        }
    }

    def edit = {
        def stockTakingItemInstance = StockTakingItem.get(params.id)
        if (!stockTakingItemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [stockTakingItemInstance: stockTakingItemInstance]
        }
    }

    def update = {
        def stockTakingItemInstance = StockTakingItem.get(params.id)
        if (stockTakingItemInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (stockTakingItemInstance.version > version) {
                    
                    stockTakingItemInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'stockTakingItem.label', default: 'StockTakingItem')] as Object[], "Another user has updated this StockTakingItem while you were editing")
                    render(view: "edit", model: [stockTakingItemInstance: stockTakingItemInstance])
                    return
                }
            }
            stockTakingItemInstance.properties = params
            if (!stockTakingItemInstance.hasErrors() && stockTakingItemInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), stockTakingItemInstance.id])}"
                redirect(action: "show", id: stockTakingItemInstance.id)
            }
            else {
                render(view: "edit", model: [stockTakingItemInstance: stockTakingItemInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def stockTakingItemInstance = StockTakingItem.get(params.id)
        if (stockTakingItemInstance) {
            try {
                stockTakingItemInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'stockTakingItem.label', default: 'StockTakingItem'), params.id])}"
            redirect(action: "list")
        }
    }
}
