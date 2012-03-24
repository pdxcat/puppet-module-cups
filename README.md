# CUPS module for Puppet

## Description
Puppet module for managing cups on Debian and Solaris

## Usage

### cups::client
Install and configure a CUPS client

    class { 'cups::client':
      cups_bsd     => installed,
      print_server => 'printserver.example.com'
    }


### cups::server
Install and configure a CUPS server

    class { "cups::server":
      cupsd_conf => "puppet://$server/role/printserver/cupsd.conf";
    }


