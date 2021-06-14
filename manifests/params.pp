# @!visibility private
class dbus::params {

  $conf_dir           = '/etc/dbus-1'
  $local_session_conf = "${conf_dir}/session-local.conf"
  $local_system_conf  = "${conf_dir}/system-local.conf"
  $package_name       = 'dbus'
  $purge_session_dir  = false
  $purge_system_dir   = false
  $service_restart    = 'dbus-send --system --type=method_call --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig'
  $session_dir        = "${conf_dir}/session.d"
  $system_dir         = "${conf_dir}/system.d"
  $validate           = false # xmllint currently can't fetch a DTD over HTTPS

  case $facts['os']['family'] {
    'RedHat': {
      case $facts['os']['release']['major'] {
        '6': {
          $service_name = 'messagebus'
        }
        default: {
          $service_name = 'dbus'
        }
      }
      $session_conf = "${conf_dir}/session.conf"
      $system_conf  = "${conf_dir}/system.conf"
    }
    'Debian': {
      $service_name = 'dbus'
      $session_conf = "${conf_dir}/session.conf"
      $system_conf  = "${conf_dir}/system.conf"
    }
    'OpenBSD': {
      $service_name = 'messagebus'
      $session_conf = '/usr/local/share/dbus-1/session.conf'
      $system_conf  = '/usr/local/share/dbus-1/system.conf'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${facts['os']['family']} based system.")
    }
  }

  case $facts['service_provider'] {
    'systemd': {
      $service_enable = undef
    }
    default: {
      $service_enable = true
    }
  }
}
