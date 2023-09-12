module Parser
  def self.parse_kinonews_top1001(pages_number)
    movies = []

    1.upto(pages_number) do |n|
      path = "https://www.kinonews.ru/top100_p#{n}/"
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
      sleep(0.5)
      puts '.' * pages_number
    end
    movies
  end

  private 
  def self.director_helper_method(directors)
    directors.chars.map.with_index do |letter, i|
      if /[[:upper:]]/ =~ (letter) && / / !~ directors[i - 1] && i != 0
        ",#{letter}"
      else
        letter
      end
    end.join.split(',')
  end
end