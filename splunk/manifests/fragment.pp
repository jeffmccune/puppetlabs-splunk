# Define: splunk::fragment
#
#   A low level define that creates a fragment to be used in the contruction of
#   a splunk application config file. The data contained in the fragment is
#   formatted and provided by a higher level define that is more narrowly
#   focused to produce a specific config file block.
#
#   Cody Herriges <cody@puppetlabs.com>
#   2010-12-22
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

define splunk::fragment(
  $ensure      = 'present',
  $fragment_id = '',
  $config_id,
  $app_id,
  $content
) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail('ensure must be present or absent')
  }

  if ! ($enable == true or $enable == false) {
    fail('enabled must be present or absent')
  }

  # Need to modify app.pp to set up app specific
  # fragent directories to support this new pattern.

  if ($fragment_id == '') {
    $fragment_id_real = $name
  } else {
    $fragment_id_real = $fragment_id
  }

  # Local variable to help with length
  $local_appdir  = "${splunk::fragpath}/${app_id}"
  $local_fragdir = "${splunk::fragpath}/${app_id}/${config_id}.d"

  # Declare the spool directory, target file and exec rebuild once, the
  # first time a resource of type splunk::fragment is declared.
  if ! defined(File[$local_appdir]) {
    file { $local_appdir:
      ensure => directory,
      owner  => 'puppet',
      group  => 'puppet',
      mode   => '0700',
      notify => Exec["rebuild_${app_id}_${config_id}"],
    }
  }

  if ! defined(File[$local_fragdir]) {
    file { $local_fragdir:
      ensure  => directory,
      recurse => true,
      purge   => true,
      owner   => 'puppet',
      group   => 'puppet',
      mode    => '0700',
      notify  => Exec["rebuild_${app_id}_${config_id}"],
    }
  }

  if ! defined(Exec["rebuild_${app_id}_${config_id}"]) {
    exec { "rebuild_${app_id}_${config_id}":
      command     => "/bin/cat ${local_fragdir}/* > ${local_appdir}/${config_id}",
      refreshonly => true,
      user        => 'puppet',
      group       => 'puppet',
    }
  }

  # Manage the permissions on the spooled file.
  if ! defined(File["${local_appdir}/${config_id}"]) {
    file { "${local_appdir}/${config_id}":
      ensure  => file,
      owner   => 'puppet',
      group   => 'puppet',
      mode    => '0600',
      require => Exec["rebuild_${app_id}_${config_id}"],
    }
  }

  # Manage the fragment.
  file { "${splunk::fragpath}/${app_id}/${config_id}.d/${fragment_id_real}":
    ensure  => $ensure,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0600',
    content => $content,
    notify  => Exec["rebuild_${app_id}_${config_id}"],
  }

}
