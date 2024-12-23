require_relative 'lib/movie.rb'
require_relative 'lib/movie_list.rb'
require_relative 'lib/movie_parser'
require "net/http"
require 'nokogiri'
require 'open-uri'


=begin
  address = 'https://www.kinonews.ru/top100'
  movie_list = MovieList.top1001_from_parser(address)
  MovieParser.to_txt(movie_list)
  #this part if form parsing the kinonews website. you should use it just once to create movies.txt, after you can use file created. it's kinda faster.
  #эти строки парсят сайт. нужно использовать один раз для создания movies.txt, далее можно пользоваться локальным файлом для ускорения работы.
=end

top1000 = MovieList.from_file(__dir__ + '/data/movies.txt')
#method returns film chosen by a specific option. in ex. below: director - Joe Russo
#метод вернет фильм выбранный по специфическому критерию. прим. снизу режиссер - Джо Руссо.
puts top1000.where('genres', 'драма')
