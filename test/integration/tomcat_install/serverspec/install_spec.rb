require_relative '../../../kitchen/data/spec_helper'

describe 'tomcat/init.sls' do
  case os[:family]
  when 'debian'
    pkgs_installed = %w(tomcat8 haveged tomcat8-admin libtcnative-1)
    pkgs_not_installed = []
    main_config = '/etc/default/tomcat8'
    service = 'tomcat8'
  when 'redhat'
    pkgs_installed = %w(tomcat tomcat-admin-webapps tomcat-native)
    pkgs_not_installed = %w(haveged)
    main_config = '/etc/sysconfig/tomcat'
    service = 'tomcat'
  when 'arch'
    pkgs_installed = %w(tomcat8 haveged tomcat-native)
    pkgs_not_installed = []
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    service = 'tomcat8'
  end

  pkgs_installed.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  pkgs_not_installed.each do |p|
    describe package(p) do
      it { should_not be_installed }
    end
  end
  describe service(service) do
    it { should be_running }
  end

  describe file(main_config) do
    it { should be_file }
    its(:content) { should_not match('# This file is managed by salt.') }
  end
end
