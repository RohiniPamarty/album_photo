class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :tags, :as => :taggable
end
