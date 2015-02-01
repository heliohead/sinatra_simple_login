DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db.sqlite")

class User
  include DataMapper::Resource

  property :id, Serial, key: true
  property :email, String
  property :password, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

if User.count == 0
  @user = User.create(email: "foo@foo.com")
  @user.password = "123"
  @user.save
end