package com.surelution.tour

class AppConfig {

    static constraints = {
		key unique:true
    }
	
	static mapping = {
		key column:"key_col"
		value column:"value_col"
	}

	String key
	String value
	
	public static String findValue(String key) {
		AppConfig config = findByKey(key)
		if(!config) {
			config = new AppConfig(key:key, value:"")
			config.save(flush:true)
			return null
		} else {
			return config.value
		}
	}
}
