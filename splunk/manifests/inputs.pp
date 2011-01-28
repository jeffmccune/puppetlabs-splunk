# Define: splunk::inputs
#
#   Sets up a warning header for inputs.conf and copies our spooled together
#   inputs file to the proper location.
#
#   Cody Herriges <cody@puppetlabs.com>
#   2011-1-18
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class splunk::inputs(
  $app_id = 'puppet_managed'
) {

  splunk::fragment { '00_header':
		content   => '# This file is managed by puppet and will be overwritten\n',
		config_id => 'inputs',
		app_id    => $app_id,
  }

  file { "${splunk::app::apppath}/default/inputs.conf":
    mode    => '0644',
    owner   => 'splunk',
    group   => 'splunk',
    require => File["${splunk::fragpath}/${app_id}/inputs"],
    notify  => Service['splunk'],
  }

}
