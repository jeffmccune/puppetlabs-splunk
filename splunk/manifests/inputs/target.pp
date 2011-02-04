# Define: splunk::inputs::target
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
define splunk::inputs::target(
  $target,
  $index  = 'main',
  $enable = true,
  $ensure = 'present',
  $app_id = 'puppet_managed'
) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail('ensure must be present or absent')
  }

  if ! ($enable == true or $enable == false) {
    fail('enabled must be present or absent')
  }

  splunk::fragment { "01_targetfrag_${name}":
    content     => template('splunk/targetfrag.erb'),
    config_id   => 'inputs',
    app_id      => $app_id,
  }
}
