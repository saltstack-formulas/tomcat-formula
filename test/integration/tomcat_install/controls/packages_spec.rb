# frozen_string_literal: true

control 'Tomcat packages' do
  title 'should be installed'

  # Overide by platform
  packages =
    case platform[:family]
    when 'debian'
      case platform[:release]
      when /^10/
        %w[tomcat9 haveged]
      else
        %w[tomcat8 haveged]
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
