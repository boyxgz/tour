package com.surelution.tour

/**
 * 
 * 卸油：车 > 仓 > 罐<br/>
 * 此处表示卸入某个仓的信息
 * 
 * 卸油详细信息保存在GasUnloadingItem中
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class GasUnloading {

	static constraints = {
		unloadingViewVolume nullable:true
		unloadingStdVolume nullable:true
		unloadingDensity nullable:true
		unloadingTemperature nullable:true
		score nullable:true
		dateCreated nullable:true
	}
	
	static hasMany = [items:GasUnloadingItem]
	
	static transients = ['amount', 'splitted']
	
	def beforeInsert() {
		dateCreated = new Date()
	}
	
	/**
	 * 罐号
	 */
//	GasTank tank
	
	Department department
	
	/**
	 *  时间
	 */
	Date unloadingTime
	
	/**
	 * 计划单号
	 */
	String formNo
	
	/**
	 * 计划量
	 */
	Float planningAmount
	
	/**
	 * 实收量
	 */
//	Float amount

	/**
	 * 录单人
	 */
	User user
	
	/**
	* 收油人员
	*/
   String loadingUser
	
	TankFarm tankFarm
	
	GasType gasType
	
	String warehouseNo
	
	/**
	 * 装车表观体积
	 */
	Float entruckingViewVolume 
	
	Float entruckingStdVolume
	
	Float entruckingDensity
	
	Float entruckingTemperature

	/**
	 * 加油站车上实收数据  表观体积
	 */
	Float unloadingViewVolume
	
	Float unloadingStdVolume
	
	Float unloadingDensity
	
	Float unloadingTemperature
	
	DeliveryScore score
	
	Date dateCreated
	
	/**
	 * 分罐
	 */
	Boolean getSplitted() {
		return items && items.size() > 1
	}
	
	Float getAmount() {
		if(items) {
			def amount = items.sum {
				it.stdVolume
			}
			return amount
		}
		0
	}
}
