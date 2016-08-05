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
      ensure => $cups_bsd,
      name   => $cups::params::cupsbsd_package,
    }
  }

  file {
    'config_dir':
      ensure => directory,
      name   => $cups::params::config_dir,
      owner  => $cups::params::config_owner,
      group  => $cups::params::config_group;
    'client.conf':
      name    => $cups::params::config_file,
      mode    => '0644',
      owner   => $cups::params::config_owner,
      group   => $cups::params::config_group,
      content => "ServerName ${print_server}",
      require => File['config_dir'];
  }

  package { 'cups_client_package':
    ensure   => installed,
    provider => $cups::params::provider,
    name     => $cups::params::client_package,
  }
}
