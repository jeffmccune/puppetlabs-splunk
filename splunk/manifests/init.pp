# Class: splunk
#
#   Puppet Labs Splunk module.
#
#   This module manages and configures Splunk
#
#   Jeff McCune <jeff@puppetlabs.com>
#   Cody Herriges <cody@puppetlabs.com>
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
class splunk(
  $fragbase = '/var/lib/puppet/spool'
) {

  $fragpath = "${fragbase}/splunk.d"

  # We will create a module for fragment
  # directories.

  if ! defined(File[$fragbase]) {
    file { $fragbase:
      ensure => directory,
      mode   => '0700',
      owner  => 'puppet',
      group  => 'puppet',
    }
  }

  file { $fragpath:
    ensure  => directory,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0700',
    purge   => true,
    recurse => true,
  }

}
