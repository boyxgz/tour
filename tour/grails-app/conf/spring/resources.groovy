import org.codehaus.groovy.grails.commons.GrailsApplication;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import grails.util.Environment;
import grails.util.GrailsUtil;
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

// Place your Spring DSL code here
beans = {
	localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
		defaultLocale = new Locale("zh","CN")
		java.util.Locale.setDefault(defaultLocale)
	}
	
	if (Environment.current != Environment.TEST) {
		dataSource(ComboPooledDataSource) { bean ->
			bean.destroyMethod = 'close'
			user = CH.config.dataSource.username
			password = CH.config.dataSource.password
			driverClass = CH.config.dataSource.driverClassName
			jdbcUrl = CH.config.dataSource.url
			initialPoolSize = 10
			minPoolSize = 10
			maxPoolSize = 50
			maxStatements = 240
			maxConnectionAge = 60 * 60 * 2 // 2 hours
			maxIdleTime = 60 * 60 // 1 hour
			idleConnectionTestPeriod = 240
			testConnectionOnCheckin = true
			testConnectionOnCheckout = true
			automaticTestTable = "c3p0_test"
		}
	}
}
