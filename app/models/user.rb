class User < ActiveRecord::Base
  has_secure_password
  belongs_to :organization
  belongs_to :claim_request

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    admin
  end

  def generate_password_reset_data
    generate_password_reset_token
    # when you don't do self, it will just define a local variable instead
    # we are using the attribute accessor built in with rails
    self.password_reset_requested_at = Time.now
    # save the record in the database
    save
  end

  def missing_organization?
<<<<<<< HEAD
<<<<<<< HEAD
    organization_id.nil?
=======
    organization.nil?
>>>>>>> Update code per the code review comments
=======
    organization_id.nil?
>>>>>>> Fix organization show bug
  end


  def generate_password_reset_token
    # begin/while runs at least once
    begin
      self.password_reset_token = SecureRandom.hex(32)
      # check if something exist in ActiveRecord
    end while User.exists?(password_reset_token: self.password_reset_token)
  end

  def password_reset_expired?
    # returns true if password expired
    # if the requested date is less than 60 minutes go, then it has expired,
    # returns true
    password_reset_requested_at < 60.minutes.ago
  end

  def generate_account_verification_data
    # we will use the same password_reset_token field for the initial account
    # verification
    generate_account_verification_token
    # when you don't do self, it will just define a local variable instead
    # we are using the attribute accessor built in with rails
    self.account_verification_requested_at = Time.now
    # save the record in the database
    save
  end

  def generate_account_verification_token
    # begin/while runs at least once
    begin
      self.account_verification_token = SecureRandom.hex(32)
      # check if something exist in ActiveRecord
    end while User.exists?(account_verification_token: self.account_verification_token)
  end

  def attempt_password_change(old_password, new_password)
    self.errors.add(:password, "Need to enter the correct old password") if !authenticate old_password
    self.errors.add(:password, "Password should be different than old password") if old_password == new_password
    self.errors.add(:password, "Password should not be empty") if new_password.blank?
    # if there are any errrors, return false, otherwise return the value of update
    errors.any? ? false : update(password: new_password)
  end

end
