# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class ldap(

  $packages = $::osfamily ? {
    RedHat  => [
      'nss-pam-ldapd',
      'nss-util',
      'authconfig',
      'openldap-clients',
    ],
    default   => undef,
  },

  $server         = undef,
  $base_dn        = undef,
  $security       = 'tls',
  $cert_ca        = undef,
  $pam_ldap_secret = '',
) {

  validate_array    ( $packages       )
  validate_string   ( $security       )
  if $cert_ca == undef {
    fail("Parameter 'cert_ca' is required.")
  }
  validate_string   ( $cert_ca        )

  $ldap_conf = hiera_hash('ldap::ldap_conf',{})
  $pam_ldap_conf = hiera_hash('ldap::pam_ldap_conf',{})

  clabs::module::init { $name: }

  # nslcd service
  class { "::${name}::nslcd": require => Class["::${name}::config"] }

  contain "${name}::nslcd"

}

