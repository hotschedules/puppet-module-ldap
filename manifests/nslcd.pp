# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class ldap::nslcd (
  $enabled        = true,
  $svc            = 'nslcd',
  $user           = 'nslcd',
  $group          = 'ldap',
  $server         = $::ldap::server,
  $base_dn        = $::ldap::base_dn,
  $bind_dn        = $::ldap::bind_dn,
  $bind_pass      = $::ldap::bind_pass,
  $idle_timelimit = $::ldap::idle_timelimit,
  $people_dn      = "ou=People,${::ldap::base_dn}",
) {

  validate_bool     ( $enabled        )
  validate_string   ( $svc            )
  validate_string   ( $user           )
  validate_string   ( $group          )
  validate_string   ( $base_dn        )
  validate_string   ( $server         )
  validate_string   ( $bind_dn        )
  validate_string   ( $bind_pass      )
  validate_integer  ( $idle_timelimit )
  validate_string   ( $people_dn      )

  clabs::module::init { $name: }

}

