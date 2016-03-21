package com.surelution.tour

class DeliveryScoreItem {

    static constraints = {
		remark nullable:true
		remark blank:true
    }
	static belongsTo = [deliveryScore:DeliveryScore]
	DeliveryScoreItemType type
	DeliveryScoreItemOption score
	String remark
}
