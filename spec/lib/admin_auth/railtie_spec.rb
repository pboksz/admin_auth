require 'spec_helper'

describe AdminAuth::Engine do
  subject { AdminAuth::Railtie }

  describe 'initializer added' do
    it { expect(subject.initializers.map(&:name)).to include :admin_auth }
  end
end
