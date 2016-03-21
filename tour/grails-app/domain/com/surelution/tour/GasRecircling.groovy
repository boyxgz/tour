package com.surelution.tour

/**
 * 初期需求是回罐油，而实际上，应该是应该是所有的非销售性质的油品发出，比如：自用油、油品被相关管理部门拿走鉴定等
 * 有的油品被放出后，需要重新回到油罐，有的则不一定，是否要求回罐，定义在type属性中
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class GasRecircling {

    static constraints = {
		inputTime nullable:true
		involvedPerson nullable:true
		description nullable:true
		differAmount nullable:true
		startGunCount nullable:true
		endGunCount nullable:true
		summary nullable:true
    }
	
	GasRecirclingType type

	User user
	GasGun gun
	/**
	 * 偏差量
	 */
	Float differAmount
	/**
	 * 回罐数量
	 */
	Float volume
	
	/**
	 * 期初泵码数，出油前油枪泵码数
	 */
	Float startGunCount
	
	/**
	 * 期末泵码数，出油后油枪泵码数
	 */
	Float endGunCount
	
	/**
	 * 备注
	 */
	String description
	
	String involvedPerson
	
	Date outputTime
	Date inputTime
	
	Date reportTime
	
	GasRecirclingSummary summary
	
	/**
	 * shits here
	 * @param tank
	 * @param from
	 * @param to
	 * @return
	 */
	static Float sumPeriodAmount(GasTank tank, Date from, Date to) {
		def amount = GasRecircling.createCriteria().get {
			createAlias("gun", "g")
			eq("g.tank", tank)
			between("outputTime", from, to)
			projections {
				sum("volume")
			}
		}
		amount?amount:0
	}
}
