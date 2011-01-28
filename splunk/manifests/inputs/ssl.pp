# Define: splunk::inputs::ssl
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
class splunk::inputs::ssl(
  $server_cert,
  $password = 'password',
  $root_ca,
  $dhfile = '',
  $validate_client = false,
  $enable = true,
  $app_id = 'puppet_managed'
) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail("ensure must be present or absent")
  }

  if ! ($enable == true or $enable == false) {
    fail("enabled must be present or absent")
  }

  splunk::fragment { "03_sslfrag":
    content     => template('splunk/sslfrag.erb'),
    config_file => 'inputs',
    app_id      => $app_id,
    ensure      => $enable ? {
      true  => 'present',
      false => 'absent',
    },
  }
}
