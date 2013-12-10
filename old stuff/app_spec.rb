#app_spec.rb

# require './lib/artist'
# require './lib/genre'
# require './lib/song'
# require './spec_helper'
# require './parser'

require './app'


describe App, "#list_songs" do 
  it "should display a list of songs for a given artist object" do 
    test_app = App.new
    test_artist = "Adele"
    debugger
    expect(test_app.list_songs(test_artist)).to eq("--> Adele - 2 Songs\n  1. Rolling In the Deep - folk\n  2. Someone Like You - country")
  end
end

describe App, "#list_artists" do 
  it "should display a formatted string list of all artists in the data folder" do 
    test_app = App.new
    expect(test_app.list_artists.all? {|artist| artist.class == String}).to eq(true)
  end
end





