class Video < ActiveRecord::Base
  belongs_to :category
  
  named_scope :top, :order => 'views DESC'
  named_scope :latest, :order => 'created_at DESC'
  named_scope :featured, :conditions => { :featured => true }
end
