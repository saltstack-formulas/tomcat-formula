# frozen_string_literal: true

control 'Tomcat services' do
  impact 0.5
  title 'should be installed, enabled and running'

  # Overide by platform
  services =
    case platform[:family]
    when 'debian'
      %w[tomcat8 haveged]
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
