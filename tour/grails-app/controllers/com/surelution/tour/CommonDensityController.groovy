package com.surelution.tour

class CommonDensityController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [commonDensityInstanceList: CommonDensity.list(params), commonDensityInstanceTotal: CommonDensity.count()]
    }

    def create = {
        def commonDensityInstance = new CommonDensity()
        commonDensityInstance.properties = params
        return [commonDensityInstance: commonDensityInstance]
    }

    def save = {
        def commonDensityInstance = new CommonDensity(params)
        if (commonDensityInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'commonDensity.label', default: 'CommonDensity'), commonDensityInstance.id])}"
            redirect(action: "show", id: commonDensityInstance.id)
        }
        else {
            render(view: "create", model: [commonDensityInstance: commonDensityInstance])
        }
    }

    def show = {
        def commonDensityInstance = CommonDensity.get(params.id)
        if (!commonDensityInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commonDensity.label', default: 'CommonDensity'), params.id])}"
            redirect(action: "list")
        }
        else {
            [commonDensityInstance: commonDensityInstance]
        }
    }

    def edit = {
        def commonDensityInstance = CommonDensity.get(params.id)
        if (!commonDensityInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commonDensity.label', default: 'CommonDensity'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [commonDensityInstance: commonDensityInstance]
        }
    }

    def update = {
        def commonDensityInstance = CommonDensity.get(params.id)
        if (commonDensityInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (commonDensityInstance.version > version) {
                    
                    commonDensityInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'commonDensity.label', default: 'CommonDensity')] as Object[], "Another user has updated this CommonDensity while you were editing")
                    render(view: "edit", model: [commonDensityInstance: commonDensityInstance])
                    return
                }
            }
            commonDensityInstance.properties = params
            if (!commonDensityInstance.hasErrors() && commonDensityInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'commonDensity.label', default: 'CommonDensity'), commonDensityInstance.id])}"
                redirect(action: "show", id: commonDensityInstance.id)
            }
            else {
                render(view: "edit", model: [commonDensityInstance: commonDensityInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commonDensity.label', default: 'CommonDensity'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def commonDensityInstance = CommonDensity.get(params.id)
        if (commonDensityInstance) {
            try {
                commonDensityInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'commonDensity.label', default: 'CommonDensity'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'commonDensity.label', default: 'CommonDensity'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commonDensity.label', default: 'CommonDensity'), params.id])}"
            redirect(action: "list")
        }
    }
}
