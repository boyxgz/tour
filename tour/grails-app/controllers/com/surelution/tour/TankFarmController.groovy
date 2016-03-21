package com.surelution.tour

class TankFarmController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tankFarmInstanceList: TankFarm.list(params), tankFarmInstanceTotal: TankFarm.count()]
    }

    def create = {
        def tankFarmInstance = new TankFarm()
        tankFarmInstance.properties = params
        return [tankFarmInstance: tankFarmInstance]
    }

    def save = {
        def tankFarmInstance = new TankFarm(params)
        if (tankFarmInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'tankFarm.label', default: 'TankFarm'), tankFarmInstance.id])}"
            redirect(action: "show", id: tankFarmInstance.id)
        }
        else {
            render(view: "create", model: [tankFarmInstance: tankFarmInstance])
        }
    }

    def show = {
        def tankFarmInstance = TankFarm.get(params.id)
        if (!tankFarmInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tankFarm.label', default: 'TankFarm'), params.id])}"
            redirect(action: "list")
        }
        else {
            [tankFarmInstance: tankFarmInstance]
        }
    }

    def edit = {
        def tankFarmInstance = TankFarm.get(params.id)
        if (!tankFarmInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tankFarm.label', default: 'TankFarm'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [tankFarmInstance: tankFarmInstance]
        }
    }

    def update = {
        def tankFarmInstance = TankFarm.get(params.id)
        if (tankFarmInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (tankFarmInstance.version > version) {
                    
                    tankFarmInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'tankFarm.label', default: 'TankFarm')] as Object[], "Another user has updated this TankFarm while you were editing")
                    render(view: "edit", model: [tankFarmInstance: tankFarmInstance])
                    return
                }
            }
            tankFarmInstance.properties = params
            if (!tankFarmInstance.hasErrors() && tankFarmInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'tankFarm.label', default: 'TankFarm'), tankFarmInstance.id])}"
                redirect(action: "show", id: tankFarmInstance.id)
            }
            else {
                render(view: "edit", model: [tankFarmInstance: tankFarmInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tankFarm.label', default: 'TankFarm'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def tankFarmInstance = TankFarm.get(params.id)
        if (tankFarmInstance) {
            try {
                tankFarmInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'tankFarm.label', default: 'TankFarm'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'tankFarm.label', default: 'TankFarm'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'tankFarm.label', default: 'TankFarm'), params.id])}"
            redirect(action: "list")
        }
    }
}
