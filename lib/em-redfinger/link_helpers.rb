require 'nokogiri'

module EM
  module Redfinger
    module LinkHelpers
      # An array of links with hCard information about this e-mail address.
      def hcard
        relmap('http://microformats.org/profile/hcard')
      end
      
      # An array of links of OpenID providers for this e-mail address.
      def open_id
        relmap('http://specs.openid.net/auth/', true)
      end
      
      # An array of links to profile pages belonging to this e-mail address.
      def profile_page
        relmap('http://webfinger.net/rel/profile-page')
      end
      
      # An array of links to XFN compatible URLs for this e-mail address.
      def xfn
        relmap('http://gmpg.org/xfn/', true)
      end
      
      protected
      
      def relmap(uri, substring=false)
        @doc.css("Link[rel#{'^' if substring}=\"#{uri}\"]").map{|e| Link.from_xml(e)}
      end
    end
  end
end
