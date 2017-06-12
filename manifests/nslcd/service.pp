# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class ldap::nslcd::service inherits ldap::nslcd {

  service {
    $svc:
      enable    => $enabled,
      ensure    => $enabled,
      subscribe => [ Clabs::Config['/etc/openldap/cacerts/cacert.pem'],
                     Clabs::Template['/etc/nslcd.conf'],
                     Clabs::Template['/etc/pam_ldap.conf'],
                     Clabs::Template['/etc/openldap/ldap.conf'],
                     Clabs::Template['/etc/pam_ldap.secret'],
                   ],
  }

}

