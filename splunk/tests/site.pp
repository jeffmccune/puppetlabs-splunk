class { 'splunk::users':
  virtual => false
}

class { 'splunk::package': }

class { 'splunk::service': }

class { 'splunk': }
class { 'splunk::app': }
class { 'splunk::inputs': }
splunk::inputs::target { 'messages':
    target => '/var/log/messages',
}
splunk::inputs::target { 'maillog':
    target => '/var/log/maillog';
}
splunk::inputs::reciever { '9999':
  receiver => true,
}
