package com.surelution.tour

class PageEntryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [pageEntryInstanceList: PageEntry.list(params), pageEntryInstanceTotal: PageEntry.count()]
    }

    def create = {
        def pageEntryInstance = new PageEntry()
        pageEntryInstance.properties = params
        return [pageEntryInstance: pageEntryInstance]
    }

    def save = {
        def pageEntryInstance = new PageEntry(params)
        if (pageEntryInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'pageEntry.label', default: 'PageEntry'), pageEntryInstance.id])}"
            redirect(action: "show", id: pageEntryInstance.id)
        }
        else {
            render(view: "create", model: [pageEntryInstance: pageEntryInstance])
        }
    }

    def show = {
        def pageEntryInstance = PageEntry.get(params.id)
        if (!pageEntryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pageEntry.label', default: 'PageEntry'), params.id])}"
            redirect(action: "list")
        }
        else {
            [pageEntryInstance: pageEntryInstance]
        }
    }

    def edit = {
        def pageEntryInstance = PageEntry.get(params.id)
        if (!pageEntryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pageEntry.label', default: 'PageEntry'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [pageEntryInstance: pageEntryInstance]
        }
    }

    def update = {
        def pageEntryInstance = PageEntry.get(params.id)
        if (pageEntryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (pageEntryInstance.version > version) {
                    
                    pageEntryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'pageEntry.label', default: 'PageEntry')] as Object[], "Another user has updated this PageEntry while you were editing")
                    render(view: "edit", model: [pageEntryInstance: pageEntryInstance])
                    return
                }
            }
            pageEntryInstance.properties = params
            if (!pageEntryInstance.hasErrors() && pageEntryInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'pageEntry.label', default: 'PageEntry'), pageEntryInstance.id])}"
                redirect(action: "show", id: pageEntryInstance.id)
            }
            else {
                render(view: "edit", model: [pageEntryInstance: pageEntryInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pageEntry.label', default: 'PageEntry'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def pageEntryInstance = PageEntry.get(params.id)
        if (pageEntryInstance) {
            try {
                pageEntryInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'pageEntry.label', default: 'PageEntry'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'pageEntry.label', default: 'PageEntry'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'pageEntry.label', default: 'PageEntry'), params.id])}"
            redirect(action: "list")
        }
    }
}
