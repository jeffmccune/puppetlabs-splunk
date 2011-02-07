# Define: splunk::inputs::receiver
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
define splunk::inputs::receiver(
  $ensure   = 'present',
  $enable   = true,
  $port     = '',
  $receiver = false,
  $app_id   = 'puppet_managed',
  $ssl      = false
  ) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail('ensure must be present or absent')
  }

  if ! ($enable == true or $enable == false) {
    fail('enabled must be present or absent')
  }

  if ! ($receiver == true or $receiver == false) {
    fail('receiver must be true or false')
  }

  if ($port == '') {
    $port_real = $name
  } else {
    $port_real = $port
  }

  splunk::fragment { "02_receiverfrag_${name}":
    content     => template('splunk/receiverfrag.erb'),
    config_id   => "inputs",
    app_id      => $app_id,
  }
}
