 define apache::vhost(
        $port,
        $docroot,
        $template      = 'apache/vhost.conf.erb',
        $priority      = '10',
        $servername    = '',
        $serveraliases = '',
        $options       = "Indexes FollowSymLinks MultiViews",
        $vhost_name    = '*',
	$logdir        = '/var/log/apache2'
 	) {
    
      include apache
      
      # Below is a pre-2.6.5 idiom for having a parameter default to the title, 
      # but you could also just declare $servername = "$title" in the parameters
      # list and change srvname to servername in the template.
      
      if $servername == '' {
        $srvname = $title
      } else {
        $srvname = $servername
      }
      
	file {
        "/etc/apache2/vhosts.d/${priority}-${name}.conf":
          content => template($template),
          owner   => 'root',
          group   => 'root',
          mode    => '755',
          require => Class['apache::software'],
          notify  => Service['apache2'],
      }
   
      file { "${docroot}":
	      path   => "${docroot}",
	      ensure => directory,
	      mode   => 755,
	      owner  => 'root',
	      group  => 'root',
      }
    }

