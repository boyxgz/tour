package com.surelution.tour

class SealWire {

    static constraints = {
		status nullable:true
    }

	String prefix
	String sn
	Department department
	Boolean available
	SealWireStatus status
	SealWireBatch importBatch
}
