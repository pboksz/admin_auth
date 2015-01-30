class Admin::PasswordEncryptor
  require 'bcrypt'

  def encrypt_password(password)
    create_encrypted_password(password)
  end

  def compare_passwords?(password, encrypted_password)
    salt = encrypted_salt(encrypted_password)
    hashed_password = encrypted_password(password, salt)

    compare_passwords(hashed_password, encrypted_password)
  end

  private

  def create_encrypted_password(password)
    BCrypt::Password.create(password, cost: 10)
  end

  def encrypted_salt(encrypted_password)
    BCrypt::Password.new(encrypted_password).salt
  end

  def encrypted_password(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

  def compare_passwords(hashed_password, encrypted_password)
    Rack::Utils.secure_compare(hashed_password, encrypted_password)
  end
end
