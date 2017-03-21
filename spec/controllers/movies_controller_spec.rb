require 'rails_helper.rb'

describe MoviesController, :type => :controller do
  describe 'Search movies by the same director if director exists' do
    let(:movie1) { Movie.create(:title => "Star Wars", :director => "George Lucas", :id => "1") }
    let(:movie2) { Movie.create(:title => "THX-1138", :director => "George Lucas", :id => "2") }

    before(:each) do
        put :similar, id: movie1.id
    end
    
    it 'should render the similar template if director exists' do
        expect(response).to render_template('similar')
    end
  end
  
   describe 'Tests for create' do
    it 'creates a new movie' do
      expect {post :create, movie: {:title=>"New movie"}
      }.to change { Movie.count }.by(1)
    end

    it 'redirects to the movie index page' do
      post :create, movie: {:title=>"New movie"}
      expect(response).to redirect_to(movies_url)
    end
  end

  describe 'Tests for index' do
    let!(:movie) {Movie.create}

    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should assign instance variable for title header' do
      get :index, { sort: 'title'}
      expect(assigns(:title_header)).to eql('hilite')
    end

    it 'should assign instance variable for release_date header' do
      get :index, { sort: 'release_date'}
      expect(assigns(:date_header)).to eql('hilite')
    end
  end

  describe 'Tests for new' do
    let!(:movie) { Movie.new }

    it 'should render the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'Tests for edit' do
    let!(:movie) { Movie.create }
    before do
      get :edit, id: movie.id
    end

    it 'should find the movie' do
      expect(assigns(:movie)).to eql(movie)
    end

    it 'should render the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'Tests for update' do
    let(:movie1) { Movie.create(:title=>"Inception", :director=>"unknown", :id=>"123") }
    
    before(:each) do
      put :update, id: movie1.id, movie: {:title=>"Modified"}
    end

    it 'updates an existing movie' do
      movie1.reload
      expect(movie1.title).to eql('Modified')
    end

    it 'redirects to the movie page' do
      expect(response).to redirect_to(movie_path(movie1))
    end
  end

  describe 'DELETE #destroy' do
    let!(:movie1) { Movie.create }

    it 'destroys a movie' do
      expect { delete :destroy, id: movie1.id
      }.to change(Movie, :count).by(-1)
    end

    it 'redirects to movies#index after destroy' do
      delete :destroy, id: movie1.id
      expect(response).to redirect_to(movies_path)
    end
  end
end