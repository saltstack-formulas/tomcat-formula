require_relative '../../../shared/spec_helper.rb'

describe 'tomcat/init.sls' do
  case os[:family]
  when 'debian'
    pkgs_installed = %w(tomcat8 haveged tomcat8-admin)
    pkgs_not_installed = []
    main_config = '/etc/default/tomcat8'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
    service = 'tomcat8'
    service_running: False
  when 'redhat'
    pkgs_installed = %w(tomcat tomcat-admin-webapps)
    pkgs_not_installed = %w(haveged)
    main_config = '/etc/sysconfig/tomcat'
    cur_date = Time.now.strftime("%Y-%m-%d")
    catalina_logfile = "/var/log/tomcat/catalina.#{cur_date}.log"
    service = 'tomcat'
    service_running: False
  when 'arch'
    pkgs_installed = %w(tomcat8 haveged)
    pkgs_not_installed = []
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    catalina_logfile = '/var/log/tomcat/catalina.out'
    service = 'tomcat8'
    service_running: False
  when 'ubuntu'
  case os[:release]
    when '14.04'
      pkgs_installed = %w(tomcat7 haveged tomcat7-admin)
      pkgs_not_installed = []
      main_config = '/etc/default/tomcat7'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      service = 'tomcat7'
      service_running: False
    when '16.04'
      pkgs_installed = %w(tomcat8 haveged tomcat8-admin)
      pkgs_not_installed = []
      main_config = '/etc/default/tomcat8'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      service = 'tomcat8'
      service_running: False
    when '18.04'
      pkgs_installed = %w(tomcat8 haveged tomcat8-admin)
      pkgs_not_installed = []
      main_config = '/etc/default/tomcat8'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
      service = 'tomcat'
      service_running: False
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
  #skip service check because tomcat needs java
  #describe service(service) do
  # it { should be_running }
  #nd

  describe file(main_config) do
    it { should be_file }
    its(:content) { should_not match('# This file is managed by salt.') }
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
  end  
end

describe 'tomcat/native.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
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
    catalina_logfile = '/var/log/tomcat8/catalina.out'
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
    catalina_logfile = '/var/log/tomcat/catalina.out'
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
  when 'ubuntu'
    case os[:release]
    when '14.04'
      ver = '7'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat7'
      server_config = '/etc/tomcat7/server.xml'
      context_config = '/etc/tomcat7/context.xml'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      web_config = '/etc/tomcat7/web.xml'
      user_config = '/etc/tomcat7/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat7'
      user = 'tomcat7'
      group = 'tomcat7'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat7.conf'

      describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    when '16.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
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
    when '18.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
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
    end
  end

  pkgs_installed.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  #skip service check because tomcat needs java
  #describe service(service) do
  #  it { should be_running }
  #end

  describe file(server_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should contain('<Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />') }

    describe command("xmllint --noout #{server_config}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
  end
end

describe 'tomcat/config.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    pkgs_installed = %w(libtcnative-1)
    main_config = '/etc/default/tomcat8'
    server_config = '/etc/tomcat8/server.xml'
    context_config = '/etc/tomcat8/context.xml'
    catalina_logfile = '/var/log/tomcat8/catalina.out'
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
    catalina_logfile = '/var/log/tomcat8/catalina.out'
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
    catalina_logfile = '/var/log/tomcat/catalina.out'
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
  when 'ubuntu'
    case os[:release]
    when '14.04'
      ver = '7'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat7'
      server_config = '/etc/tomcat7/server.xml'
      context_config = '/etc/tomcat7/context.xml'
      catalina_logfile = '/var/log/tomcat7/catalina.out'
      web_config = '/etc/tomcat7/web.xml'
      user_config = '/etc/tomcat7/tomcat-users.xml'
      username = 'saltuser1'
      password = 'RfgpE2iQwD'
      roles = 'manager-gui,manager-script,manager-jmx,manager-status'
      service = 'tomcat7'
      user = 'tomcat7'
      group = 'tomcat7'
      java_home = '/usr/lib/jvm/java-7-openjdk'
      limits_file = '/etc/security/limits.d/tomcat7.conf'

      describe command("apt install libxml2-utils") do
        its(:exit_status) { should eq 0 }
      end
    when '16.04'
      ver = '8'
      pkgs_installed = %w(libtcnative-1)
      main_config = '/etc/default/tomcat8'
      server_config = '/etc/tomcat8/server.xml'
      context_config = '/etc/tomcat8/context.xml'
      catalina_logfile = '/var/log/tomcat8/catalina.out'
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
    end
  end
  pkgs_installed.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  #skip service check because tomcat needs java
  #describe service(service) do
  #  it { should be_running }
  #end

  describe file(main_config) do
    it { should be_file }
    its(:content) { should match('# This file is managed by salt.') }
    case os[:family]
    when 'debian', 'redhat'
      its(:content) { should match(/^TOMCAT.?_USER=#{user}/) }
      its(:content) { should match(/^TOMCAT.?_GROUP=#{group}/) }
      its(:content) { should match(/^JAVA_OPTS=\"-Djava\.awt\.headless=true -Xmx128m -XX:MaxPermSize=256m -XX:\+UseConcMarkSweepGC -XX:\+CMSIncrementalMode -Dlog4j\.configuration=file:\/path\/to\/log4j.properties -Dlogback.configurationFile=\/path\/to\/logback.xml\"/) }
    when 'arch'
      its(:content) { should match(/^Environment=TOMCAT_JAVA_HOME=#{java_home}/) }
      its(:content) { should match(/^Environment=\"CATALINA_OPTS=-Djava\.awt\.headless=true -Xmx128m -XX:MaxPermSize=256m -XX:\+UseConcMarkSweepGC -XX:\+CMSIncrementalMode -Dlog4j\.configuration=file:\/path\/to\/log4j.properties -Dlogback.configurationFile=\/path\/to\/logback.xml\"/) }
      its(:content) { should_not match(/^TOMCAT.?_GROUP=#{group}/) }
    end
  end

  describe file(server_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should contain('port="8080"') }
    its(:content) { should contain('protocol="HTTP/1.1"') }
    its(:content) { should contain('connectionTimeout="20000"') }
    its(:content) { should contain('URIEncoding="UTF-8"') }

    describe command("xmllint --noout #{server_config}") do
      its(:exit_status) { should eq 0 }
    end           
  end

  describe file(web_config) do
    it { should be_file }
    its(:content) { should contain('This file is managed/autogenerated by salt.') }
    its(:content) { should contain('<filter-name>ExpiresFilter</filter-name>') }
    its(:content) { should contain('2 weeks') }
    describe command("xmllint --noout #{web_config}") do
      its(:exit_status) { should eq 0 }
    end
  end  

  describe file(limits_file) do
    it { should be_file }
    its(:content) { should match(/^#{user} soft nofile 48000/) }
    its(:content) { should match(/^#{user} hard nofile 64000/) }
  end

  describe file(catalina_logfile) do
    it { should be_file }
    its(:content) { should contain('INFO: Server startup in') }
  end    
end
