$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), 'vendor', 'rdio-simple', 'ruby'))

require 'vendor/rdio-simple/ruby/rdio'
require 'api_key'

rdio = Rdio.new([API_KEY[:key], API_KEY[:secret]])
