## Simple login
This is a simple exemple for login in sinatra using warden, bcrypt and block user if have more than 5 failures attempts.

Default user was configured for email: foo@foo.com and password: 123

### How to run

```bash
$ bundle
$ rackup
```

To add new user
```bash
$ bundle console
$ require './model'
$ User.create!(email: 'john@exemple.org', password: 'test')
```

To unlock user
```bash
$ bundle console
$ require './model'
$ u = User.first(:email => 'john@exemple.org').update(:blocked_user => false)
```