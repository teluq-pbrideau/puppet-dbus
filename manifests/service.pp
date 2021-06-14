# @!visibility private
class dbus::service {

  service { $dbus::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
