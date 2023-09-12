require_relative 'parser'

class MovieList
  include Parser

  attr_reader :movies

  def initialize(movies)
    @movies = movies
  end

  def self.top1001_from_parser(pages_number)
    parsed_data = Parser.parse_kinonews_top1001(pages_number).map { |data_array| Movie.new(data_array) }
    self.new(parsed_data)
  end

  def directors
    @movies.map { |movie| movie.director }.flatten.uniq
  end

  def directors_to_show
    directors.map.with_index(1) { |director, i| "#{i}. #{director}" }.join("\n")
  end

  def movies_of_director(index)
    @movies.select { |movie|  movie.director.include?(directors[index - 1]) }
  end

  def movie_recommendation(index)
    movies_of_director(index).sample
  end 
end
