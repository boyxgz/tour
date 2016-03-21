package com.surelution.tour

/**
 * 初始的需求为配送评价，实际上，应该是详细的配送信息，如车辆信息、返程铅封、配送信息等
 * 或许，Delivery是一个恰当的名字
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class DeliveryScore {

    static constraints = {
		sealSn nullable:true
    }
	
	static hasMany = [items: DeliveryScoreItem, unloadings:GasUnloading]
	
	static transients = ['totalScore', 'lowestScoreItem']
	
	String trunckNo
	String driverName
	String supercargoName
	Date reportDate
	User reportUser
	
	/**
	 * 返程铅封
	 */
	SealWire sealSn
	
	/**
	 * @return 所有的分项分数的总和
	 */
	public Integer getTotalScore() {
		if(items) {
			return items.sum({
				it.score.score
			})
		}
		0
	}

	/**
	 * @return 所有得分项目中，分数最低的那个项目
	 */
	public DeliveryScoreItem getLowestScoreItem() {
		if(items) {
			return items.min({
				it.score.score
			})
		}
		null
	}
	
	def beforeDelete() {
		if(sealSn) {
			sealSn.available = true
		}
	}
}
