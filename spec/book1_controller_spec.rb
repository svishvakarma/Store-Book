require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:book) { FactoryBot.create(:book) }
  before do
    user.confirm
    sign_in user
  end

  describe 'POST create' do
    context 'with valid parameters' do
      let(:valid_params) { { book: FactoryBot.attributes_for(:book) } }

      it 'creates a new book' do

        post '/books', params: valid_params, headers: @headers
        expect(response).to have_http_status(401)
      end
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
