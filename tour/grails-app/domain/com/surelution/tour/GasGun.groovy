package com.surelution.tour

class GasGun {

    static constraints = {
    }
	
	GasTank tank
	String gunNo
	
	static List<GasGun> findAllByDepartment(Department dept) {
		def cri = createCriteria()
		return cri.list() {
			createAlias("tank", "t")
			eq("t.department", dept)
		}
	}
}
