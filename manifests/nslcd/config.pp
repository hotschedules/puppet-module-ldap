# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class ldap::nslcd::config inherits ldap::nslcd {

  clabs::template { '/etc/nslcd.conf': mode => '440'; }

  clabs::config { '/etc/nsswitch.conf':
    notify => Service[$svc];
  }

}

