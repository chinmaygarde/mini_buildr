class Authentication
  include Mongoid::Document
  
  field :provider
  field :uid 
  
  referenced_in :user
  
  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid, :scope => :provider
end