class splunk::params {
  $no_repo_provider = $operatingsystem ? {
    /ubuntu|debian/        => 'dpkg',
    /centos|fedora|redhat/ => 'rpm',
  }
  $repo_provider = $operatingsystem ? {
    /ubuntu|debian/        => 'apt',
    /centos|fedora|redhat/ => 'yum',
  }
  $pkg_file = $operatingsystem ? {
    /ubuntu|debian/        => $hardwaremodel ? {
      'x86_64' => 'splunk-4.1.7-95063-linux-2.6-amd64.deb',
      default  => 'splunk-4.1.7-95063-linux-2.6-intel.deb',
    }
    /centos|fedora|redhat/ => $hardwaremodel ? {
      'x86_64' => 'splunk-4.1.7-95063-linux-2.6-x86_64.rpm',
      default  => 'splunk-4.1.7-95063.i386.rpm',
    }
  }
}
