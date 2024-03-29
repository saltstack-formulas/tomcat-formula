# frozen_string_literal: true

# Strip the `platform[:finger]` version number down to the "OS major release"
platform_finger = system.platform[:finger].split('.').first.to_s

# Default values for `control 'Tomcat main config'`
main_config_file = '/etc/sysconfig/tomcat'
# Default values for `control 'Tomcat Catalina temp dir'`
catalina_tmpdir = '/var/cache/tomcat/temp'
catalina_tmpdir_user_and_group = 'tomcat'
catalina_tmpdir_mode = '0755'
# Default values for `control 'Tomcat `server.xml` config'`
conf_dir = '/etc/tomcat'
server_xml_user_and_group = 'tomcat'
python3_pkg = 'python3'

# Override by platform
case platform[:family]
when 'debian'
  main_config_file = '/etc/default/tomcat8'
  catalina_tmpdir = '/var/cache/tomcat8/temp'
  catalina_tmpdir_user_and_group = 'tomcat8'
  conf_dir = '/etc/tomcat8'
  server_xml_user_and_group = 'tomcat8'
  case platform_finger
  when 'debian-11', 'debian-10', 'ubuntu-22', 'ubuntu-20', 'ubuntu-18'
    main_config_file = '/etc/default/tomcat9'
    catalina_tmpdir = '/var/cache/tomcat9/temp'
    catalina_tmpdir_user_and_group = 'tomcat'
    conf_dir = '/etc/tomcat9'
    server_xml_user_and_group = 'tomcat'
  when 'debian-9'
  when 'debian-8'
    main_config_file = '/etc/default/tomcat7'
    catalina_tmpdir = '/var/cache/tomcat7/temp'
    catalina_tmpdir_user_and_group = 'tomcat7'
    conf_dir = '/etc/tomcat7'
    server_xml_user_and_group = 'tomcat7'
  when 'ubuntu-16'
  end
when 'redhat'
  case platform_finger
  when 'centos-8', 'oraclelinux-8'
    python3_pkg = 'python36'
  when 'centos-7', 'oraclelinux-7'
  when 'centos-6'
  when 'amazon-2'
  when 'amazon-2018'
  end
when 'fedora'
  case platform_finger
  when 'fedora-33'
  when 'fedora-32'
  when 'fedora-31'
  when 'fedora-30'
  end
when 'suse'
  server_xml_user_and_group = 'root'
  case platform_finger
  when 'opensuse-15'
  when 'opensuse-tumbleweed'
    python3_pkg = 'python38-base'
  end
when 'linux'
  case platform_finger
  when 'arch-base-latest'
    main_config_file = '/usr/lib/systemd/system/tomcat8.service'
    catalina_tmpdir = '/var/tmp/tomcat8/temp'
    catalina_tmpdir_user_and_group = 'tomcat8'
    catalina_tmpdir_mode = '0775'
    conf_dir = '/etc/tomcat8'
    server_xml_user_and_group = 'tomcat8'
    python3_pkg = 'python'
  end
end

control 'Tomcat main config' do
  title 'should contain the lines'

  # Prepare comparison file
  main_config_path = "main_config/#{platform_finger}"
  main_config = inspec.profile.file(main_config_path)

  describe file(main_config_file) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should include main_config }
  end
end

control 'Tomcat Catalina temp dir' do
  title 'should be prepared with the settings'

  describe file(catalina_tmpdir) do
    it { should be_directory }
    it { should be_owned_by catalina_tmpdir_user_and_group }
    it { should be_grouped_into catalina_tmpdir_user_and_group }
    its('mode') { should cmp catalina_tmpdir_mode }
  end
end

control 'Tomcat `server.xml` config' do
  title 'should contain the lines'

  only_if(
    'Disabled where Python < 3.6 due to data ordering not being maintained ' \
    'for dicts when looping over `.items()`'
  ) do
    Gem::Version.new(package(python3_pkg).version.gsub('~',
                                                       '-')) >= Gem::Version.new('3.6')
  end

  server_xml_file = "#{conf_dir}/server.xml"
  server_xml_path = "server_xml/#{platform_finger}.xml"
  server_xml = inspec.profile.file(server_xml_path)

  describe file(server_xml_file) do
    it { should be_file }
    it { should be_owned_by server_xml_user_and_group }
    it { should be_grouped_into server_xml_user_and_group }
    its('mode') { should cmp '0644' }
    unless %w[debian-9].include?(platform_finger)
      its('content') { should include server_xml }
    end
  end
end
