# frozen_string_literal: true

control 'Tomcat packages' do
  title 'should be installed'

  # Strip the `platform[:finger]` version number down to the "OS major release"
  platform_finger = system.platform[:finger].split('.').first.to_s

  # Overide by platform
  packages =
    case platform[:family]
    when 'debian'
      case platform_finger
      when 'debian-11', 'debian-10', 'ubuntu-22', 'ubuntu-20', 'ubuntu-18'
        %w[tomcat9 haveged]
      when 'debian-9', 'ubuntu-16'
        %w[tomcat8 haveged]
      when 'debian-8'
        %w[tomcat7 haveged]
      end
    when 'redhat', 'fedora', 'suse'
      %w[tomcat]
    when 'linux'
      case platform_finger
      when 'arch-base-latest'
        %w[tomcat8]
      end
    end

  packages.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end
end
