/**
 * 
 */
package com.surelution.tour.vo

import com.surelution.tour.GasGun;
import com.surelution.tour.GasRecircling;
import com.surelution.tour.GasTank;
import com.surelution.tour.GasUnloadingItem;
import com.surelution.tour.StockTakingItem;
import com.surelution.tour.Vt2Vcf;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class TankPeriodStockTaking {

	StockTakingItem startTakingItem
	
	StockTakingItem endTakingItem
	
	GasTank tank
	
	Date getStartTime() {
		startTakingItem?.taking?.takingTime
	}
	
	Date getEndTime() {
		endTakingItem?.taking?.takingTime
	}
	
	public List<GunPeriodStockTaking> getGunTakings() {
		def guns = GasGun.findAllByTank(tank)
		guns.collect {gun->
			def startGunSales = startTakingItem?.gunSales?.find {sales->
				sales.gun.id == gun.id
			}
			def endGunSales = endTakingItem?.gunSales?.find {sales->
				sales.gun.id == gun.id
			}
			new GunPeriodStockTaking(gun:gun, startGunItem:startGunSales, endGunItem:endGunSales)
		}
	}
	
	public Double getTotalGunsAmount() {
		def end = endTakingItem?.gunSales?.sum {sales->
			sales.salesAmount
		}
		def start = startTakingItem?.gunSales?.sum {sales->
			sales.salesAmount
		}
		end = end?end:0
		start = start?start:0
		end - start
	}
	
	public Double getVt2VcfRatio() {
		def ratio
		if(endTime) 
			ratio = Vt2Vcf.ratioOfDateAndTank(getEndTime(), tank)
		ratio ? ratio : 1
	}
	
	public Float getUnloadingAmount() {
		def amount
		if(startTime && endTime)
			amount = GasUnloadingItem.sumPeriodUnloadingAmount(tank, startTime, endTime)
		amount?amount:0
	}
	
	public Float getPlanningUnloadingAmount() {
		def amount
		if(startTime && endTime)
			amount = GasUnloadingItem.sumPeriodPlanningUnloadingAmount(tank, startTime, endTime)
		amount?amount:0
	}
	
	public Float getRecirclingAmount() {
		def amount
		if(startTime && endTime)
			amount = GasRecircling.sumPeriodAmount(tank, startTime, endTime)
		amount?amount:0
	}
}
