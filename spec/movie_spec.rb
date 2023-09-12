require 'movie'

describe Movie do
  let(:movie) do
    described_class.new(
      titlefilm: 'Властелин колец 3: Возвращение Короля',
      original_title: 'The Lord of the Rings: The Return of the King', 
      release_date: 2003, 
      rate: 9.48,
      director: ['Питер Джексон'], 
      genres: %w[боевик приключения фэнтези]
    )
  end

  describe '::new' do
    it 'assigns instance variables' do
      expect(movie).to have_attributes(
        titlefilm: 'Властелин колец 3: Возвращение Короля',
        original_title: 'The Lord of the Rings: The Return of the King', 
        release_date: 2003, 
        rate: 9.48,
        director: ['Питер Джексон'], 
        genres: %w[боевик приключения фэнтези]
      )
    end

    it 'checks the class' do
      expect(movie).to be_a(Movie)
    end
  end

  describe '#to_s' do
    it 'returns string as per the to_strings method' do
      expect(movie.to_s).to eq(
        "Властелин колец 3: Возвращение Короля (The Lord of the Rings: The Return of the King), 2003, реж. Питер Джексон, рейтинг: ★★★★★ (9.48)"
      )
    end 
  end

  describe '#show_rating' do
    let(:bad_movie) do
      described_class.new(
        titlefilm: 'Плохое кино',
        original_title: 'Bad movie', 
        release_date: 2003, 
        rate: 1.48,
        director: ['Режиссер'], 
        genres: %w[боевик приключения фэнтези]
      )

      it 'returns one colored star' do
        expect(bad_movie.show_rating).to eq('★☆☆☆☆')
      end
    end
  end
end