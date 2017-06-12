# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class ldap::config inherits ldap {

  clabs::dir { '/etc/openldap/cacerts':; }

  clabs::config {
    '/etc/openldap/cacerts/cacert.pem':
      content => "${cert_ca}",
      require => Clabs::Dir['/etc/openldap/cacerts'],
      notify  => Exec["${name}-rehash"];
  }

  Exec { path => '/bin:/usr/bin:/usr/sbin', }

  exec {
    "${name}-authconfig":
      command => "authconfig --enableldap --enableldapauth --ldapserver=${server} --enableldaptls --ldapbasedn='${base_dn}' --update",
      onlyif  => "authconfig --test | grep -E '^(nss|pam)_ldap is disabled'",
      notify  => defined(Class['::openssh']) ? {
        true    => Service[$::openssh::svc],
        default => undef,
      };

    "${name}-authconfig_mkhomedir":
      command => "authconfig --enablemkhomedir --update",
      onlyif  => "authconfig --test | grep '^pam_mkhomedir.* is disabled'";

    "${name}-rehash":
      command     => 'cacertdir_rehash /etc/openldap/cacerts/',
      refreshonly => true;
  } 

  clabs::template {
    '/etc/pam_ldap.conf':;
    '/etc/openldap/ldap.conf':;
    '/etc/pam_ldap.secret': mode => '440';
  }

}

