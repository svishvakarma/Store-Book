require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let!(:admin_user) { FactoryBot.create(:user, admin: true) }
  book = Book.create(name: "xyz", author_name: "pqr", price: 34, quantity_available: 2, isbn: "45dfg")
  before do
    admin_user.confirm
    sign_in admin_user
  end

  describe 'GET index' do
    it 'returns a list of books' do
      get '/books', headers: @headers

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET new' do
    it 'returns a new book form' do
      get '/books/new', headers: @headers

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    context 'with valid parameters' do
      let(:valid_params) { { book: FactoryBot.attributes_for(:book) } }

      it 'creates a new book' do

        post '/books', params: valid_params, headers: @headers
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { book: { name: '' } } }

      it 'does not create a new book' do
        post '/books', params: invalid_params, headers: @headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET show' do
    it 'show the book' do
      get "/books/#{book.id}", headers: @headers

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET edit' do
    it 'returns the edit form for the book' do
      get "/books/#{book.id}/edit", headers: @headers

      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT update' do
    context 'with valid parameters' do
      let(:valid_params) { { book: { name: 'Updated Book' } } }

      it 'updates the book' do
        put "/books/#{book.id}", params: valid_params, headers: @headers

        expect(response).to have_http_status(200)
        book.reload
        expect(book.name).to eq('Updated Book')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { book: { name: '' } } }

      it 'does not update the book' do
        put "/books/#{book.id}", params: invalid_params, headers: @headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the book' do
      delete "/books/#{book.id}", headers: @headers

      expect(response).to have_http_status(200)
    end
  end

  def sign_in(user)
    post '/auth/sign_in', params: {
      email: user.email,
      password: user.password
    }

    expect(response).to have_http_status(200)
    @authorization = response.headers['Authorization']
    @access_token = response.headers['access-token']
    @uid = response.headers['uid']
    @client = response.headers['client']
    @headers = {
      'Authorization' => @authorization,
      'access-token' => @access_token,
      'uid' => @uid,
      'client' => @client
    }
  end
end
