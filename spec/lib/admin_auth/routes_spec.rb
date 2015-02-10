require 'spec_helper'

describe ActionDispatch::Routing::Mapper do
  let(:set) { double(resources_path_names: []) }
  subject { ActionDispatch::Routing::Mapper.new(set) }

  describe '#admin_auth_routes' do
    it { expect(subject.respond_to?(:admin_auth_routes)).to eq true }
  end
end
