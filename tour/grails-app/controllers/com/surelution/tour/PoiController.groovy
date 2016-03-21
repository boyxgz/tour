package com.surelution.tour

import com.surelution.core.SystemInfo

class PoiController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [poiInstanceList: Poi.list(params), poiInstanceTotal: Poi.count()]
    }

    def create = {
        def poiInstance = new Poi()
        poiInstance.properties = params
        return [poiInstance: poiInstance]
    }

    def save = {
        def poiInstance = new Poi(params)
		SystemInfo si = servletContext["system-info"]
        if (si.poiContains(poiInstance.sn) //TODO 校验是否为授权地址芯片
			&& poiInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'poi.label', default: 'Poi'), poiInstance.id])}"
            redirect(action: "show", id: poiInstance.id)
        }
        else {
            render(view: "create", model: [poiInstance: poiInstance])
        }
    }

    def show = {
        def poiInstance = Poi.get(params.id)
        if (!poiInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'poi.label', default: 'Poi'), params.id])}"
            redirect(action: "list")
        }
        else {
            [poiInstance: poiInstance]
        }
    }

    def edit = {
        def poiInstance = Poi.get(params.id)
        if (!poiInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'poi.label', default: 'Poi'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [poiInstance: poiInstance]
        }
    }

    def update = {
        def poiInstance = Poi.get(params.id)
        if (poiInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (poiInstance.version > version) {
                    
                    poiInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'poi.label', default: 'Poi')] as Object[], "Another user has updated this Poi while you were editing")
                    render(view: "edit", model: [poiInstance: poiInstance])
                    return
                }
            }
            poiInstance.properties = params
            if (!poiInstance.hasErrors() && poiInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'poi.label', default: 'Poi'), poiInstance.id])}"
                redirect(action: "show", id: poiInstance.id)
            }
            else {
                render(view: "edit", model: [poiInstance: poiInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'poi.label', default: 'Poi'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def poiInstance = Poi.get(params.id)
        if (poiInstance) {
            try {
                poiInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'poi.label', default: 'Poi'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'poi.label', default: 'Poi'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'poi.label', default: 'Poi'), params.id])}"
            redirect(action: "list")
        }
    }
}
