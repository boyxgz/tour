package com.surelution.tour

/**
 * 油罐检查信息，液位比对信息，包括液位仪度数和实际度数
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class GasTankLevel {

    static constraints = {
		colorInfo nullable:true
		colorInfo blank:true
		impurityInfo nullable:true
		impurityInfo blank:true
		density nullable:true
		lastPdnDensity nullable:true
    }
	
	GasTank tank
	
	/**
	 * 液位仪读数
	 */
	Float instrumentAmount
	/**
	 * 实际读数
	 */
	Float amout
	
	/**
	 * 液位仪温度
	 */
	Float instrumentTemprature
	
	/**
	 * 实测温度
	 */
	Float temprature
	
	/**
	 * 手工水高
	 */
	Float waterLevel
	
	/**
	 * 液位仪水高
	 */
	Float instrumentWaterLevel
	
	/**
	 * 颜色异常
	 * true for 异常
	 */
	Boolean colorState
	
	String colorInfo
	
	/**
	 * 底部杂质情况
	 */
	String impurityInfo
	
	/**
	 * true for 有异常
	 */
	Boolean impurityState
	
	/**
	 * 密度
	 */
	Float density
	
	User user
	
	Date checkTime
	
	Float lastPdnDensity
}
