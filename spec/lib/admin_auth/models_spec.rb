require 'spec_helper'

describe AdminAuth::Models do
  class Admin
    include ActiveModel::Model
    include AdminAuth::Models

    attr_accessor :email, :encrypted_password
  end

  let(:email) { 'email@email.com' }
  let(:password) { '12345678' }
  let(:password_confirmation) { password }
  let(:attributes) { { email: email, password: password, password_confirmation: password_confirmation } }
  subject { Admin.new(attributes) }

  describe 'validations' do
    describe 'email format' do
      describe 'blank' do
        let(:email) { '' }
        it { expect(subject).not_to be_valid }
      end

      describe 'just a string' do
        let(:email) { 'email' }
        it { expect(subject).not_to be_valid }
      end

      describe 'missing domain' do
        let(:email) { 'email@email' }
        it { expect(subject).not_to be_valid }
      end

      describe 'full email' do
        let(:email) { 'email@email.com' }
        it { expect(subject).to be_valid  }
      end
    end

    describe 'password length' do
      describe 'blank' do
        let(:password) { '' }
        it { expect(subject).not_to be_valid }
      end

      describe 'too short' do
        let(:password) { '1234' }
        it { expect(subject).not_to be_valid }
      end

      describe 'a least 8 characters' do
        let(:password) { '12345678' }
        it { expect(subject).to be_valid }
      end
    end

    describe 'password confirmation length' do
      describe 'blank' do
        let(:password_confirmation) { '' }
        it { expect(subject).not_to be_valid }
      end

      describe 'too short' do
        let(:password_confirmation) { '1234' }
        it { expect(subject).not_to be_valid }
      end

      describe 'a least 8 characters' do
        let(:password_confirmation) { '12345678' }
        it { expect(subject).to be_valid }
      end
    end

    describe 'passwords must match' do
      describe 'they match' do
        it { expect(subject).to be_valid }
      end

      describe 'they do not match' do
        let(:password_confirmation) { 'invalid' }
        it { expect(subject).not_to be_valid }
      end

      describe 'clears passwords after check' do
        before { subject.valid? }
        it { expect(subject.password).to be_nil }
        it { expect(subject.password_confirmation).to be_nil }
      end
    end
  end

  describe 'instance methods' do
    let(:password_encryptor) { double }
    let(:encrypted_password) { double }

    describe '#password' do
      it { expect(subject.password).to eq password }
    end

    describe '#password=' do
      before do
        allow(AdminAuth::Encryptor).to receive(:new).and_return(password_encryptor)
        expect(password_encryptor).to receive(:encrypt_password).with(password).and_return(encrypted_password)
      end

      it { expect(subject.password).to eq password }
      it { expect(subject.encrypted_password).to eq encrypted_password }
    end

    describe '#password_confirmation' do
      it { expect(subject.password_confirmation).to eq password }
    end

    describe '#password_confirmation=' do
      before { subject.password_confirmation = password }
      it { expect(subject.password_confirmation).to eq password }
    end

    describe '#correct_password?' do
      before do
        allow(AdminAuth::Encryptor).to receive(:new).and_return(password_encryptor)
        expect(password_encryptor).to receive(:encrypt_password).with(password).and_return(encrypted_password)
        expect(password_encryptor).to receive(:compare_passwords?).with(password, encrypted_password).and_return(true)
      end

      it { expect(subject.correct_password?(password)).to eq true }
    end
  end
end
