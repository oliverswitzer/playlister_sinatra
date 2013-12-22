require 'bundler'
require 'open-uri'
require 'nokogiri'
require './lib/artist'
require './lib/genre'
require './lib/song'
require './lib/parser'
Bundler.require

class App < Sinatra::Application

  @@parser = Parser.new
  @@parser.parse

  get '/home' do

    erb :home
  end

  get '/genres' do
    @genres = @@parser.genres
    @songs = @@parser.songs
    erb :genres
  end

  get '/artists' do
    @artists = @@parser.artists
    @songs = @@parser.songs
    erb :artists
  end

  get '/artists/:name' do
    @artist = params[:name]
    @download = open("http://ws.spotify.com/search/1/artist?q=#{@artist}").read
    @html = Nokogiri::XML(@download)
    @artist_url = @html.search("artist")[0]["href"]
    @embed_url = "https://embed.spotify.com/?uri=#{@artist_url}"


    @artist.gsub!("_", " ")
    @artist_obj = ::Artist.search_all(@artist)

    @song_count = @artist_obj.songs.size
    erb :artist
  end

  get '/genres/:genre' do
    @genre = params[:genre]
    @genre_obj = ::Genre.search_all(@genre)

    @genre_artists = @genre_obj.artists
    @genre_songs = @genre_obj.songs

    erb :genre
  end

end

