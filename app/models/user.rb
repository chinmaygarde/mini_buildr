class User
  include Mongoid::Document
  
  field :handle
  field :email
  
  references_many :authentications
end