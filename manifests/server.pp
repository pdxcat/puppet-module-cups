# Class: cups::server
#
#   This class installs cups client software.
#
# Parametersd
#   [*cupsd_conf*]  - The puppet path to the cupsd.conf file
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class cups::server(
  $cupsd_conf,
) {

  include cups::params

  file { '/etc/cups/cupsd.conf':
    mode   => '0644',
    owner  => 'root',
    source => $cupsd_conf;
  }

  service { 'cups':
    ensure    => running,
    name      => $cups::params::service_name,
    enable    => true,
    require   => Package['cups_server_package'],
    subscribe => File['/etc/cups/cupsd.conf'];
  }

  package { 'cups_server_package':
    ensure => installed,
    name   => $cups::params::server_package,
  }


}
