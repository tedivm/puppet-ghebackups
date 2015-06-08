require 'spec_helper'
describe 'ghebackups' do

  context 'with defaults for all parameters' do
    it { should contain_class('ghebackups') }
  end
end
