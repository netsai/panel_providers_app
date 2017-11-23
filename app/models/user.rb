require "digest/sha1"

class User < ActiveRecord::Base
  attr_accessor :password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_presence_of :username, :on => :create
  validates_uniqueness_of :email
  validates_uniqueness_of :username

  before_save :encrypt_password

  # def initialize(attributes = {})
  #   #super # must allow the active record to initialize!
  #   attributes.each do |name, value|
  #     send("#{name}=", value)
  #   end
  # end

  def self.authenticate_by_email(email, password)
    pwd = Digest::SHA1.hexdigest(password.to_s)
    user = User.find_by_login_and_hashed_password(email, pwd)
    if user
      user
    else
      nil
    end
  end

  def self.authenticate_by_username(username, password)
    pwd = Digest::SHA1.hexdigest(password.to_s)
    user = User.find_by_username_and_hashed_password(username, pwd)
    if user
      user
    else
      nil
    end
  end


  private
  def encrypt_password
    unless self.password.blank?
      self.hashed_password = Digest::SHA1.hexdigest(self.password.to_s)
      self.password = nil
    end
    return true
  end



  #---------------------------------------------------------------------------------------------------

  # def self.authenticate(email, password)
  #   user = find_by_email(email)
  #   hashed_password = hash_password(password || "")
  #
  #   if user && user.password == hashed_password
  #     user
  #   else
  #     nil
  #   end
  # end
  #
  # def self.authenticate_by_email(email, password)
  #   user = find_by_email(email)
  #   if user && user.password == hash_password(password)
  #     user
  #   else
  #     nil
  #   end
  # end
  #
  # def self.authenticate_by_username(username, password)
  #   user = find_by_username(username)
  #   if user && user.password == hash_password(password)
  #     user
  #   else
  #     nil
  #   end
  # end
  #
  # def before_save
  #   self
  #   self.password = User.hash_password(self.password)
  # end
  #
  # def before_update
  #   self.password = User.hash_password(self.password) unless password.blank?
  # end
  #
  # private
  #
  # def self.hash_password(password)
  #   self
  #   hashed_password = Digest::SHA1.hexdigest(password)
  #   return hashed_password
  # end
end