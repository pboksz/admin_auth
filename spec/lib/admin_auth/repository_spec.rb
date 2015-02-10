require 'spec_helper'

describe AdminAuth::Repository do
  class Admin; end

  let(:admin) { double(id: 1) }
  let(:admins) { [admin] }
  let(:attributes) { { id: admin.id } }
  subject { AdminAuth::Repository.new }

  describe '#all' do
    before { expect(Admin).to receive(:all).and_return(admins) }
    it { expect(subject.all).to eq admins }
  end

  describe '#new' do
    describe 'no attributes' do
      before { expect(Admin).to receive(:new).with({}).and_return(admin) }
      it { expect(subject.new).to eq admin }
    end

    describe 'with attributes' do
      before { expect(Admin).to receive(:new).with(attributes).and_return(admin) }
      it { expect(subject.new(attributes)).to eq admin }
    end
  end

  describe '#create' do
    before { expect(Admin).to receive(:create).with(attributes).and_return(admin) }
    it { expect(subject.create(attributes)).to eq admin }
  end

  describe '#find' do
    before { expect(Admin).to receive(:where).with(attributes).and_return([admin]) }
    it { expect(subject.find(attributes)).to eq admin }
  end

  describe '#update' do
    before do
      expect(subject).to receive(:find).with(id: admin.id).and_return(admin)
      expect(admin).to receive(:update_attributes).with(attributes)
    end

    it { expect(subject.update(admin.id, attributes)).to eq admin }
  end

  describe '#destroy' do
    before do
      expect(subject).to receive(:find).with(id: admin.id).and_return(admin)
      expect(admin).to receive(:destroy).and_return(admin)
    end

    it { expect(subject.destroy(admin.id)).to eq admin }
  end
end
