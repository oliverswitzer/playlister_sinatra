#old_parser

#app.rb
require 'debugger'
require './lib/artist'
require './lib/genre'
require './lib/song'
require 'awesome_print'
require 'pp'
require 'yaml'


class Parser

  attr_accessor :directory, :mp3_files, :artists

  def initialize(directory="data")
    @directory = directory
    @mp3_files = collect_songs
    @artists = []
  end

  def collect_songs
    Dir.entries(directory).select {|f| !File.directory? f}
  end

  def match_song mp3_file
    mp3_to_match = mp3_file.gsub(" [", "*")
    song_regex = /-\s(.*)\*/
    m = song_regex.match(mp3_to_match)
    m[1]   #this will be equal to the song title
  end

  def match_artist mp3_file
    mp3_to_match = mp3_file.gsub(" - ", "*")
    artist_regex = /(.*)\*/
    m = artist_regex.match(mp3_to_match)
    m[1]
  end

  def match_genre mp3_file
    genre_regex = /\[(.+)\]/
    m = genre_regex.match(mp3_file)
    m[1]
  end

  def push_song_to_existing_genre song, existing_genre_name
    existing_genre = Genre.all.select {|genre_obj| genre_obj.name == existing_genre_name}
    existing_genre[0].songs << song
    return existing_genre[0]
  end

  def push_song_to_new_genre song, new_genre_name
    new_genre = Genre.new(new_genre_name)
    new_genre.songs << song
    return new_genre
  end

  def push_song_to_existing_artist song, existing_artist_name
    existing_artist = Artist.all.select {|artist_obj| artist_obj.name == existing_artist_name}
    existing_artist[0].songs << song
    return existing_artist[0]
  end

  def push_song_to_new_artist song, new_artist_name
    new_artist = Artist.new(new_artist_name)
    new_artist.songs << song
    return new_artist
  end

  def new_song_object mp3_file
    title = match_song(mp3_file)
    artist = match_artist(mp3_file)
    genre = match_genre(mp3_file)

    song = Song.new(title)

    # debugger

    genre_names = Genre.all.collect {|genre_obj| genre_obj.name}

    # debugger

    if genre_names.include?(genre)
      existing_genre = push_song_to_existing_genre(song, genre)
      song.genre = existing_genre
    else
      new_genre = push_song_to_new_genre(song, genre)
      song.genre = new_genre
    end

    artist_names = Artist.all.collect {|artist_obj| artist_obj.name}

    if artist_names.include?(artist)
      existing_artist = push_song_to_existing_artist(song, artist)
      song.artist = existing_artist
    else
      new_artist = push_song_to_new_artist(song, artist)
      song.artist = new_artist
    end

    # artists_of_genre = song.genre.artists.collect {|artist| artist.name == artist}

    # unless artists_of_genre.include? artist
    #   song.genre.artists << song.artist
    # end

    # genres_of_artist = song.artist.genres.collect {|genre| genre.name == genre}

    # unless genres_of_artist.include? genre
    #   song.artist.genres << song.genre
    # end
    
    song
    # debugger
    # puts
  end

  def songify
    mp3s = collect_songs
    mp3s.each do |song_str| 
      # debugger
      @song_objects << new_song_object(song_str)
    end
  end

end