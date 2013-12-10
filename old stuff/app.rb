#app.rb

require './parser'
require 'debugger'

class App

  attr_accessor :my_parser, :artists, :genres, :songs

  def initialize
    @my_parser = Parser.new
    my_parser.parse
    @artists = my_parser.artists
    @genres = my_parser.genres
    @songs = my_parser.songs
  end

  def greeting
    puts "+" * 80
    "Welcome to Playlister, a CLI application to convert a directory into a playlist!".each_char do |char|
      print char
      sleep(0.02)
    end
    puts
    puts "+" * 80
  end

  # def set_directory
  #   puts "Choose a directory you would like to turn into a playlist.\nType the relative path (type 'c' to use the default, './data/')"
  #   inp = gets.chomp
  #   if inp == c

  # end


  def a_or_g_prompt
    puts "Browse by Artist or Genre (type 'artist' or 'genre')"
    inp = gets.chomp.downcase
    until inp == "artist" || inp == "genre"
      puts "Please type either 'artist' or 'genre'"
      inp = gets.chomp
    end
    return inp
  end

  def list_artists
    artist_strings = artists.collect {|artist| artist.name}.sort
    artist_strings.each_with_index {|artist, i| puts "#{i+1}: #{artist}"}
    "Type the name of the artist you would like to look up".each_char do |char|
      print char
      sleep(0.02)
    end
    puts
    inp = gets.chomp
    pick = artist_strings.detect {|artist| artist.downcase == inp.downcase}
    if pick
      pick
    else
      puts "***The search for the artist you typed returned no matches***"
      puts "Hit enter to search again"
      inp2 = gets.chomp 
      if inp2 
        list_artists
      end
    end
  end

  def return_object object_name, arts_gens_songs
    arts_gens_songs.detect {|object| object.name == object_name}
  end


  def list_genres
    genre_strings = genres.collect {|genre| genre.name}.sort
    genre_strings.each_with_index {|genre, i| puts "#{i+1}: #{genre}"}
    "Type the name of the genre you would like to look up".each_char do |char|
      print char
      sleep(0.02)
    end
    puts
    inp = gets.chomp
    pick = genre_strings.detect {|artist| artist.downcase == inp.downcase}
    if pick
      pick
    else
      puts "***The search for the genre you typed returned no matches***"
      puts "Hit enter to search again"
      inp2 = gets.chomp 
      if inp2 
        list_genres
      end
    end
  end

  def list_songs a_or_g_name, a_or_g 
    if a_or_g == "a"
      object = return_object(a_or_g_name, artists)
      if object.nil?
        return nil
      end
      songs = object.songs
      song_count = songs.size
      puts "--> #{object.name} - #{song_count} Song(s)"
      songs.each_with_index {|song, i| puts "  #{i+1}. #{song.name} - #{song.genre.name}"}
    elsif a_or_g == "g"
      object = return_object(a_or_g_name, genres)
      if object.nil?
        return nil
      end
      artist_count = ", #{object.artists.size} artists"
      songs = object.songs
      song_count = songs.size
      puts "--> #{object.name} - #{song_count} Song(s)#{artist_count}"
      songs.each_with_index {|song, i| puts "  #{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end
  end

  def artist_page artist_name
    list_songs(artist_name, "a")
  end

  def song_page song_name
    song = return_object(song_name, songs)
    puts "--> Title: #{song.name}"
    puts "      Artist - #{song.artist.name}"
    puts "      Genre - #{song.genre.name}"
  end

  def a_or_s_page
    "Type in 'artist' or 'song' to look up an artist's or song's page".each_char do |char|
      print char
      sleep(0.02)
    end
    puts
    inp = gets.chomp

    until inp == "artist" || inp == "song"
      puts "Please type either 'artist' or 'song' to look up an artist or song page"
      inp = gets.chomp
    end

    if inp == "artist"
      "Type in the artist's name you would like to visit the page of".each_char do |char|
        print char
        sleep(0.02)
      end
      puts
      inp2 = gets.chomp
      while return_object(titleize(inp2), artists).nil?
        puts "Your input did not return a matched artist! Try again"
        puts "Type in the artist's name you would like to visit the page of"
        inp2 = gets.chomp
      end
      artist_page(titleize(inp2))
    elsif inp == "song"
      "Type in the song's name you would like to visit the page of".each_char do |char|
        print char
        wait(0.02)
      end
      puts
      inp2 = gets.chomp
      while return_object(titleize(inp2), songs).nil?
        puts "Your input did not return a matched song! Try again"
        puts "Type in the song's title you would like to visit the page of"
        inp2 = gets.chomp
      end
      song_page(titleize(inp2))
    end
  end


  def titleize string 
    string.split(" ").map {|word| word.capitalize}.join(" ")
  end


  def run
    greeting
    first_input = a_or_g_prompt
    if first_input == "artist"
      artist_pick = list_artists
      list_songs(artist_pick, "a")
    else
      genre_pick = list_genres
      list_songs(genre_pick, "g")
      a_or_s_page
    end
  end
end




app = App.new
app.run




