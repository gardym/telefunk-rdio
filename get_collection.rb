require File.join(File.dirname(__FILE__), 'vendor', 'rdio-simple', 'ruby', 'rdio')
require File.join(File.dirname(__FILE__), 'api_key')

rdio = Rdio.new([API_KEY[:key], API_KEY[:secret]])
