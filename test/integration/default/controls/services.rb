# frozen_string_literal: true

control 'Tomcat services' do
  impact 0.5
  title 'should be installed, enabled and running'

  # Strip the `platform[:finger]` version number down to the "OS major release"
  platform_finger = system.platform[:finger].split('.').first.to_s

  # Overide by platform
  services =
    case platform[:family]
    when 'debian'
      case platform_finger
      when 'debian-10', 'ubuntu-20'
        %w[tomcat9 haveged]
      when 'debian-9', 'ubuntu-18', 'ubuntu-16'
        %w[tomcat8 haveged]
      when 'debian-8'
        %w[tomcat7 haveged]
      end
    when 'redhat', 'fedora', 'suse'
      %w[tomcat]
    end

  services.each do |s|
    describe service(s) do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running } unless %w[haveged].include?(s)
    end
  end
end
