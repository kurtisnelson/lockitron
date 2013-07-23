#Lockitron
[![Build Status](https://secure.travis-ci.org/kurtisnelson/lockitron.png)](http://travis-ci.org/kurtisnelson/lockitron)
[![Gem Version](https://badge.fury.io/rb/lockitron.png)](http://badge.fury.io/rb/lockitron)
[![Code Climate](https://codeclimate.com/github/kurtisnelson/lockitron.png)](https://codeclimate.com/github/kurtisnelson/lockitron)
[![Coverage Status](https://coveralls.io/repos/kurtisnelson/lockitron/badge.png?branch=master)](https://coveralls.io/r/kurtisnelson/lockitron)
[![Dependency Status](https://gemnasium.com/kurtisnelson/lockitron.png)](https://gemnasium.com/kurtisnelson/lockitron)
[Documentation](http://rubydoc.info/gems/lockitron/)

Communicates with the [Lockitron API](http://api.lockitron.com)

##Usage

  `gem install lockitron`

If you don't have an OAuth2 token already for the user of your app

  ```ruby
  auther = Lockitron::Auth.new(client_id: 'YOUR_OAUTH_CLIENT_ID', client_secret: 'YOUR_OAUTH_CLIENT_SECRET', redirect_uri: 'URI_FOR_CODE')
  auther.authorization_url #Send your user to this URL to authenticate your app
  auther.token_from_code 'code parameter on the redirect uri'
  auther.token # Store this, it is your token
  ```

To use, you will want a User object

  `user = Lockitron::User('user oauth token')`

Get all the user's locks

  `locks = user.locks`

This returns an array of Lock objects, which have a name and uuid method to find the one you want.

Then to actually do something

  ``ruby
  lock.as user do |l|
    l.unlock
  end
  ``

For more examples, check the request tests in spec/request or the documentation.

##Contributing to lockitron
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

If you want messages from Faraday, set DEBUG in your environment to true.

##Copyright

Copyright (c) 2012 Kurt Nelson. See LICENSE.txt for
further details.

