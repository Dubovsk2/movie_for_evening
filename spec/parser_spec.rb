require 'parser'
require "net/http"
require 'nokogiri'
require 'open-uri'

describe Parser do
  let(:kinonews_top1001) do
    described_class.parse_kinonews_top1001(1)
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
      expect(Parser.send(:director_helper_method, directors)).to eq(['Лана Вачовски', 'Лили Вачовски'])
    end
  end
end