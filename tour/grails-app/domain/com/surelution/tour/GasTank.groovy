package com.surelution.tour

/**
 * 油罐
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class GasTank {

    static constraints = {
    }
	
	static hasMany = [guns:GasGun]
	
	Department department
	String tankNo
	String  description
	Float volume
	GasType gasType
}
