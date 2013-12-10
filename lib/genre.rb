

class Genre

  attr_accessor :name, :songs, :artists

  @@all = []

  def initialize name="n/a" 
    @name = name
    @songs = []
    @artists = []
    @@all << self
  end

  def self.reset_genres
    @@all = []
  end

  def self.all
    @@all
  end

  def self.search_all genre
    @@all.detect { |defined_genre| defined_genre.name == genre }
  end

end
