class Micropost < ActiveRecord::Base
    cattr_reader :per_page
    @@per_page = 4 

    attr_accessible :content
    belongs_to :user
   
    validates_presence_of :content, :user_id
    validates_length_of :content, :maximum=>140

    default_scope :order => 'microposts.created_at DESC' 

end
