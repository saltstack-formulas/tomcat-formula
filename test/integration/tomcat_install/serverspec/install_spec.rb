require_relative '../../../kitchen/data/spec_helper'

describe 'tomcat/init.sls' do
  case os[:family]
  when 'debian'
    pkgs_installed = %w(tomcat8 haveged tomcat8-admin)
    pkgs_not_installed = []
    main_config = '/etc/default/tomcat8'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    service = 'tomcat8'
  when 'redhat'
    pkgs_installed = %w(tomcat tomcat-admin-webapps)
    pkgs_not_installed = %w(haveged)
    main_config = '/etc/sysconfig/tomcat'
    cur_date = Time.now.strftime("%Y-%m-%d")
    catalina_logfile = "/var/log/tomcat/catalina.#{cur_date}.log"
    service = 'tomcat'
  when 'arch'
    pkgs_installed = %w(tomcat8 haveged)
    pkgs_not_installed = []
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    catalina_logfile = '/var/log/tomcat/catalina.out'
    service = 'tomcat8'
  when 'ubuntu'
  case os[:release]
    when '14.04'
      pkgs_installed = %w(tomcat7 haveged tomcat7-admin)
      pkgs_not_installed = []
      main_config = '/etc/default/tomcat7'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      service = 'tomcat7'
    when '16.04'
      pkgs_installed = %w(tomcat8 haveged tomcat8-admin)
      pkgs_not_installed = []
      main_config = '/etc/default/tomcat8'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      service = 'tomcat8'
    end
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

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
  end  
end
