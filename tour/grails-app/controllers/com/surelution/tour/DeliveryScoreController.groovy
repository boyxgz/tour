package com.surelution.tour

import groovy.time.TimeCategory;

import java.text.SimpleDateFormat;

class DeliveryScoreController {

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
		Integer scoreFrom = params.scoreFrom?Integer.parseInt(params.scoreFrom):null
		Integer scoreTo = params.scoreTo?Integer.parseInt(params.scoreTo):null
		Integer itemScoreFrom = params.itemScoreFrom?Integer.parseInt(params.itemScoreFrom):null
		Integer itemScoreTo = params.itemScoreTo?Integer.parseInt(params.itemScoreTo):null
		
		println scoreFrom
		
		if(dateTo) {
			use(TimeCategory) {
				dateTo += 1.days
			}
		}
		def department = params['department.id']?Department.get(params['department.id']):null
		def unloadings = GasUnloading.createCriteria().list {
			if(department) {
				eq("department", department)
			}
			if(dateFrom) {
				ge("unloadingTime", dateFrom)
			}
			if(dateTo) {
				le("unloadingTime", dateTo)
			}
				
		}
		def result = new HashSet()
		def us = unloadings.findAll {
			it.score != null && it.score.id != null &&
					(!scoreFrom || it.score.totalScore >= scoreFrom) &&
					(!scoreTo || it.score.totalScore <= scoreTo) &&
					(!itemScoreFrom || it.score.lowestScoreItem.score.score >= itemScoreFrom) &&
					(!itemScoreTo || i.scoret.lowestScoreItem.score.score <= itemScoreTo)
		}
		us.each {
			result.add(it.score)
		}
		println result
		result = result.sort {
			it.id
		}
        [deliveryScoreInstanceList: result]
    }

    def create = {
        def deliveryScoreInstance = new DeliveryScore()
        deliveryScoreInstance.properties = params
		def unloading = GasUnloading.get(params.'unloading.id')
		def availableSeal = SealWire.findAllByDepartmentAndAvailable(unloading.department, true)
		
		if(unloading && unloading.score) {
			redirect(action:"show", id:unloading.score.id)
			return
		}
        return [deliveryScoreInstance: deliveryScoreInstance, deliveryScoreItemTypeList:DeliveryScoreItemType.list(), unloading:unloading, availableSeal:availableSeal]
    }

    def save = {
		def unloading = GasUnloading.get(params.'unloading.id')
		if(unloading) {
	        def deliveryScoreInstance = new DeliveryScore(params)
			deliveryScoreInstance.reportUser = springSecurityService.currentUser
			deliveryScoreInstance.reportDate = new Date()
	        if (deliveryScoreInstance.save(flush: true)) {
				if(deliveryScoreInstance.sealSn)
					deliveryScoreInstance.sealSn.available = false
	            flash.message = "${message(code: 'default.created.message', args: [message(code: 'deliveryScore.label', default: 'DeliveryScore'), deliveryScoreInstance.id])}"
				def types = DeliveryScoreItemType.list()
				types.each {
					def option = params.int("score_${it.id}")
					def remark = params["remark_${it.id}"]
					def score = DeliveryScoreItemOption.get(option)
					def item = new DeliveryScoreItem(deliveryScore:deliveryScoreInstance, type:it, score:score, remark:remark)
					item.save(flush:true)
				}
				unloading.score = deliveryScoreInstance
				
	            redirect(action: "show", id: deliveryScoreInstance.id)
				return
	        }
		}
        render(view: "create", model: [deliveryScoreInstance: deliveryScoreInstance])
    }

    def show = {
        def deliveryScoreInstance = DeliveryScore.get(params.id)
		def deliveryScoreItemInstanceList = DeliveryScoreItem.findAllByDeliveryScore(deliveryScoreInstance)
        if (!deliveryScoreInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScore.label', default: 'DeliveryScore'), params.id])}"
            redirect(action: "list")
        }
        else {
            [deliveryScoreInstance: deliveryScoreInstance, deliveryScoreItemInstanceList: deliveryScoreItemInstanceList]
        }
    }

    def edit = {
        def deliveryScoreInstance = DeliveryScore.get(params.id)
        if (!deliveryScoreInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScore.label', default: 'DeliveryScore'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [deliveryScoreInstance: deliveryScoreInstance]
        }
    }

    def update = {
        def deliveryScoreInstance = DeliveryScore.get(params.id)
        if (deliveryScoreInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (deliveryScoreInstance.version > version) {
                    
                    deliveryScoreInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'deliveryScore.label', default: 'DeliveryScore')] as Object[], "Another user has updated this DeliveryScore while you were editing")
                    render(view: "edit", model: [deliveryScoreInstance: deliveryScoreInstance])
                    return
                }
            }
            deliveryScoreInstance.properties = params
            if (!deliveryScoreInstance.hasErrors() && deliveryScoreInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'deliveryScore.label', default: 'DeliveryScore'), deliveryScoreInstance.id])}"
                redirect(action: "show", id: deliveryScoreInstance.id)
            }
            else {
                render(view: "edit", model: [deliveryScoreInstance: deliveryScoreInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScore.label', default: 'DeliveryScore'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def deliveryScoreInstance = DeliveryScore.get(params.id)
        if (deliveryScoreInstance) {
            try {
				GasUnloading.findAllByScore(deliveryScoreInstance).each {
					it.score = null
				}
                deliveryScoreInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'deliveryScore.label', default: 'DeliveryScore'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'deliveryScore.label', default: 'DeliveryScore'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'deliveryScore.label', default: 'DeliveryScore'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def showLink = {
		def unloading = GasUnloading.get(params.'unloading.id')
		if(unloading && unloading.score) {
			redirect(action:"show", id:unloading.score.id)
			return
		}
		
		def scores = new HashSet()
		if(unloading) {
			def dept = unloading.department
			
			def unloadingTime = unloading.unloadingTime
			def firstSightThisDay = new Date(unloadingTime.time)
			def firstSightNextDay
			use(TimeCategory) {
				firstSightThisDay.clearTime()
				firstSightThisDay = firstSightThisDay -1.day
				firstSightNextDay = firstSightThisDay + 3.day
			}
			
			def unloadings = GasUnloading.createCriteria().list {
				eq("department", dept)
				isNotNull("score")
				between("unloadingTime", firstSightThisDay, firstSightNextDay)
			}
			
			unloadings.each {
				scores.add(it.score)
			}
			
		}
		[deliveryScoreInstanceList:scores, gasUnloadingInstance:unloading]
	}
	
	def link = {
		def unloading = GasUnloading.get(params.'unloading.id')
		def deliveryScore = DeliveryScore.get(params.'deliveryScore.id')
		if(unloading && deliveryScore) {
			unloading.score = deliveryScore
			redirect(action:show, id:deliveryScore.id)
			return
		}
		redirect(action:showLink, params:['unloading.id':unloading.id])
	}
	
	def report = {
		def sdf = new SimpleDateFormat('yyyy-MM-dd')
		def department = params.'department.id'?Department.get(params.'department.id'):null
		def departmentList = UserDepartment.getUserDepartments(springSecurityService.currentUser.toString())
		def dateFrom = params.dateFrom?sdf.parse(params.dateFrom):null
		def dateTo = params.dateTo?sdf.parse(params.dateTo):null
		def trunckNo = params.trunckNo
		def driverName = params.driverName
		def supercargoName = params.supercargoName
		def splitted = params.splitted
		def tankFarm = params.'tankFarm.id'?TankFarm.get(params.'tankFarm.id'):null
		def gasType = params.'gasType.id'?GasType.get(params.'gasType.id'):null
		def formNo = params.formNo
		def tank = params.'tank.id'?GasTank.get(params.'tank.id'):null
		
		def unloadings
		def max = 500
		def offset = 0
		if(dateFrom || dateTo || trunckNo || driverName || supercargoName || department
			|| splitted || tankFarm || gasType || formNo) {
			unloadings = GasUnloadingItem.createCriteria().list() {
				createAlias("unloading", "u")
				createAlias("u.score", "d")
				if(trunckNo) {
					eq("d.trunckNo", trunckNo)
				}
				if(driverName) {
					eq("d.driverName", driverName)
				}
				if(supercargoName) {
					eq("d.supercargoName", supercargoName)
				}
				if(dateFrom) {
					ge("u.unloadingTime", dateFrom)
				}
				if(dateTo) {
					le("u.unloadingTime", dateTo)
				}
				if(department) {
					eq("u.department", department)
				}
				else{
					'in'("u.department",departmentList)
				}
				if(tankFarm) {
					eq("u.tankFarm", tankFarm)
				}
				if(gasType) {
					eq("u.gasType", gasType)
				}
				if(formNo) {
					eq("u.formNo", formNo)
				}
				if(tank) {
					eq("tank", tank)
				}
			}
			unloadings = unloadings.collect {
				it.unloading
			}
			if(params.splitted == '1') {
				unloadings = unloadings.findAll {
					it.splitted
				}
			}
			if(params.splitted == '0') {
				unloadings = unloadings.findAll {
					!it.splitted
				}
			}
		}
		
		[unloadings: unloadings]
	}
}
