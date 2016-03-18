require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do 
	describe 'GET #index' do 
		it 'returns successful http request status code' do 
			get :index

			expect(response).to have_http_status(:success)
		end
	end

	describe 'GET #show' do 
		it 'returns a successful http request status' do 
			author = Fabricate(:author)

			get :show, id: author.id
			expect(response).to have_http_status(:success)
		end
	end

	describe 'GET #new' do 
		it 'returns a successful http request status code' do 
			get :new

			expect(response).to have_http_status(:success)
		end
	end

end