$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), 'vendor', 'rdio-simple', 'ruby'))

require 'vendor/rdio-simple/ruby/rdio'
require 'api_key'

require 'pp'

rdio = Rdio.new([API_KEY[:key], API_KEY[:secret]])

while(true)
  print "Find an artist: "
  artist_guess = gets.strip

  response = rdio.call('search', {:query => artist_guess, :types => "Artist"})
  results = response["result"]

  if results["artist_count"] > 0
    puts "Sure are: "
    results["results"].each do |result|
      puts "#{result["name"]} (#{result["url"]})"
      albums = rdio.call('getAlbumsForArtist', {:artist => result["key"], :region => "AU"})
      puts "\tAlbums:"
      albums["result"].each do |album|
        puts "\t\t#{album["name"]} (Streamable?: #{album["canStream"]})"
      end
    end
  else
    puts "Sorry! Not (yet)..."
  end
end
