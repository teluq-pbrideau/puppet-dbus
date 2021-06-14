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

  $session_file = find_file("${module_name}/${facts['os']['name']}/${facts['os']['release']['major']}/session.conf", "${module_name}/${facts['os']['family']}/${facts['os']['release']['major']}/session.conf")

  if $session_file {
    file { $dbus::session_conf:
      ensure       => file,
      owner        => 0,
      group        => 0,
      mode         => '0644',
      content      => file($session_file),
      validate_cmd => $validate_cmd,
    }
  } else {
    file { $dbus::session_conf:
      ensure => absent,
    }
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

  $system_file = find_file("${module_name}/${facts['os']['name']}/${facts['os']['release']['major']}/system.conf", "${module_name}/${facts['os']['family']}/${facts['os']['release']['major']}/system.conf")

  if $system_file {
    file { $dbus::system_conf:
      ensure       => file,
      owner        => 0,
      group        => 0,
      mode         => '0644',
      content      => file($system_file),
      validate_cmd => $validate_cmd,
    }
  } else {
    file { $dbus::system_conf:
      ensure => absent,
    }
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
