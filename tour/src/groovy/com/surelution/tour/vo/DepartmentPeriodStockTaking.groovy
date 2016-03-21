/**
 * 
 */
package com.surelution.tour.vo


import com.surelution.tour.CommonDensity
import com.surelution.tour.Department;
import com.surelution.tour.GasRecircling
import com.surelution.tour.GasTank;
import com.surelution.tour.GasUnloadingItem
import com.surelution.tour.StockTaking;
import com.surelution.tour.GasUnloading;
import com.surelution.tour.StockTakingItem
/**
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class DepartmentPeriodStockTaking {

	Department department
	List<StockTaking> takings
	Date periodStart
	Date periodEnd
	
	public StockTaking getFirstTaking() {
		if(takings && takings.size() > 0)takings[0]
	}
	
	public StockTaking getLastTaking() {
		if(takings && takings.size() > 0) takings[takings.size() - 1]
	}
	
	public int getTakingCount() {
		(takings && takings.size() > 0) ? takings.size() : 0
	}
	
	/**
	 * 此处业务逻辑需要引起注意
	 * 在销量的处理中，需要将每个油罐的销售数量转化为v20，
	 * 而每个油罐的vt-v20的转换率是不一样的，所以，需要分别根据油罐来计算两次盘点间的油品销售泵码数的差值 X 转化率
	 * 这样才是真正的v20销售数
	 * @return 损耗率
	 */
	public Float getShrinkRate() {
		def gunsV20Amount = 0
		def unloadingAmount = 0
		def recircligAmount = 0
		def stockDiffer = 0
		tankTakings?.each {tankTaking ->
			gunsV20Amount += tankTaking.totalGunsAmount * tankTaking.vt2VcfRatio
			unloadingAmount += tankTaking.unloadingAmount
			recircligAmount += tankTaking.recirclingAmount
			def a = tankTaking.startTakingItem?.stockAmount
			def b  = tankTaking.endTakingItem?.stockAmount
			a = a?a:0
			b = b?b:0
			stockDiffer += (a - b)
		}
		if(gunsV20Amount != 0) {
			return (unloadingAmount + stockDiffer + recircligAmount - gunsV20Amount)/gunsV20Amount
		}
		else
			return 0
	}
	
	public Float getFinancialShrinkRate() {
		if(firstTaking) {
			List<GasTank> tanks = GasTank.findAllByDepartment(department)
			def from = firstTaking?firstTaking.takingTime:periodStart
			def to = lastTaking?lastTaking.takingTime:periodEnd
			float shrinkAmount = 0
			float salesAmount = 0
			tanks.each {tank->
				def planningUnloadingAmount = GasUnloadingItem.sumPeriodPlanningUnloadingAmount(tank, from, to)
				StockTakingItem firstTankTaking = firstTaking.items.find {item->
					item.tank.id == tank.id
				}
				StockTakingItem lastTankTaking = lastTaking.items.find {item->
					item.tank.id == tank.id
				}
				def startStockTakingAmount = firstTankTaking?.stockAmount
				startStockTakingAmount = startStockTakingAmount?startStockTakingAmount:0
				def endStockTakingAmount = lastTankTaking?.stockAmount
				endStockTakingAmount = endStockTakingAmount?endStockTakingAmount:0
				def recirlingAmount = GasRecircling.sumPeriodAmount(tank, from, to)
				recirlingAmount = recirlingAmount?recirlingAmount:0
				def startTankSalesAmount = firstTankTaking?.salesAmount
				startTankSalesAmount = startTankSalesAmount?startTankSalesAmount:0
				def endTankSalesAmount = lastTankTaking?.salesAmount
				endTankSalesAmount = endTankSalesAmount?endTankSalesAmount:0
				def tankSalesAmount = endTankSalesAmount - startTankSalesAmount
				tankSalesAmount = tankSalesAmount?tankSalesAmount:0
				
				def startDensity = CommonDensity.findDensityByDateAndType(from, tank.gasType) -1.1
				println "$from, ${tank.gasType.id}, ${startDensity}"
				startDensity = startDensity?startDensity:0
				def endDensity = CommonDensity.findDensityByDateAndType(to, tank.gasType) - 1.1
//				println "$to, ${tank.gasType.id},${endDensity}"
				endDensity = endDensity?endDensity:0
				
				shrinkAmount += Math.round(startStockTakingAmount*startDensity/1000)
				shrinkAmount += planningUnloadingAmount*endDensity/1000
				shrinkAmount += -(tankSalesAmount -recirlingAmount)*endDensity/1000
				shrinkAmount += -Math.round(endStockTakingAmount*endDensity/1000)
				
				salesAmount += (tankSalesAmount -recirlingAmount)*endDensity/1000
//				println "$startStockTakingAmount,$startDensity,$endStockTakingAmount,$endDensity,$planningUnloadingAmount,$recirlingAmount,$startTankSalesAmount,$endTankSalesAmount"
			}
			return shrinkAmount / salesAmount
		} else {
			return 0
		}
	}
	
	public Float getTotalUnloadingAmount() {
		def from = firstTaking?firstTaking.takingTime:periodStart
		def to = lastTaking?lastTaking.takingTime:periodEnd
		def unloadings = GasUnloading.findAllByDepartmentAndUnloadingTimeBetween(department, from, to)
		def amount = unloadings?.sum {
			it.amount
		}
		amount?amount:0
	}
	
	public List<TankPeriodStockTaking> getTankTakings() {
		def tanks = GasTank.findAllByDepartment(department)
		tanks?.collect {tank ->
			def firstStockTakingItem = firstTaking?.items?.find {item->
				item.tank.id == tank.id
			}
			def lastStockTakingItem = lastTaking?.items?.find {item->
				item.tank.id == tank.id
			}
			new TankPeriodStockTaking(tank:tank, 
				startTakingItem:firstStockTakingItem, endTakingItem:lastStockTakingItem)
		}
	}
	
}
