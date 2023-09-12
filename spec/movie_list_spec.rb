require 'movie_list'

describe MovieList do
  let(:movie_list) do
    described_class.new([
      Movie.new(
        titlefilm: 'Властелин колец 3: Возвращение Короля',
        original_title: 'The Lord of the Rings: The Return of the King', 
        release_date: 2003, 
        rate: 9.48,
        director: ['Питер Джексон'], 
        genres: %w[боевик приключения фэнтези]
      ),
      Movie.new(
        titlefilm: 'Побег из Шоушенка',
        original_title: 'The Shawshank Redemption', 
        release_date: 1994, 
        rate: 9.44,
        director: ['Фрэнк Дарабонт'], 
        genres: %w[драма]
      ),
      Movie.new(
        titlefilm: 'Властелин колец 2: Две крепости',
        original_title: 'The Lord of the Rings: The Two Towers', 
        release_date: 2002, 
        rate: 9.38,
        director: ['Питер Джексон'], 
        genres: %w[боевик приключения фэнтези]
      )]
    )
  end

  describe '::new' do
    it 'assigns instance variables' do
      expect(movie_list.movies).to contain_exactly(
        an_object_having_attributes(
          titlefilm: 'Властелин колец 3: Возвращение Короля',
          original_title: 'The Lord of the Rings: The Return of the King', 
          release_date: 2003, 
          rate: 9.48,
          director: ['Питер Джексон'], 
          genres: %w[боевик приключения фэнтези]
        ),
        an_object_having_attributes(
          titlefilm: 'Побег из Шоушенка',
          original_title: 'The Shawshank Redemption', 
          release_date: 1994, 
          rate: 9.44,
          director: ['Фрэнк Дарабонт'], 
          genres: %w[драма]
        ),
        an_object_having_attributes(
          titlefilm: 'Властелин колец 2: Две крепости',
        original_title: 'The Lord of the Rings: The Two Towers', 
        release_date: 2002, 
        rate: 9.38,
        director: ['Питер Джексон'], 
        genres: %w[боевик приключения фэнтези]
        )
      )
    end
  end

  describe '#directors' do
    it 'checks the class' do 
      expect(movie_list.directors).to be_an(Array)
    end

    it 'selects directors only from movie list' do
      expect(movie_list.directors).to eq(['Питер Джексон', 'Фрэнк Дарабонт'])
    end
  end

  describe '#directors_to_show' do
    it 'checks the class' do 
      expect(movie_list.directors_to_show).to be_a(String)
    end

    it 'checks the method output' do
      expect(movie_list.directors_to_show).to eq("1. Питер Джексон\n2. Фрэнк Дарабонт")
    end
  end

  describe '#movies_of_director(index)' do
    it 'returns the Питер Джексон movies from movie_list' do
      expect(movie_list.movies_of_director(1)).to contain_exactly(
        an_object_having_attributes(
          titlefilm: 'Властелин колец 2: Две крепости',
          original_title: 'The Lord of the Rings: The Two Towers', 
          release_date: 2002, 
          rate: 9.38,
          director: ['Питер Джексон'], 
          genres: %w[боевик приключения фэнтези]
        ),
        an_object_having_attributes(
          titlefilm: 'Властелин колец 3: Возвращение Короля',
          original_title: 'The Lord of the Rings: The Return of the King', 
          release_date: 2003, 
          rate: 9.48,
          director: ['Питер Джексон'], 
          genres: %w[боевик приключения фэнтези]
        )
      )
    end
  end
end