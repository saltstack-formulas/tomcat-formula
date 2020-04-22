# frozen_string_literal: true

# Prepare platform "finger"
platform_finger = "#{platform[:name]}-#{platform[:release].split('.')[0]}"

control 'Tomcat packages' do
  title 'should be installed'

  # Overide by platform
  packages =
    case platform[:family]
    when 'debian'
      case platform_finger
      when 'debian-10'
        %w[tomcat9 haveged]
      when 'debian-9', 'ubuntu-18', 'ubuntu-16'
        %w[tomcat8 haveged]
      when 'debian-8'
        %w[tomcat7 haveged]
      end
    when 'redhat', 'fedora', 'suse'
      %w[tomcat]
    end

  packages.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end
end
