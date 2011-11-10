EM-Redfinger
============

This library is an exeperimental EventMachine version of the simple
[redfinger](https://github.com/intridea/redfinger) ruby lib.  The logic
is *exactly* the same as I've just changed HTTP calls to no use
rest-client, and hooked a bunch of callback here and there.

EM::Redfinger is a simple Ruby library built to consume the Webfinger
protocol using EventMachine. It's simple!

For more information about Webfinger, see:

  * http://hueniverse.com/2009/08/introducing-webfinger/
  * http://code.google.com/p/webfinger/

Installation
------------

EM-Redfinger is a gem:
    
    gem install em-redfinger

Usage
-----

Just call it with an e-mail address of a domain that provides the Webfinger protocol:

~~~~~ ruby
require 'em-redfinger'

EM::Redfinger.finger('youraccount@joindiaspora.com') do |finger|
  # ...
end
~~~~~
    
From there, you have access to the links provided in the response as
well as some shortcuts for common uses:

~~~~~ ruby
Redfinger.finger('youraccount@joindiaspora.com') do |finger|
  finger.hcard.first.to_s # => "https://joindiaspora.com/hcard/users/you"
end
~~~~~
    
Links are simple hash based objects that store the 'rel' URI (such as
that for hCard, OpenID, etc.), the 'href' (the actual destination URI),
and the content type if specified. Note you can also just use `#to_s` on
a link to get the destination URI.

So how can you use Webfinger to your advantage? Let's take the example
of hCard. If you install the `mofo` library you can do this:

~~~~~ ruby
require 'mofo'
require 'em-redfinger'

EM::Redfinger.finger('example@joindiaspora.com') do |finger|
  hcard_uri = finger.hcard.first.to_s
  hcard = hCard.find(hcard_uri)
  hcard.fn    # => "Example Guy"
  hcard.title # => "Title guy gave himself on Google profile"
end
~~~~~
    
Note that the Webfinger protocol is still in its alpha/infancy and there
will likely be many changes as time progresses.  This library will do
its best to stay up-to-date and current with these changes over time.

Note on Patches/Pull Requests
-----------------------------
 
  * Fork the project.
  * Make your feature addition or bug fix.
  * Add tests for it. This is important so I don't break it in a
    future version unintentionally.
  * Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
  * Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2011 Intridea, Inc. and Michael Bleigh. See LICENSE for details.
