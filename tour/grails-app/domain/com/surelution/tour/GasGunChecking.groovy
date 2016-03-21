package com.surelution.tour

class GasGunChecking {

    static constraints = {
    }

	/**
	 * 所属盘点
	 */
	StockTaking taking
	User user
	GasGun gun
	/**
	 * 偏差量
	 */
	Float differAmount
	/**
	 * 回罐数量
	 */
	Float volume
	/**
	 * 备注
	 */
	String description
}
