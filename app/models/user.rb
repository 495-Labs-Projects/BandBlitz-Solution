class User < ApplicationRecord
	has_secure_password

	# Relationships
	belongs_to :band

	# Validations
	validates_presence_of :first_name, :last_name, :email, :password_digest
	validates_uniqueness_of :email, :case_sensitive => false
	validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i, :message => "is not a valid format"

	# Methods
	def proper_name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(email,password)
    find_by_email(email).try(:authenticate, password)
  end

  ROLES = [['Administrator', :admin],['Band Manager', :manager],['Band Member', :member]]
	def role?(authorized_role)
		return false if role.nil?
		role.to_sym == authorized_role
	end

end
