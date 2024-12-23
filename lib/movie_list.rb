require_relative 'movie_parser'

class MovieList
  include MovieParser

  attr_reader :movies

  def initialize(movies)
    @movies = movies
  end

  def self.top1001_from_parser(pages_number)
    parsed_data = MovieParser.parse_kinonews_top1001(pages_number).map { |data| Movie.new(data) }
    new(parsed_data)
  end

  def self.from_file(txt_file)
    new(
      MovieParser.from_txt(txt_file).map { |data| Movie.new(data) }
    )
  end

  def directors_all
    @movies.map { |movie| movie.director }.flatten.uniq
  end

  def directors_to_show
    directors_all.map.with_index(1) { |director, i| "#{i}. #{director}" }.join("\n")
  end

  def genres_all
    @movies.map { |movie| movie.genres }.flatten.uniq
  end

  def where(option, condition)
    case option
    when 'director', 'genres'
      @movies.select { |movie| movie.send(option).include?(condition) }.sample
    when 'rate' 
      @movies.select { |movie| movie.send(option) > condition.to_f }.sample
    when 'release_date'
      @movies.select { |movie| movie.send(option).to_i > condition.to_i }.sample
    end
  end
end
