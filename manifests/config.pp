# @!visibility private
class dbus::config {

  file { $dbus::conf_dir:
    ensure => directory,
    owner  => 0,
    group  => 0,
    mode   => '0644',
  }

  $validate_cmd = $dbus::validate ? {
    true    => '/usr/bin/xmllint --noout --valid %',
    default => undef,
  }

  file { $dbus::session_conf:
    ensure       => file,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    content      => template("${module_name}/${facts['os']['family']}/session.conf.erb"),
    validate_cmd => $validate_cmd,
  }

  file { $dbus::local_session_conf:
    ensure => absent,
  }

  file { $dbus::session_dir:
    ensure  => directory,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    recurse => true,
    purge   => $dbus::purge_session_dir,
  }

  file { $dbus::local_system_conf:
    ensure => absent,
  }

  file { $dbus::system_conf:
    ensure       => file,
    owner        => 0,
    group        => 0,
    mode         => '0644',
    content      => template("${module_name}/${facts['os']['family']}/system.conf.erb"),
    validate_cmd => $validate_cmd,
  }

  file { $dbus::system_dir:
    ensure  => directory,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    recurse => true,
    purge   => $dbus::purge_system_dir,
  }
}
