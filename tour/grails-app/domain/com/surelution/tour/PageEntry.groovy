package com.surelution.tour

class PageEntry {

    static constraints = {
		controllerName nullable:true
		actionName nullable:true
		parent nullable:true
    }
	
	static hasMany = [children:PageEntry]
	
	String label
	String controllerName
	String actionName
	Boolean isLeaf
	Boolean showInMenu
	PageEntry parent
	Integer positionSeq
}
