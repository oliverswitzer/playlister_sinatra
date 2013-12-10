

class Song

  attr_accessor :name, :genre, :artist

  def initialize name="untitled", artist="n/a", genre="n/a"
    @name = name
    @artist = artist  
    @genre = genre
  end

  def genre= genre
    @genre = genre
    genre.songs << self
  end

end
