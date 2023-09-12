require_relative 'lib/movie.rb'
require_relative 'lib/movie_list.rb'
require_relative 'lib/parser'
require "net/http"
require 'nokogiri'
require 'open-uri'

def director_helper_method(directors)
  string_to_return = ''
  directors.chars.each do |letter|
    if letter == ' '
      string_to_return << letter
    elsif letter == letter.upcase && string_to_return[-1] != ' ' && string_to_return[-1] != string_to_return[0]
      string_to_return << ",#{letter}"
    else
      string_to_return << letter
    end
  end
  string_to_return.split(',')
end

number_of_pages_from_kinonews_top1001 = 20
movie_list = MovieList.top1001_from_parser(number_of_pages_from_kinonews_top1001)

puts "Привет, я помогу тебе выбрать фильм на вечер!"
puts "Фильм какого режиссера ты бы хотел увидеть?"
puts movie_list.directors_to_show

director_index = gets.to_i

puts movie_list.movie_recommendation(director_index)
