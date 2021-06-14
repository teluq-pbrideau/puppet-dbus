require 'spec_helper'

describe 'dbus' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('dbus') }
      it { is_expected.to contain_class('dbus::config') }
      it { is_expected.to contain_class('dbus::install') }
      it { is_expected.to contain_class('dbus::reload') }
      it { is_expected.to contain_class('dbus::service') }
      it { is_expected.to contain_exec('dbus-send --system --type=method_call --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig') }
      it { is_expected.to contain_file('/etc/dbus-1') }
      it { is_expected.to contain_file('/etc/dbus-1/session.d') }
      it { is_expected.to contain_file('/etc/dbus-1/session-local.conf') }
      it { is_expected.to contain_file('/etc/dbus-1/system.d') }
      it { is_expected.to contain_file('/etc/dbus-1/system-local.conf') }
      it { is_expected.to contain_package('dbus') }

      if facts[:os]['family'].eql?('RedHat') || (facts[:os]['name'].eql?('Debian') && facts[:os]['release']['major'].eql?('8'))
        it { is_expected.to contain_file('/etc/dbus-1/session.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/dbus-1/system.conf').with_ensure('file') }
      else
        it { is_expected.to contain_file('/etc/dbus-1/session.conf').with_ensure('absent') }
        it { is_expected.to contain_file('/etc/dbus-1/system.conf').with_ensure('absent') }
      end

      if facts[:os]['family'].eql?('OpenBSD') || (facts[:os]['family'].eql?('RedHat') && facts[:os]['release']['major'].eql?('6'))
        it { is_expected.to contain_service('messagebus') }
      else
        it { is_expected.to contain_service('dbus') }
      end
    end
  end
end
