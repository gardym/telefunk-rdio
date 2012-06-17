require 'sinatra'

$:.unshift(File.join(File.dirname(__FILE__), '..'))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'vendor', 'rdio-simple', 'ruby'))
require 'rdio'
require 'api_key'

require 'pp'

get '/listenable' do
  haml :listenable
end

get '/listenable/search' do
  #file = File.open('./test_json.json')
  #json = file.readline
  #file.close
  #json

  rdio = Rdio.new([API_KEY[:key], API_KEY[:secret]])

  results = rdio.call('search', {:query => params[:query], :types => "Artist"})["result"]

  if results["artist_count"] > 0
    data = results["results"].map do |result|
      albums = rdio.call('getAlbumsForArtist', {:artist => result["key"]})["result"] # region => AU?

      {
        :artist => {:name => result["name"], :url => result["url"]},
        :albums => albums.map do |album|
          {:name => album["name"], :canStream => album["canStream"], :icon => album["icon"]}
        end
      }
    end
    pp data
    json = data.to_json
    #file = File.open('./test_json.json', 'w')
    #file.write(json)
    #file.close
    json
  else
    "Sorry! Not (yet)..."
  end
end
