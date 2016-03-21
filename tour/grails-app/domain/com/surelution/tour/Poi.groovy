package com.surelution.tour

class Poi {

    static constraints = {
		sn unique:true
		description nullable:true
    }
	
	Department department
	String name
	
	/**
	 * address card sn
	 */
	String sn
	String description
	
	public List<Poi> allPoiByDptId(Integer id) {
		def dep = Department.get(id)
		return findAllByDepartment(dep)
	}

	@Override
	public String toString() {
		return "Poi [department=" + department + ", name=" + name + ", sn=" + sn + ", description=" + description + "]";
	}
	
	/**
	* exceptions throws if the object is not from db
	*/
	public int hashCode() {
		id
	}
	
	/**
	* exceptions throws if the object is not from db
	*/
	public boolean equals(Object o) {
		if(o instanceof Poi) {
			return o.id == id
		}
		return false
	}
}
