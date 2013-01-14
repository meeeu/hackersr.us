class Node < ActiveRecord::Base
  has_many :users

  has_many :notes, :foreign_key => "node_id", :dependent => :destroy
  #has_many :node_user_relationships, :foreign_key => "user_id",
  #                                   :dependent   => :destroy
  #has_many :reverse_node_user_relationships, :foreign_key => "node_id",
  #                                 :class_name => "Relationship",
  #                                 :dependent => :destroy
  #has_many :members, :through => :reverse_node_user_relationships,
  #                   :source  => :node
  #has_many :memberships


  #testing has_many :through
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent   => :destroy
  has_many :following, :through => :relationships,
                       :source  => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name  => "Relationship",
                                   :dependent   => :destroy
  has_many :followers, :through => :reverse_relationships,
                       :source  => :follower

  def to_param
    "#{name}"
  end

  def self.authenticate_with_salt(id, stored_salt)
  end

  #def following?(followed)
  #  relationsips.find_by_followed_id(followed)
  #end

  #def follow!(followed)
  #  relationships.created!(:followed_id => followed.id)
  #end

  #def unfollow!(followed)
  #  relationships.find_by_followed_id(followed).destroy
  #end

end
