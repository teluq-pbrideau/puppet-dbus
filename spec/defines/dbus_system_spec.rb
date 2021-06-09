require 'spec_helper'

describe 'dbus::system' do
  let(:title) do
    'test'
  end

  let(:params) do
    {
      content: '',
    }
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

      context 'without dbus class included' do
        it { is_expected.to compile.and_raise_error(%r{must include the dbus base class}) }
      end

      context 'with dbus class included' do
        let(:pre_condition) do
          'include ::dbus'
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_dbus__system('test') }
        it { is_expected.to contain_file('/etc/dbus-1/system.d/test.conf') }
      end
    end
  end
end
