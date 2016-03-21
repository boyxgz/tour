/**
 * 
 */
package com.surelution.tour.vo

import com.surelution.tour.Department
import com.surelution.tour.StockTaking;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class ContrastStockTaking {

	private StockTaking first
	private StockTaking last
	private Department department
	private List<ContrastTankStockTaking> tankTakings

	public ContrastStockTaking(StockTaking first, StockTaking last) {
		if(first && last && first.department && first.department.id == last.department.id) {
			this.first = first
			this.last = last
			department = first.department
			tankTakings = new ArrayList<ContrastTankStockTaking>()
			
		} else {
			log.error "the first taking and last taking is illegal"
		}
	}
	
	
}
