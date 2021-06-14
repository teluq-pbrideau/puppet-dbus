# Manage per-application session bus configuration.
#
# @example
#   include dbus
#   dbus::session { 'example':
#     content => file('example/example.conf'),
#   }
#
# @param content The contents of the file.
# @param application Used to construct the filename.
#
# @see puppet_classes::dbus dbus
define dbus::session (
  String $content,
  String $application = $title,
) {

  include dbus

  $validate_cmd = $dbus::validate ? {
    true    => '/usr/bin/xmllint --noout --valid %',
    default => undef,
  }

  file { "${dbus::session_dir}/${application}.conf":
    ensure       => file,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    content      => $content,
    validate_cmd => $validate_cmd,
    notify       => Class['dbus::reload'],
  }
}
