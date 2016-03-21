package com.surelution.tour

/**
 * 卸油：车 > 仓 > 罐<br/>
 * 此处表示卸入某个罐的信息
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class GasUnloadingItem {

    static constraints = {
    }
	
	static belongsTo = [unloading:GasUnloading]
	
	GasTank tank
	
	/**
	 * 表观体积，Vt
	 */
	Float amount
	
	/**
	 * 标准体积，V20
	 */
	Float stdVolume
	
	Float density
	
	Float temperature
	
	Float preUnloadingHeight
	
	Float postUnloadingHeight
	
	static Float sumPeriodUnloadingAmount(GasTank tank, Date from, Date to) {
		def amount = GasUnloadingItem.createCriteria().get {
			createAlias("unloading", "u")
			eq("tank", tank)
			between("u.unloadingTime", from, to)
			projections {
				sum("stdVolume")
			}
		}
		amount?amount:0
	}
	
	//it's not precise, for the splitting reason
	static Float sumPeriodPlanningUnloadingAmount(GasTank tank, Date from, Date to) {
		def amount = GasUnloadingItem.createCriteria().get {
			createAlias("unloading", "u")
			eq("tank", tank)
			between("u.unloadingTime", from, to)
			projections {
				sum("u.planningAmount")
			}
		}
		amount?amount:0
	}
}
