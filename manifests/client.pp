# Class: cups::client
#
#   This class installs cups client software.
#
# Parameters:
#   [*print_server*]  - The name of the cups server
#   [*cups_bsd*]      - Install the cups bsd package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

class cups::client(
  $print_server,
  $cups_bsd      = undef
) {

  include cups::params

  if $print_server == undef {
    fail('print_server parameter required')
  }

  if ($cups_bsd != undef and $cups::params::cupsbsd_package != undef) {
    package { 'cupsbsd_package':
      name   => $cups::params::cupsbsd_package,
      ensure => $cups_bsd
    }
  }

  file {
    'config_dir':
      name    => $cups::params::config_dir,
      ensure  => directory,
      owner   => $cups::params::config_owner,
      group   => $cups::params::config_group;
    'client.conf':
      name    => $cups::params::config_file,
      mode    => '0644',
      owner   => $cups::params::config_owner,
      group   => $cups::params::config_group,
      content => "ServerName $print_server",
      require => File['config_dir'];
  }

  package { 'cups_client_package':
    name   => $cups::params::client_package,
    ensure => installed
  }
}
