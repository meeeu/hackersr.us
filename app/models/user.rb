class User < ActiveRecord::Base
  attr_accessor :password  
  attr_accessible :handle, :name, :email, :password, :password_confirmation

  belongs_to :node

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :handle, :presence   => true,
                     :length     => { :within => 6..50 },
                     :uniqueness => true
  
  validates :name,   :presence   => true,
                     :length     => { :maximum => 50 }
  
  validates :email,  :presence   => true,
                     :format     => { :with => email_regex },
                     :uniqueness => { :case_sensitive => false }

  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  before_save :encrypt_password

#  has_many :node_user_relationships, :foreign_key => "user_id", :dependent => :destroy
#  has_many :memberships, :through => :node_user_relationship, :source => :node_id

#  def membership?(node_id)
#    relationships.find_by_node_id(node_id)
#  end

#  def join!(node_id)
#    relationships.create!(:node_id => node.id)
#  end

#  def unjoin!(node_id)
#    relationships.find_by_node_id(node_id).destroy
#  end

  has_many :notes, :foreign_key => "user_id", :dependent => :destroy

  #testing has_many :through
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed


  def to_param
    "#{handle}"  
  end

  def self.authenticate_with_salt(id, stored_salt)
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  #

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(handle, submitted_password)
    user = find_by_handle(handle)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user :nil
  end

  private
    
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
