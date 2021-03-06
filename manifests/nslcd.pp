# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class ldap::nslcd (
  $enabled        = true,
  $svc            = 'nslcd',
  $user           = 'nslcd',
  $group          = 'ldap',
) {

  validate_bool     ( $enabled        )
  validate_string   ( $svc            )
  validate_string   ( $user           )
  validate_string   ( $group          )

  $nslcd_conf = hiera_hash('ldap::nslcd_conf',{})

  clabs::module::init { $name: }

}

