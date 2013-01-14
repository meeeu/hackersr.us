class NodeUserRelationship < ActiveRecord::Base
  attr_accessible :node_id

  belongs_to :node_id, :class_name => "Node"
  belongs_to :user_id, :class_name => "User"

  validates :node_id, :presence => true
  validates :user_id, :presence => true
end
