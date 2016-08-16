require_relative '../../../kitchen/data/spec_helper'

describe 'tomcat/config.sls' do
  case os[:family]
  when 'debian'
    ver = '8'
    main_config = '/etc/default/tomcat8'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/java-7-openjdk'
    limits_file = '/etc/security/limits.d/tomcat8.conf'
  when 'redhat'
    ver = '7'
    main_config = '/etc/sysconfig/tomcat'
    service = 'tomcat'
    user = 'tomcat'
    group = 'tomcat'
    java_home = '/usr/lib/jvm/jre'
    limits_file = '/etc/security/limits.d/tomcat7.conf'
  when 'arch'
    ver = '8'
    main_config = '/usr/lib/systemd/system/tomcat8.service'
    service = 'tomcat8'
    user = 'tomcat8'
    group = 'tomcat8'
    java_home = '/usr/lib/jvm/default-runtime'
    limits_file = '/etc/security/limits.conf'
  end

  describe service(service) do
    it { should be_running }
  end

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

  describe file(limits_file) do
    it { should be_file }
    its(:content) { should match(/^#{user} soft nofile 48000/) }
    its(:content) { should match(/^#{user} hard nofile 64000/) }
  end
end
