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
  $bind_dn        = undef,
  $bind_pass      = undef,
  $idle_timelimit = 60,
) {

  validate_array    ( $packages       )
  validate_string   ( $security       )
  validate_string   ( $cert_ca        )
  validate_string   ( $bind_dn        )
  validate_string   ( $bind_pass      )
  validate_integer  ( $idle_timelimit )

  clabs::module::init { $name: }

  # nslcd service
  class { "::${name}::nslcd": require => Class["::${name}::config"] }

  contain "${name}::nslcd"

}

