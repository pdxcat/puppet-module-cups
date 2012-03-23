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
     name      => $cups::params::service_name,
     ensure    => running,
     enable    => true,
     require   => Package['cups_server_package'],
     subscribe => File['/etc/cups/cupsd.conf'];
   }

   package { 'cups_server_package':
     name    => $cups::params::server_package,
     ensure  => installed,
   }


}
