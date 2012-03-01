class apache::software {
	package { ["apache2", "apache2-prefork", "apache2-mod_php5" ]:
		ensure => present,
	}
}
