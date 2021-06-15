require 'spec_helper_acceptance'

dbus_hash = dbus_settings_hash

describe 'dbus' do
  let(:pp) do
    <<-MANIFEST
      include dbus
    MANIFEST
  end

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe package('dbus') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/dbus-1') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into dbus_hash['group'] }
  end

  describe file('/etc/dbus-1/session.conf'), if: dbus_hash['conf_files_exist'] do
    it { is_expected.to be_file }
    it { is_expected.to be_mode 644 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into dbus_hash['group'] }
    its(:content) { is_expected.to match(%r{busconfig}) }
  end

  describe file('/etc/dbus-1/session.conf'), unless: dbus_hash['conf_files_exist'] do
    it { is_expected.not_to exist }
  end

  describe file('/etc/dbus-1/session.d') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into dbus_hash['group'] }
  end

  describe file('/etc/dbus-1/session-local.conf') do
    it { is_expected.not_to exist }
  end

  describe file('/etc/dbus-1/system.conf'), if: dbus_hash['conf_files_exist'] do
    it { is_expected.to be_file }
    it { is_expected.to be_mode 644 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into dbus_hash['group'] }
    its(:content) { is_expected.to match(%r{busconfig}) }
  end

  describe file('/etc/dbus-1/system.conf'), unless: dbus_hash['conf_files_exist'] do
    it { is_expected.not_to exist }
  end

  describe file('/etc/dbus-1/system.d') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into dbus_hash['group'] }
  end

  describe file('/etc/dbus-1/system-local.conf') do
    it { is_expected.not_to exist }
  end

  describe service(dbus_hash['service']) do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
