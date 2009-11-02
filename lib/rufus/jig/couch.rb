#--
# Copyright (c) 2009-2009, John Mettraux, jmettraux@gmail.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Made in Japan.
#++


module Rufus::Jig

  class CouchThing

    # the jig client, the CouchThing uses
    #
    attr_reader :http

    def initialize (host, port, path='/')

      @http = Rufus::Jig::Http.new(host, port, :prefix => path)
    end

    # Returns a new CouchThing instance pointing to the couch itself
    #
    def couch

      CouchThing.new(
        @http.host, @http.port,
        '/')
    end

    # Returns a new CouchThing instance pointing to the couch database holding
    # the current CouchThing.
    #
    def database

      CouchThing.new(
        @http.host, @http.port,
        '/' + @http.options[:prefix].split('/')[1])
    end

    def spawn (path)

      CouchThing.new(
        @http.host, @http.port,
        "#{@http.options[:prefix]}#{path}")
    end

    def get (path='', opts={})

      @http.get(path, opts)
    end

    def delete (path='', opts={})

      @http.delete(path, opts)
    end

    def put (path='', data={}, opts={})

      # TODO : rev thing

      opts[:content_type] ||= :json

      @http.put(path, data, opts)
    end

    def post (path='', data={}, opts={})

      # TODO : rev thing

      opts[:content_type] ||= :json

      @http.post(path, data, opts)
    end
  end
end

