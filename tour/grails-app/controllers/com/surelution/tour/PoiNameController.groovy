package com.surelution.tour

class PoiNameController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [poiNameInstanceList: PoiName.list(params), poiNameInstanceTotal: PoiName.count()]
    }

    def create = {
        def poiNameInstance = new PoiName()
        poiNameInstance.properties = params
        return [poiNameInstance: poiNameInstance]
    }

    def save = {
        def poiNameInstance = new PoiName(params)
        if (poiNameInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'poiName.label', default: 'PoiName'), poiNameInstance.id])}"
            redirect(action: "show", id: poiNameInstance.id)
        }
        else {
            render(view: "create", model: [poiNameInstance: poiNameInstance])
        }
    }

    def show = {
        def poiNameInstance = PoiName.get(params.id)
        if (!poiNameInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'poiName.label', default: 'PoiName'), params.id])}"
            redirect(action: "list")
        }
        else {
            [poiNameInstance: poiNameInstance]
        }
    }

    def edit = {
        def poiNameInstance = PoiName.get(params.id)
        if (!poiNameInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'poiName.label', default: 'PoiName'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [poiNameInstance: poiNameInstance]
        }
    }

    def update = {
        def poiNameInstance = PoiName.get(params.id)
        if (poiNameInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (poiNameInstance.version > version) {
                    
                    poiNameInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'poiName.label', default: 'PoiName')] as Object[], "Another user has updated this PoiName while you were editing")
                    render(view: "edit", model: [poiNameInstance: poiNameInstance])
                    return
                }
            }
            poiNameInstance.properties = params
            if (!poiNameInstance.hasErrors() && poiNameInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'poiName.label', default: 'PoiName'), poiNameInstance.id])}"
                redirect(action: "show", id: poiNameInstance.id)
            }
            else {
                render(view: "edit", model: [poiNameInstance: poiNameInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'poiName.label', default: 'PoiName'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def poiNameInstance = PoiName.get(params.id)
        if (poiNameInstance) {
            try {
                poiNameInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'poiName.label', default: 'PoiName'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'poiName.label', default: 'PoiName'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'poiName.label', default: 'PoiName'), params.id])}"
            redirect(action: "list")
        }
    }
}
