require 'em-http-request'
require 'nokogiri'
require 'uri'

module EM
  module Redfinger
    class Client
      attr_accessor :account, :domain, :uri_template, :xrd_timeout, :xrd_open_timeout

      def initialize(email, uri_template = nil)
        self.account          = normalize(email)
        self.domain           = account.split('@').last
        self.xrd_timeout      = 10
        self.xrd_open_timeout = 5
      end

      def finger
        retrieve_template_from_xrd do
          url   = swizzle
          tries = 0
          begin
            tries += 1
            http = EM::HttpRequest.new(url).get
            http.callback {
              raise Redfinger::ResourceNotFound if http.response_header.status == 404
              yield Finger.new self.account, http.response
            }
          rescue Redfinger::ResourceNotFound
            url = swizzle(account_with_scheme)
            retry if tries < 2
            raise Redfinger::ResourceNotFound
          end
        end
      end

      def xrd_url(ssl = true)
        "http#{ 's' if ssl }://#{ domain }/.well-known/host-meta"
      end

      private

      def swizzle(account = nil)
        retrieve_template_from_xrd { |uri_template|
          account ||= self.account
          uri_template.gsub '{uri}', URI.escape(self.account)
        }
      end

      def retrieve_template_from_xrd(ssl = true, &block)
        return yield(self.uri_template) if self.uri_template

        http = EM::HttpRequest.new(xrd_url(ssl),
          :connect_timeout    => self.xrd_open_timeout,
          :inactivity_timeout => self.xrd_timeout
        ).get
        http.callback {
          if http.response_header.status != 200
            raise Redfinger::ResourceNotFound, 'Unable to find the host XRD file.'
          end
          doc  = Nokogiri::XML::Document.parse(http.response)
          lrdd = doc.at('Link[rel=lrdd]')
          raise Redfinger::NoLRDDTemplate if lrdd.nil?

          self.uri_template = lrdd.attribute('template').value
          yield self.uri_template
        }
        http.errback {
          raise Redfinger::ResourceNotFound, 'Unable to find the host XRD file.'
        }
      end

      def normalize(email)
        email.sub! /^acct:/, ''
        email.downcase
      end

      def account_with_scheme
        'acct:' + account
      end
    end
  end
end
