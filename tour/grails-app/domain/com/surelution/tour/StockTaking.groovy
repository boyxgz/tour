package com.surelution.tour

/**
 * 库存盘点，记录本次盘点时间、盘点人、盘点油站，分罐记录库存量和销售量
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class StockTaking {

    static constraints = {
		patrol nullable:true
		previousTaking nullable:true
    }
	
	static hasMany = [items:StockTakingItem]
	
	static transients = ['totalStock','totalSalesAmount']

	Patrol patrol
	Date takingTime
	User user
	Department department
	StockTaking previousTaking
	
	/**
	 * 由于涉及到不同油罐的vcf值（Vt-V20的转换率）不同，
	 * 所以，将所有油枪的销售度数累加是没有意义的
	 * @return
	 */
	@Deprecated
	public Float getTotalStock() {
		if(items) {
			return items.sum {
				it.stockAmount?it.stockAmount:0
			}
		} else
			return 0 
	}
	
	public Float getTotalSalesAmount() {
		if(items) {
			return items.sum {
				it.salesAmount?it.salesAmount:0
			}
		} else
			return 0
	}
}
