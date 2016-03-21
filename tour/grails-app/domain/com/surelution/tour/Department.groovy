package com.surelution.tour

class Department {

    static constraints = {
		branch nullable:true
    }
	
	String name
	String address
	String tel
	String description
	String shortName
	Branch branch

	@Override
	public boolean equals(Object obj) {
		Department d = obj as Department
		if(!obj) {
			return false;
		}
		if(id) {
			return id.equals(d.id)
		}
		return false;
	}


	@Override
	public int hashCode() {
		if(!id) {
			return 0;
		}
		return id.hashCode();
	}	
	
}
