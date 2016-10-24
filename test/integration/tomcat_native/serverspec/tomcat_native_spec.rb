require_relative '../../../kitchen/data/spec_helper'

describe 'tomcat/native.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/java-7-openjdk'
    limits_file = '/etc/security/limits.d/tomcat8.conf'

    describe command("apt install libxml2-utils") do
      its(:exit_status) { should eq 0 }
    end
  when 'redhat'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/etc/sysconfig/tomcat'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat'
    user = 'tomcat'
    group = 'tomcat'
    java_home = '/usr/lib/jvm/jre'
    limits_file = '/etc/security/limits.d/tomcat7.conf'

    describe command("yum install libxml2") do
      its(:exit_status) { should eq 0 }
    end      
  when 'arch'
    ver = '8'
    pkgs_installed = %w(tomcat-native)
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    web_config = '/etc/tomcat8/web.xml'
    user_config = '/etc/tomcat8/tomcat-users.xml'
    username = 'saltuser1'
    password = 'RfgpE2iQwD'
    roles = 'manager-gui,manager-script,manager-jmx,manager-status'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/default-runtime'
    limits_file = '/etc/security/limits.conf'

    describe command("pacman -S libxml2") do
      its(:exit_status) { should eq 0 }
    end
  end

  pkgs_installed.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  describe service(service) do
    it { should be_running }
  end

  describe file(server_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should contain('<Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />') }

    describe command("xmllint --noout #{server_config}") do
      its(:exit_status) { should eq 0 }
    end           
  end
end