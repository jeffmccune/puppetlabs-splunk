# Define: splunk::outputs:group
#
#   Cody Herriges <cody@puppetlabs.com>
#   2010-01-28
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class splunk::outputs::group(
  $ensure        = 'present',
  $app_id        = 'puppet_managed',
  $auto_lb       = false,
  $compress      = false,
  $lb_servers    = '',
  $enable        = true,
  $index_forward = false,
  $send_cooked   = false,
  $max_queue     = '1000',

) {

  if ! ($ensure == 'present' or $ensure == 'absent') {
    fail('ensure must be present or absent')
  }

  splunk::fragment { "01_groupfrag_${name}":
    content     => template('splunk/globalfrag.erb'),
    config_id   => 'outputs',
    app_id      => $app_id,
  }
}
