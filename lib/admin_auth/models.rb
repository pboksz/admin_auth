module AdminAuth
  module Models
    extend ActiveSupport::Concern

    EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    PASSWORD_MINIMUM = 8

    included do
      validates :email, format: { with: EMAIL_REGEX }
      validates :password, :password_confirmation, length: { minimum: PASSWORD_MINIMUM }
      validate :passwords_must_match

      before_save :cleanup_passwords
    end

    def password
      @password
    end

    def password=(password)
      @password = password
      self.encrypted_password = password_encryptor.encrypt_password(password)
    end

    def password_confirmation
      @password_confirmation
    end

    def password_confirmation=(password)
      @password_confirmation = password
    end

    def correct_password?(password)
      password_encryptor.compare_passwords?(password, encrypted_password)
    end

    private

    def cleanup_passwords
      @password = @password_confirmation = nil
    end

    def passwords_must_match
      unless @password == @password_confirmation
        error = 'must match'
        errors[:password] << error
        errors[:password_confirmation] << error
      end
    end

    def password_encryptor
      @password_encryptor ||= Admin::PasswordEncryptor.new
    end
  end
end
