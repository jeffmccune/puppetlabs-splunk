class { 'splunk::users':
  virtual => false
}

class { 'splunk::package':
  pkg_base => 'http://192.168.135.1',
  pkg_file => 'splunk-4.1.6-89596-linux-2.6-x86_64.rpm',
  has_repo => false,
}

class { 'splunk::service': }

class { 'splunk':
  fragbase => '/var/lib/puppet/spool'
}
class { 'splunk::app': }
class { 'splunk::inputs': }
class { 'splunk::inputs::ssl':
  server_cert     => '$SPLUNK_HOME/etc/auth/server.pem',
  password        => 'password',
  root_ca         => '$SPLUNK_HOME/etc/auth/cacert.pem',
  validate_client => true,
}
splunk::inputs::target { 'messages':
  target => '/var/log/messages',
}
splunk::inputs::target { 'maillog':
  target => '/var/log/maillog';
}
splunk::inputs::receiver { '9999':
  ssl => true,
}
splunk::inputs::reveiver { '9998': }
