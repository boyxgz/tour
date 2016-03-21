package com.surelution.tour

class Vt2Vcf {

    static constraints = {
    }
	Date month
	Double ratio
	GasTank tank
	
	static Double ratioOfDateAndTank(Date date, GasTank tank) {
		def vcf = Vt2Vcf.createCriteria().get {
			eq("tank", tank)
			le("month", date)
			order("month", "desc")
		}
		vcf?vcf.ratio:0
	}
}
