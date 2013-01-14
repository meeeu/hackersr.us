class Note < ActiveRecord::Base
  auto_html_for :link do
    html_escape
    image
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  attr_accessible :title, :description, :link, :node_id

  belongs_to :user, :class_name => "User"
  belongs_to :node, :class_name => "Node"

  validates :title,       :presence => true,
                          :length   => { :maximum => 1000 }
  validates :description, :presence => true


  default_scope :order => 'notes.created_at DESC'
end
