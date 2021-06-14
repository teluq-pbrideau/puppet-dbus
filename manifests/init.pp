# Installs and manages D-Bus.
#
# @example Declaring the class
#   include dbus
#
# @param conf_dir Top-level configuration directory, usually `/etc/dbus-1`.
# @param local_session_conf The configuration file used to override the default
#   session bus configuration, usually `/etc/dbus-1/session-local.conf`.
# @param local_system_conf The configuration file used to override the default
#   system bus configuration, usually `/etc/dbus-1/system-local.conf`.
# @param package_name The name of the package.
# @param purge_session_dir Whether to purge any unmanaged session bus
#   configuration files.
# @param purge_system_dir Whether to purge any unmanaged system bus
#   configuration files.
# @param service_name The name of the service.
# @param service_restart The command used to get `dbus-daemon` to reload its
#   configuration, which is usually `dbus-send --system --type=method_call
#   --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig`. On
#   platforms that use systemd, this is what the unit does anyway and so will
#   rely on that where possible.
# @param session_conf The configuration file containing the default session bus
#   configuration, usually `/etc/dbus-1/session.conf`.
# @param session_dir The directory used by applications to add additional
#   session bus configuration, usually `/etc/dbus-1/session.d`.
# @param system_conf The configuration file containing the default system bus
#   configuration, usually `/etc/dbus-1/system.conf`.
# @param system_dir The directory used by applications to add additional system
#   bus configuration, usually `/etc/dbus-1/system.d`.
# @param validate Whether to validate the XML configuration files prior to
#   installing them.
#
# @see puppet_defined_types::dbus::session dbus::session
# @see puppet_defined_types::dbus::system dbus::system
class dbus (
  Stdlib::Absolutepath $conf_dir,
  Stdlib::Absolutepath $local_session_conf,
  Stdlib::Absolutepath $local_system_conf,
  String               $package_name,
  Boolean              $purge_session_dir,
  Boolean              $purge_system_dir,
  String               $service_name,
  String               $service_restart,
  Stdlib::Absolutepath $session_conf,
  Stdlib::Absolutepath $session_dir,
  Stdlib::Absolutepath $system_conf,
  Stdlib::Absolutepath $system_dir,
  Boolean              $validate,
) {

  contain dbus::install
  contain dbus::config
  contain dbus::service
  contain dbus::reload

  Class['dbus::install'] -> Class['dbus::service'] -> Class['dbus::reload']
  Class['dbus::install'] -> Class['dbus::config'] ~> Class['dbus::reload']
}
