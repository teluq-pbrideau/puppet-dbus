# @!visibility private
class dbus::reload {

  exec { $dbus::service_restart:
    path        => $facts['path'],
    refreshonly => true,
  }
}
