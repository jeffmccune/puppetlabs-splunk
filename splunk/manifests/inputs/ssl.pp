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

  if ! ($enable == true or $enable == false) {
    fail('enable must be true or false')
  }

  splunk::fragment { '03_sslfrag':
    content     => template('splunk/sslfrag.erb'),
    app_id      => $app_id,
    config_id   => 'inputs',
    ensure      => $enable ? {
      true  => 'present',
      false => 'absent',
    },
  }
}
