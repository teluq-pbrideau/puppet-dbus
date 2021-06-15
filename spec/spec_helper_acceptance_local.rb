# frozen_string_literal: true

def dbus_settings_hash
  dbus = {}

  case host_inventory['facter']['os']['family']
  when 'Debian'
    dbus['conf_files_exist'] = host_inventory['facter']['os']['release']['major'].eql?('8') ? true : false
    dbus['group']            = 'root'
    dbus['service']          = 'dbus'
  when 'OpenBSD'
    dbus['conf_files_exist'] = true
    dbus['group']            = 'wheel'
    dbus['service']          = 'messagebus'
  when 'RedHat'
    dbus['conf_files_exist'] = true
    dbus['group']            = 'root'
    dbus['service']          = host_inventory['facter']['os']['release']['major'].eql?('6') ? 'messagebus' : 'dbus'
  else
    raise 'unknown operating system'
  end

  dbus
end
