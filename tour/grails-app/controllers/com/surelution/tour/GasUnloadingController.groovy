package com.surelution.tour

import java.text.SimpleDateFormat
import groovy.time.TimeCategory;

class GasUnloadingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def sdf = new SimpleDateFormat('yyyy-MM-dd')
		def dateFrom = params.dateFrom? sdf.parse(params.dateFrom):null
		def dateTo = params.dateTo? sdf.parse(params.dateTo):null
		if(dateTo) {
			use(TimeCategory) {
				dateTo += 1.days
			}
		}
		def departmentList = UserDepartment.getUserDepartments(springSecurityService.currentUser.toString())
		def department = params['department.id']?Department.get(params['department.id']):null
		def gasUnloading = GasUnloading.createCriteria().list([max:params.max, offset:params.offset])  {
			if(department) {
				eq("department", department)
			}
			else{
				'in'("department",departmentList)
			}
			if(dateFrom) {
				ge("unloadingTime", dateFrom)
			}
			if(dateTo) {
				le("unloadingTime", dateTo)
			}
		}
        [gasUnloadingInstanceList: gasUnloading, gasUnloadingInstanceTotal: gasUnloading.totalCount]
    }

    def create = {
        def gasUnloadingInstance = new GasUnloading()
        gasUnloadingInstance.properties = params
        return [gasUnloadingInstance: gasUnloadingInstance]
    }

    def save = {
		def user = springSecurityService.currentUser
        def gasUnloadingInstance = new GasUnloading(params)
		gasUnloadingInstance.user = user
        if (gasUnloadingInstance.save(flush: true)) {
			def dept = gasUnloadingInstance.department
			def tanks = GasTank.findAllByDepartment(dept)
			if(tanks) {
				tanks.each {tank->
					def _amount = params["tank_${tank.id}_amount"]
					def _stdVolume = params["tank_${tank.id}_stdVolume"]
					def _density = params["tank_${tank.id}_density"] 
					def _temperature = params["tank_${tank.id}_temperature"] 
					def _preUnloadingHeight = params["tank_${tank.id}_preUnloadingHeight"] 
					def _postUnloadingHeight = params["tank_${tank.id}_postUnloadingHeight"] 
					
					if(_amount && _stdVolume && _density && _temperature && _preUnloadingHeight && _postUnloadingHeight) {
					
						def amount = Float.parseFloat(_amount)
						def stdVolume = Float.parseFloat(_stdVolume)
						def density = Float.parseFloat(_density)
						def temperature = Float.parseFloat(_temperature)
						def postUnloadingHeight = Float.parseFloat(_postUnloadingHeight)
						def preUnloadingHeight = Float.parseFloat(_preUnloadingHeight)
						
						def item = new GasUnloadingItem(unloading:gasUnloadingInstance, tank:tank, 
							amount:amount, stdVolume:stdVolume, density:density, temperature:temperature, 
							preUnloadingHeight:preUnloadingHeight, postUnloadingHeight:postUnloadingHeight)
						item.save(flush:true)
					}
				}
			}
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), gasUnloadingInstance.id])}"
            redirect(action: "show", id: gasUnloadingInstance.id)
        }
        else {
            render(view: "create", model: [gasUnloadingInstance: gasUnloadingInstance])
        }
    }

    def show = {
        def gasUnloadingInstance = GasUnloading.get(params.id)
        if (!gasUnloadingInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), params.id])}"
            redirect(action: "list")
        }
        else {
            [gasUnloadingInstance: gasUnloadingInstance]
        }
    }

    def edit = {
		redirect(action: "list")
//        def gasUnloadingInstance = GasUnloading.get(params.id)
//        if (!gasUnloadingInstance) {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), params.id])}"
//            redirect(action: "list")
//        }
//        else {
//            return [gasUnloadingInstance: gasUnloadingInstance]
//        }
    }

    def update = {
		redirect(action: "list")
//        def gasUnloadingInstance = GasUnloading.get(params.id)
//        if (gasUnloadingInstance) {
//            if (params.version) {
//                def version = params.version.toLong()
//                if (gasUnloadingInstance.version > version) {
//                    
//                    gasUnloadingInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'gasUnloading.label', default: 'GasUnloading')] as Object[], "Another user has updated this GasUnloading while you were editing")
//                    render(view: "edit", model: [gasUnloadingInstance: gasUnloadingInstance])
//                    return
//                }
//            }
//            gasUnloadingInstance.properties = params
//            if (!gasUnloadingInstance.hasErrors() && gasUnloadingInstance.save(flush: true)) {
//                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), gasUnloadingInstance.id])}"
//                redirect(action: "show", id: gasUnloadingInstance.id)
//            }
//            else {
//                render(view: "edit", model: [gasUnloadingInstance: gasUnloadingInstance])
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), params.id])}"
//            redirect(action: "list")
//        }
    }

    def delete = {
        def gasUnloadingInstance = GasUnloading.get(params.id)
		if(!springSecurityService.authentication.authorities.any {"ROLE-ADMIN" == it.authority}
			&& (System.currentTimeMillis() - (gasUnloadingInstance.dateCreated?gasUnloadingInstance.dateCreated.time:0)) > 1000 * 60 * 60) {
			flash.message = "当前本条信息已锁定，如需删除，请联系管理员"
			redirect(action: "show", id: params.id)
			return
		}
        if (gasUnloadingInstance) {
            try {
                gasUnloadingInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
				e.printStackTrace()
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'gasUnloading.label', default: 'GasUnloading'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def  loadTankList = {
		def deptId = params.departmentId
		def gasTypeId = params.gasTypeId
		def ret
		if(deptId && gasTypeId) {
			def dept = Department.get(deptId)
			def gasType = GasType.get(gasTypeId)
			def tanks = GasTank.findAllByDepartmentAndGasType(dept, gasType)
			ret = "<table><tr><td>${message(code:'gasTank.tankNo.label')}</td>'"
			ret += "<td>${message(code:'gasUnloadingItem.amount.label')}</td>"
			ret += "<td>${message(code:'gasUnloadingItem.stdVolume.label')}</td>"
			ret += "<td>${message(code:'gasUnloadingItem.density.label')}</td>"
			ret += "<td>${message(code:'gasUnloadingItem.temperature.label')}</td>"
			ret += "<td>${message(code:'gasUnloadingItem.preUnloadingHeight.label')}</td>"
			ret += "<td>${message(code:'gasUnloadingItem.postUnloadingHeight.label')}</td>"
			ret +="</tr>"
			tanks.each {t->
				ret += """<tr>
					<td>${t.tankNo}(${t.gasType.title})</td>
					<td>
						<input type='text' name='tank_${t.id}_amount' size='6'/>
					</td>
					<td>
						<input type='text' name='tank_${t.id}_stdVolume' size='6'/>
					</td>
					<td>
						<input type='text' name='tank_${t.id}_density' size='6'/>
					</td>
					<td>
						<input type='text' name='tank_${t.id}_temperature' size='6'/>
					</td>
					<td>
						<input type='text' name='tank_${t.id}_preUnloadingHeight' size='6'/>
					</td>
					<td>
						<input type='text' name='tank_${t.id}_postUnloadingHeight' size='6'/>
					</td>
				</tr>"""
			}
			ret += "</table>"
		}
		render(ret)
	}
	
}
