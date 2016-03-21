package com.surelution.tour

/**
 * 盘点项，以油罐为单位
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class StockTakingItem {

    static constraints = {
		stockAmount nullable:true
    }
	
	static transients = ['previousStockAmount', 'salesAmount']
	
	static hasMany = [gunSales:StockTakingItemGun]

	StockTaking taking
	GasTank tank
	BigDecimal stockAmount
	
	/**
	 * 销售泵码数
	 */
	public Float getSalesAmount() {
		if(gunSales) {
			return gunSales.sum {
				it.salesAmount
			}
		} else 
			return 0
	}
	
	public Float getPreviousStockAmount() {
		if(taking) {
			if(taking.previousTaking) {
				def pres = StockTakingItem.findByTakingAndTank(taking.previousTaking, tank)
				if(pres)
					return pres.stockAmount
			}
		}
		return 0
	}
}
