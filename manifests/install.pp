# @!visibility private
class dbus::install {

  package { $dbus::package_name:
    ensure => present,
  }
}
