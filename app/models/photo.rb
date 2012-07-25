class Photo < ActiveRecord::Base
has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
belongs_to :album
has_many :tags, :as => :taggable
end
