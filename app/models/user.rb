class User
  include Mongoid::Document
  
  field :handle
  
  references_many :authentications
end