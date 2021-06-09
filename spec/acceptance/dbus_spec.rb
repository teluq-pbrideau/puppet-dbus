require 'spec_helper_acceptance'

describe 'dbus' do
  case fact('osfamily')
  when 'RedHat'
    group        = 'root'
    session_conf = '/etc/dbus-1/session.conf'
    system_conf  = '/etc/dbus-1/system.conf'
    case fact('operatingsystemmajrelease')
    when '5', '6'
      service = 'messagebus'
    else
      service = 'dbus'
    end
  when 'Debian'
    group        = 'root'
    session_conf = '/etc/dbus-1/session.conf'
    system_conf  = '/etc/dbus-1/system.conf'
    service      = 'dbus'
  when 'OpenBSD'
    group        = 'wheel'
    session_conf = '/usr/local/share/dbus-1/session.conf'
    system_conf  = '/usr/local/share/dbus-1/system.conf'
    service      = 'messagebus'
  end

  it 'works with no errors' do
    pp = <<-EOS
      Package {
        source => $::osfamily ? {
          'OpenBSD' => "http://ftp.openbsd.org/pub/OpenBSD/${::operatingsystemrelease}/packages/amd64/",
          default   => undef,
        },
      }

      include ::dbus
    EOS

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe package('dbus') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/dbus-1') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into group }
  end

  describe file(session_conf) do
    it { is_expected.to be_file }
    it { is_expected.to be_mode 644 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into group }
    its(:content) { is_expected.to match(%r{busconfig}) }
  end

  describe file('/etc/dbus-1/session-local.conf') do
    it { is_expected.not_to exist }
  end

  describe file('/etc/dbus-1/session.d') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into group }
  end

  describe file(system_conf) do
    it { is_expected.to be_file }
    it { is_expected.to be_mode 644 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into group }
    its(:content) { is_expected.to match(%r{busconfig}) }
  end

  describe file('/etc/dbus-1/system-local.conf') do
    it { is_expected.not_to exist }
  end

  describe file('/etc/dbus-1/system.d') do
    it { is_expected.to be_directory }
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_grouped_into group }
  end

  describe service(service) do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
