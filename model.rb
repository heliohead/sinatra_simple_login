DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db.sqlite")

class User
  include DataMapper::Resource

  property :id, Serial, key: true
  property :email, String
  property :password, String
end