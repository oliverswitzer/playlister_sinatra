require './lib/artist'
require './lib/genre'
require './lib/song'
require './spec_helper'
require './parser'


describe Parser, "#collect_songs" do 
  
  it "should return an array of string mp3 file names in data" do
    song_array = Dir.entries("data").select {|f| !File.directory? f}
    test_playlist = Parser.new("data")
    expect(test_playlist.collect_songs).to eq(song_array)
  end
end


describe Parser, "#match_song" do 
  
  it "should return the matched song name for any given mp3 file in data" do
    test_mp3 = "Adele - Rolling In the Deep [folk].mp3"
    test_playlist = Parser.new("data")
    expect(test_playlist.match_song(test_mp3)).to eq("Rolling In the Deep")
  end
end

describe Parser, "#match_artist" do 
  
  it "should return the matched artist name for any given mp3 file in data" do
    test_mp3 = "Adele - Rolling In the Deep [folk].mp3"
    test_playlist = Parser.new("data")
    expect(test_playlist.match_artist(test_mp3)).to eq("Adele")
  end
end

describe Parser, "#match_genre" do 
  
  it "should return the matched genre name for any given mp3 file in data" do
    test_mp3 = "Adele - Rolling In the Deep [folk].mp3"
    test_playlist = Parser.new("data")
    expect(test_playlist.match_genre(test_mp3)).to eq("folk")
  end
end



describe Parser, "#parse" do
  my_parser = Parser.new
  my_parser.parse
  artists = my_parser.artists
  it "should parse through each mp3 and return an array of artist objects" do
    expect(artists.all? {|artist| artist.class == Artist}).to eq(true)
  end

  it "should return artist objects with songs" do
    expect(artists.any? {|artist| artist.songs.empty?}).to eq(false)
  end

  it "should return artist objects with genres" do
    expect(artists.any? {|artist| artist.genres.empty?}).to eq(false)
  end
end







