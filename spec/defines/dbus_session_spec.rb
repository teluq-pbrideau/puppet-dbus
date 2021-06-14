require 'spec_helper'

describe 'dbus::session' do
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
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_dbus__session('test') }
      it { is_expected.to contain_file('/etc/dbus-1/session.d/test.conf') }
    end
  end
end
