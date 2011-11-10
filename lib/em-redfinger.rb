require 'eventmachine'
require 'em-http'

require 'em-redfinger/link_helpers'
require 'em-redfinger/link'
require 'em-redfinger/finger'
require 'em-redfinger/client'

module EventMachine
  module Redfinger
    class ResourceNotFound < StandardError; end
    # A SecurityException occurs when something in the
    # webfinger process does not appear safe, such as
    # mismatched domains or an unverified XRD signature.
    class SecurityException < StandardError; end

    # There's no LRDD template attribute available in the requested
    # account.
    class NoLRDDTemplate < StandardError; end

    # Finger the provided e-mail address.
    def self.finger(email)
      EM::Redfinger::Client.new(email).finger { |finger| yield finger }
    end
  end
end
