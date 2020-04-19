# frozen_string_literal: true

control 'Tomcat packages' do
  title 'should be installed'

  # Overide by platform
  packages =
    case platform[:family]
    when 'debian'
      %w[tomcat8 haveged]
    when 'redhat', 'fedora', 'suse'
      %w[tomcat]
    end

  packages.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end
end
