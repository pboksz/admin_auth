require 'spec_helper'

describe AdminAuth::Encryptor do
  subject { AdminAuth::Encryptor.new }

  describe '#encrypt_password' do
    let(:password) { double }
    let(:encrypted_password) { double }
    before { expect(BCrypt::Password).to receive(:create).with(password, cost: 10).and_return(encrypted_password) }

    it { expect(subject.encrypt_password(password)).to eq encrypted_password }
  end

  describe '#compare_passwords?' do
    let(:password) { double }
    let(:encrypted_password) { double }
    let(:salt) { double }
    let(:bcrypt) { double(salt: salt) }
    let(:hashed_password) { double }
    before do
      expect(BCrypt::Password).to receive(:new).with(encrypted_password).and_return(bcrypt)
      expect(BCrypt::Engine).to receive(:hash_secret).with(password, salt).and_return(hashed_password)
      expect(Rack::Utils).to receive(:secure_compare).with(hashed_password, encrypted_password).and_return(true)
    end

    it { expect(subject.compare_passwords?(password, encrypted_password)).to eq true }
  end
end
