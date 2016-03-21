package com.surelution.tour

import java.text.SimpleDateFormat;

class Vt2VcfController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [vt2VcfInstanceList: Vt2Vcf.list(params), vt2VcfInstanceTotal: Vt2Vcf.count()]
    }

    def create = {
        def vt2VcfInstance = new Vt2Vcf()
        vt2VcfInstance.properties = params
        return [vt2VcfInstance: vt2VcfInstance]
    }

    def save = {
        def vt2VcfInstance = new Vt2Vcf(params)
        if (vt2VcfInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'vt2Vcf.label', default: 'Vt2Vcf'), vt2VcfInstance.id])}"
            redirect(action: "show", id: vt2VcfInstance.id)
        }
        else {
            render(view: "create", model: [vt2VcfInstance: vt2VcfInstance])
        }
    }

    def show = {
        def vt2VcfInstance = Vt2Vcf.get(params.id)
        if (!vt2VcfInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vt2Vcf.label', default: 'Vt2Vcf'), params.id])}"
            redirect(action: "list")
        }
        else {
            [vt2VcfInstance: vt2VcfInstance]
        }
    }

    def edit = {
        def vt2VcfInstance = Vt2Vcf.get(params.id)
        if (!vt2VcfInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vt2Vcf.label', default: 'Vt2Vcf'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [vt2VcfInstance: vt2VcfInstance]
        }
    }

    def update = {
        def vt2VcfInstance = Vt2Vcf.get(params.id)
        if (vt2VcfInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (vt2VcfInstance.version > version) {
                    
                    vt2VcfInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'vt2Vcf.label', default: 'Vt2Vcf')] as Object[], "Another user has updated this Vt2Vcf while you were editing")
                    render(view: "edit", model: [vt2VcfInstance: vt2VcfInstance])
                    return
                }
            }
            vt2VcfInstance.properties = params
            if (!vt2VcfInstance.hasErrors() && vt2VcfInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'vt2Vcf.label', default: 'Vt2Vcf'), vt2VcfInstance.id])}"
                redirect(action: "show", id: vt2VcfInstance.id)
            }
            else {
                render(view: "edit", model: [vt2VcfInstance: vt2VcfInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vt2Vcf.label', default: 'Vt2Vcf'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def vt2VcfInstance = Vt2Vcf.get(params.id)
        if (vt2VcfInstance) {
            try {
                vt2VcfInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'vt2Vcf.label', default: 'Vt2Vcf'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'vt2Vcf.label', default: 'Vt2Vcf'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vt2Vcf.label', default: 'Vt2Vcf'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def loadTanks = {
		def month = params.month
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		def date = sdf.parse(month + "-1")
		def department = Department.get(params.'department.id')
		def tanks = GasTank.findAllByDepartment(department)
		def ratios = Vt2Vcf.withCriteria() {
			createAlias("tank", "t")
			eq("t.department", department)
			le("month", date)
			order("month", "desc")
		}
		[tanks:tanks, ratios:ratios, department:department]
	}
	
	def saveVcfRatio = {
		def department = Department.get(params.'department.id')
		def month = params.month
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		def date = sdf.parse(month + "-1")
		def tanks = GasTank.findAllByDepartment(department)
		tanks.each {
			def ratio = params."gasTank_${it.id}"
			println "${ratio},${date},${it}"
			def vcf = Vt2Vcf.findByMonthAndTank(date, it)
			if(!vcf) {
				vcf = new Vt2Vcf(month:date, ratio:ratio, tank:it)
			} else {
				vcf.ratio = ratio
			}
			vcf.save(flush:true)
		}
		redirect(action:"list")
	}
}
