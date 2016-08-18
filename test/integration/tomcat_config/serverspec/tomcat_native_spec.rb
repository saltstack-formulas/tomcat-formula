require_relative '../../../kitchen/data/spec_helper'

describe 'tomcat/native.sls' do
  case os[:family]
  when 'debian'
    native = 'libtcnative-1'
  when 'redhat'
    native = 'tomcat-native'
  when 'arch'
    native = 'tomcat-native'  
  end

  describe package(native) do
    it { should be_installed }
  end
end
