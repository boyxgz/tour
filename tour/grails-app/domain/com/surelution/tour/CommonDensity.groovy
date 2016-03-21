package com.surelution.tour

import groovy.time.TimeCategory;

class CommonDensity {

    static constraints = {
    }
	
	GasType type
	Date start
	Date end
	Double density

	static Double findDensityByDateAndType(Date date, GasType type)  {
		def dateAhead
		use(TimeCategory) {
			dateAhead = date - 1.day
		}
		
		def cri = CommonDensity.createCriteria()
		def cds = cri.list() {
			eq('type', type)
			le('start', date)
			gt('end', dateAhead)
		}
		
		CommonDensity density = cds&&cds.size()>0?cds.get(0):null
		if(density && density.density)
			return density?.density
		else
			return 0
	}
}
