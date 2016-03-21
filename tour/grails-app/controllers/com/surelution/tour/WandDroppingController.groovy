package com.surelution.tour

class WandDroppingController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
		def from = params.from
		def to = params.to
		def wandSn = params.wandSn
		def userId = params["user.id"]
		def user
		if(userId) {
			user = User.get(userId)
		}
		def cri = WandDropping.createCriteria()
		def droppings = cri.list(max:Math.min(params.max ? params.int('max') : 10, 100), offset:(params.offset ? params.int('offset') : 0)) {
			if(from) {
				ge("date", from)
			}
			if(to) {
				le("date", to)
			}
			if(wandSn) {
				eq("wandSn", wandSn)
			}
			if(user) {
				eq("user", user)
			}
			order("date", "desc")
		}
        [wandDroppingInstanceList: droppings, wandDroppingInstanceTotal: droppings.totalCount, params:params, user:user]
    }
}
