module MovieParser
  PAGES_NUMBER = 20
  #address "https://www.kinonews.ru/top100_p"

  class << self
    def parse_kinonews_top1001(address, pages_number = PAGES_NUMBER)
      movies = []

      address_helper(address, pages_number).each_with_index do |path, i|
        puts '.' * i
        sleep(0.5)
        doc = Nokogiri::HTML(URI.open(path))
        doc.css('div[style="overflow:auto;"]').each do |element|
          movies <<
            ({
              titlefilm: element.css('a[class="titlefilm"]').text,
              original_title: element.css('span[class="bigtext"]').text.delete('()'),
              release_date: element.css('div[class="bigtext"]').text.split(',')[-1].to_i,
              rate: element.css('div[class="zhanr_rating"] span[class="rating-big"]').text.to_f,
              director: director_helper_method(element.css('div[class="textgray"]')
              .select { |textgray| textgray.css('span').text == 'Режиссер:' }
              .map { |textgray| "#{textgray.css('a').text}" }[0]),
              genres: element.css('div[class="textgray"]')
                .select { |textgray| textgray.css('span').text == 'Жанр:' }
                .map(&:text)[0].strip.gsub(/Жанр: /, '').split(', ')
            })
        end
      end
      movies
    end

    def to_txt(collection)
      File.open('data/movies.txt', 'w') do |f|
        collection.movies.each do |movie|
          f.write(movie.to_file)
          f.write("\n")
        end
      end
    end

    def from_txt(txt_file)
      movies = []
      File.readlines(txt_file, chomp: true).map { |string| string.split('),').map { |elem| elem.delete('()')} }.each do |string|
        director = string[4].include?('/') ? string[4].split('/') : [string[4]]
        movies <<
        {
          titlefilm: string[0], 
          original_title: string[1], 
          release_date: string[2], 
          rate: string[3].to_f, 
          director: director, 
          genres: string[5].split('/')
        }
      end
      movies
    end

    private

    def director_helper_method(directors)
      directors.chars.map.with_index do |letter, i|
        if /[[:upper:]]/ =~ (letter) && / / !~ directors[i - 1] && i != 0
          ",#{letter}"
        else
          letter
        end
      end.join.split(',')
    end

    def address_helper(str, pages_number)
      #made for "https://www.kinonews.ru/top100"
      kino_pages = []
      1.upto(pages_number) do |n|
        address_array = str.chars
        to_add = n != 1 ? str.chars.push("_p#{n}") : str.chars
        kino_pages << to_add.join('')
      end
      kino_pages
    end
  end
end
