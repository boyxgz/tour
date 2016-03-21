package com.surelution.tour

import java.io.File;
import java.lang.management.ManagementFactory;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

class SystemInfoController {

    def index = {
		def sysInfo = servletContext["system-info"]
		
		def wandSn = new StringBuilder();
		sysInfo.wandsSn.each {
			wandSn.append(it)
			wandSn.append(",")
		}
		
		def poiSn = new StringBuilder()
		sysInfo.poisSn.each {
			poiSn.append(it)
			poiSn.append(",")
		}
		
		[wandSn:wandSn, poiSn:poiSn]
	}
	def help = {}
	
	def tech = {
		
		def os = ManagementFactory.operatingSystemMXBean
		def rt = ManagementFactory.runtimeMXBean
		
		def mem = ManagementFactory.memoryMXBean
		[os:os, rt:rt, mem:mem]
	}
	
	/**
	 * just used for init gas gun data, nobody need use it anymore
	 */
	private void initGasGun() {
		String path = "/Users/syujohnny/Downloads/a(1).xls";
		Workbook workbook = Workbook.getWorkbook(new File(path));
		Sheet sheet = workbook.getSheet(0)
		String dId
		String name
		for(int i = 2; i < 129; i++) {
			Cell[] cells = sheet.getRow(i)
			if(cells[3].contents) {
				dId = cells[3].contents
			}
			if(cells[2].contents) {
				name = cells[2].contents
			}
			String tankNo = cells[12].contents.trim()
			String tankVol = cells[13].contents.trim()
			
			String gasType = cells[14].contents.trim()
			String gunNos = cells[15].contents.trim()
			if(tankNo) {
				float f = Float.parseFloat(tankVol)
				if(f < 1000) {
					f *= 1000
				}
				println "${dId},${name},${tankNo}, ${tankVol}, ${gasType}, ${gunNos}"
				
				def dept = Department.get(dId)
				def gType = GasType.findByTitle(gasType)
				if(!gType) {
					gType = new GasType(title:gasType)
					gType.save(flush:true)
				}
				def tank = GasTank.findByDepartmentAndTankNo(dept, tankNo)
				if(!tank) {
					tank = new GasTank(department:dept, tankNo:tankNo, gasType:gType, description:"*", volume:f)
					tank.save(flush:true)
				}
				
				gunNos.split("、").each {
					def gGun = new GasGun(tank:tank, gunNo:it.trim())
					gGun.save(flush:true)
				}
				
			
				
			}
//			for(int j = 0; j < cells.length; j++ ) {
//				Cell c = cells[j];
//				System.out.print(c.getContents());
//				System.out.print(",");
//			}
			System.out.println();
		}
	}
}
