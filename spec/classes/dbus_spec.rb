require 'spec_helper'

describe 'dbus' do
  context 'on unsupported distributions' do
    let(:facts) do
      {
        os: {
          family: 'Unsupported',
        },
      }
    end

    it { is_expected.to compile.and_raise_error(%r{not supported on an Unsupported}) }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(
          {
            # FIXME
            dbus_startup_provider: if facts[:osfamily] == 'RedHat'
                                     if ['5', '6'].include?(facts[:operatingsystemmajrelease])
                                       'init'
                                     else
                                       'systemd'
                                     end
                                   else
                                     'init'
                                   end,
          },
        )
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('dbus') }
      it { is_expected.to contain_class('dbus::config') }
      it { is_expected.to contain_class('dbus::install') }
      it { is_expected.to contain_class('dbus::params') }
      it { is_expected.to contain_class('dbus::reload') }
      it { is_expected.to contain_class('dbus::service') }
      it { is_expected.to contain_exec('dbus-send --system --type=method_call --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig') }
      it { is_expected.to contain_file('/etc/dbus-1') }
      it { is_expected.to contain_file('/etc/dbus-1/session.d') }
      it { is_expected.to contain_file('/etc/dbus-1/session-local.conf') }
      it { is_expected.to contain_file('/etc/dbus-1/system.d') }
      it { is_expected.to contain_file('/etc/dbus-1/system-local.conf') }
      it { is_expected.to contain_package('dbus') }

      # rubocop:disable RepeatedExample
      case facts[:osfamily]
      when 'RedHat'
        case facts[:operatingsystemmajrelease]
        when '5', '6'
          it { is_expected.to contain_service('messagebus').with_enable(true) }
        else
          it { is_expected.to contain_service('dbus').without('enable') }
        end
        it { is_expected.to contain_file('/etc/dbus-1/session.conf') }
        it { is_expected.to contain_file('/etc/dbus-1/system.conf') }
      when 'Debian'
        it { is_expected.to contain_service('dbus').with_enable(true) }
        it { is_expected.to contain_file('/etc/dbus-1/session.conf') }
        it { is_expected.to contain_file('/etc/dbus-1/system.conf') }
      when 'OpenBSD'
        it { is_expected.to contain_service('messagebus').with_enable(true) }
        it { is_expected.to contain_file('/usr/local/share/dbus-1/session.conf') }
        it { is_expected.to contain_file('/usr/local/share/dbus-1/system.conf') }
      end
      # rubocop:enable RepeatedExample
    end
  end
end
