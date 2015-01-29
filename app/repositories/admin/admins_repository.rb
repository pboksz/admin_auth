class Admin::AdminsRepository < Admin::DefaultRepository
  EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def initialize
    @klass = Admin
  end

  def new(attributes = {})
    validate_admin_attributes(klass.new, attributes)
  end

  def create(attributes)
    validate_admin_attributes(klass.new, attributes, save: true)
  end

  def update(id, attributes)
    validate_admin_attributes(find(id), attributes, save: true)
  end

  def find_by_email(email)
    klass.where(email: email).first
  end

  def update_login_information(id)
    find(id).touch(:last_sign_in_at)
    klass.increment_counter(:sign_in_count, id)
  end

  def correct_password?(id, password)
    password_encryptor.compare_passwords?(password, find(id).encrypted_password)
  end

  private

  def validate_admin_attributes(admin, attributes, options = {})
    password = attributes.delete(:password)
    password_confirmation = attributes.delete(:password_confirmation)

    validate_email_format(admin, attributes[:email])
    validate_passwords_presence(admin, password, password_confirmation)
    validate_passwords_matching(admin, password, password_confirmation)
    validate_passwords_length(admin, password)

    if admin.errors.empty?
      admin.encrypted_password = password_encryptor.encrypt_password(password)
      admin.assign_attributes(attributes)
      admin.save if options[:save]
    end

    admin
  end

  def validate_email_format(admin, email)
    unless email && email =~ EMAIL_REGEX
      admin.errors[:email] << 'Email must be in the valid format.'
    end
  end

  def validate_passwords_presence(admin, password, password_confirmation)
    unless password.present? && password_confirmation.present?
      error = 'Password and password confirmation cannot be blank.'
      admin.errors[:password] << error
      admin.errors[:password_confirmation] << error
    end
  end

  def validate_passwords_matching(admin, password, password_confirmation)
    unless password && password_confirmation && password == password_confirmation
      error = 'Password confirmation must match password.'
      admin.errors[:password] << error
      admin.errors[:password_confirmation] << error
    end
  end

  def validate_passwords_length(admin, password)
    unless password && password.length >= 8
      admin.errors[:password] << 'Password length must be at least 8 character.'
    end
  end

  def password_encryptor
    @password_encryptor ||= Admin::PasswordEncryptor.new
  end
end
