class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :last_name :password_confirmation, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 8 }


  before_save :cleanup_email

  def cleanup_email
    self.email.downcase!
    self.email.strip!
  end

  def self.authenitcate_with_credentials(email, password)
    email.strip!
    email.downcase!
    User.find_by(email: "#{email}").try(:authenticate, "#{password}")
  end
end
