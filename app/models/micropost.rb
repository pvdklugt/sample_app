# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  MAX_CONTENT_LENGTH = 140 
  
  validates :content, :presence => true, :length => { :maximum => MAX_CONTENT_LENGTH }
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
   
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  private   
  
    def self.followed_by(user)
      # Naieve implementation of followed_ids (pulls entire user.following array into memory)
      #   followed_ids = user.following.map(&:id).join(", ")
      # Push this operation into the database by using a subselect
      followed_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id", :user_id => user)
    end

end


