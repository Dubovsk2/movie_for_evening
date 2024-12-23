class Movie
  attr_reader :titlefilm, :original_title, :release_date, :rate, :director, :genres

  def initialize(movie)
    @titlefilm = movie[:titlefilm]
    @original_title = movie[:original_title]
    @release_date = movie[:release_date]
    @rate = movie[:rate]
    @director = movie[:director]
    @genres = movie[:genres]
  end

  def to_s
    "#{@titlefilm} #{@original_title}, #{@release_date}, реж. #{directors_to_show}, рейтинг: #{show_rating} (#{@rate})" 
  end

  def to_file
    [@titlefilm, @original_title, @release_date, @rate, @director.join('/'), @genres.join('/')].map{ |elem| "(#{elem})" }.join(',')
  end

  def show_rating
    empty_star = '☆'
    movie_rating = '★★★★★'
    number_of_full_stars = (rate / 2).round
    movie_rating = movie_rating[0..number_of_full_stars]
    until movie_rating.size == 5
      movie_rating << empty_star
    end
    movie_rating
  end

  def directors_to_show
    @director.size > 1 ? @director.join(', ') : @director[0]
  end
end
