package com.surelution.tour

class User {

	transient springSecurityService

	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	Department department
	PatrolType patrolType
	Branch branch

	static constraints = {
		username blank: false, unique: true
		password blank: false
		department nullable:true
		patrolType nullable:true
		branch nullable:true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}

	@Override
	public String toString() {
		return username;
	}
}
