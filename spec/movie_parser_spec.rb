require_relative '../lib/movie_parser.rb'
require "net/http"
require 'nokogiri'
require 'open-uri'

describe MovieParser do
  page = __dir__ + '/fixtures/movie_page.html'
  let(:kinonews_top1001) do
    described_class.parse_kinonews_top1001(page, 1)
  end

  describe '::parse_kinonews_top1001' do
    it 'checks the class of object' do
      expect(kinonews_top1001).to be_an(Array)
    end

    it 'checks size of the object' do
      expect(kinonews_top1001.size).to eq(50)
    end

    it 'checks the content of the object' do
      expect(kinonews_top1001[0]).to eq(
        titlefilm: 'Властелин колец 3: Возвращение Короля',
        original_title: 'The Lord of the Rings: The Return of the King', 
        release_date: 2003, 
        rate: 9.48,
        director: ['Питер Джексон'], 
        genres: %w[боевик приключения фэнтези]
      )
    end
  end

  describe '::director_helper_method(directors)' do
    let(:directors) do
      'Лана ВачовскиЛили Вачовски'
    end

    it 'splits the string to array correctly' do
      expect(MovieParser.send(:director_helper_method, directors)).to eq(['Лана Вачовски', 'Лили Вачовски'])
    end
  end

  describe '::from_txt' do
    let(:movies_from_file) do
      described_class.from_txt(__dir__ + '/fixtures/movies.txt')
    end

    let(:mov) do
      {titlefilm: 'Они сражались за Родину',
      original_title: '',
      release_date: 1975,
      rate: 9.23,
      director: 'Сергей Бондарчук',
      genres: %w[военный драма исторический],
    }
    end

    it 'should be an array' do
      expect(movies_from_file.is_a?(Array))
    end

    it 'size should be 7' do
      expect(movies_from_file.size == 7)
    end

    it 'should have proper values' do
      expect(movies_from_file.include?(mov))
    end
  end
end
