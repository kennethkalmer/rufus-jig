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

  module Path

    def self.add_params (path, h)

      params = h.collect { |k, v| "#{k}=#{v}" }.join('&')

      sep = path.index('?') ? '&' : '?'

      params.length > 0 ? "#{path}#{sep}#{params}" : path
    end

    def self.join (*elts)

      elts, params = if elts.last.is_a?(Hash)
        [ elts[0..-2], elts.last ]
      else
        [ elts, {} ]
      end

      r = elts.collect { |e|

        e = e.match(/^\//) ? e : "/#{e}"

        if m = e.match(/^(.*)\/$/)
          m[1]
        else
          e
        end
      }.join

      add_params(r, params)
    end

    def self.to_path (s)

      s.match(/^\//) ? s : "/#{s}"
    end
  end
end

