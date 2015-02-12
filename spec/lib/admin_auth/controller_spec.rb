require 'spec_helper'

describe AdminAuth::Controller do
  class Controller < ActionController::Base
    include AdminAuth::Controller
  end

  subject { Controller.new }

  let(:params) { {} }
  before do
    subject.params = params
  end

  describe '#authenticate_admin!' do
    describe 'current admin present' do
      before do
        expect(subject).to receive(:current_admin).and_return(double)
        expect(subject).to receive(:redirect_to).never
      end

      it { expect(subject.authenticate_admin!) }
    end

    describe 'current admin nil' do
      let(:admin_login_path) { 'admin/login' }
      before do
        expect(subject).to receive(:current_admin).and_return(nil)
        expect(subject).to receive(:admin_login_path).and_return(admin_login_path)
        expect(subject).to receive(:redirect_to).with(admin_login_path)
      end

      it { expect(subject.authenticate_admin!) }
    end
  end

  describe '#current_admin' do
    describe 'session has admin id' do
      let(:admin) { double(id: 1) }
      let(:admins_repository) { double }
      before do
        allow(subject).to receive(:session).and_return({ admin_id: admin.id })
        expect(subject).to receive(:admins_repository).and_return(admins_repository)
        expect(admins_repository).to receive(:find).with(id: admin.id).and_return(admin)
      end

      it { expect(subject.current_admin).to eq admin }
    end

    describe 'session does not have admin id' do
      before { allow(subject).to receive(:session).and_return({}) }
      it { expect(subject.current_admin).to be_nil }
    end
  end

  describe '#locale' do
    describe 'no locale in params' do
      it { expect(subject.locale).to be_nil }
    end

    describe 'locale in params' do
      let(:params) { { locale: :en } }
      it { expect(subject.locale).to eq :en }
    end
  end

  describe '#after_login_path' do
    describe 'no locale in params' do
      before { expect(subject).to receive(:admin_admins_path).with(nil) }
      it { subject.after_login_path }
    end

    describe 'locale in params' do
      let(:params) { { locale: :en } }

      describe 'no locale passed' do
        before { expect(subject).to receive(:admin_admins_path).with(:en) }
        it { subject.after_login_path }
      end

      describe 'locale passed' do
        before { expect(subject).to receive(:admin_admins_path).with(:pl) }
        it { subject.after_login_path(:pl) }
      end
    end
  end

  describe '#after_logout_path' do
    before { subject.params = { locale: :en } }

    describe 'no locale passed' do
      before { expect(subject).to receive(:admin_root_path).with(:en) }
      it { subject.after_logout_path }
    end

    describe 'locale passed' do
      before { expect(subject).to receive(:admin_root_path).with(:pl) }
      it { subject.after_logout_path(:pl) }
    end
  end
end