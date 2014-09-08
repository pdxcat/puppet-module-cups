# Class: cups::params
#
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class cups::params {

  case $::osfamily {

    'Debian': {
      $client_package  = 'cups-client'
      $provider        = 'apt'
      $config_dir      = '/etc/cups'
      $config_file     = '/etc/cups/client.conf'
      $config_group    = 'lp'
      $config_owner    = 'root'
      $cupsbsd_package = 'cups-bsd'
      $server_package  = 'cups'
      $service_name    = 'cups'
    }

    'RedHat': {
      $client_package  = 'cups'
      $provider        = 'yum'
      $config_dir      = '/etc/cups'
      $config_file     = '/etc/cups/client.conf'
      $config_group    = 'lp'
      $config_owner    = 'root'
      $cupsbsd_package = undef
      $server_package  = 'cups'
      $service_name    = 'cups'
    }

    'Solaris': {
      $client_package  = 'cupsclient'
      $provider        = 'pkgutil'
      $config_dir      = '/etc/opt/csw/cups'
      $config_file     = '/etc/opt/csw/cups/client.conf'
      $config_group    = 'bin'
      $config_owner    = 'root'
      $cupsbsd_package = undef
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily Debian, RedHat and Solaris")
    }
  }

}
