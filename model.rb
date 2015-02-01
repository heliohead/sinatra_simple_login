require 'bcrypt'
DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db.sqlite")

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial, key: true
  property :email, String
  property :failed_login_attempts, Integer, default: 0
  property :blocked_user, Boolean, default: false
  property :password, BCryptHash

  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end

DataMapper.finalize
DataMapper.auto_upgrade!

if User.count == 0
  @user = User.create(email: "foo@foo.com")
  @user.password = "123"
  @user.save
end