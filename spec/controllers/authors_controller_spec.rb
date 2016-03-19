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

	describe 'POST #create' do 
		context 'a successful create' do 
			it 'saves the new author object' do 
				post :create, author: Fabricate.attributes_for(:author)

				expect(Author.count).to eq(1)
			end

			it 'redirects to the author show action' do 
				post :create, author: Fabricate.attributes_for(:author)

				expect(response).to redirect_to author_path(Author.last)
			end

			it 'sets the success flash message' do 
				post :create, author: Fabricate.attributes_for(:author)

				expect(flash[:success]).to eq('Author has been created')
			end
		end

		context 'an unsuccessful create' do 
			it 'does not save the author objcect with invalid input' do 
				post :create, author: Fabricate.attributes_for(:author, first_name: nil)

				expect(Author.count).to eq(0)
			end

			it 'sets the failure flash message' do 
				post :create, author: Fabricate.attributes_for(:author, first_name: nil)

				expect(flash[:danger]).to eq('Author has not been created')
			end
		end
	end

	describe 'GET #edit' do 
		let(:author) { Fabricate(:author) }

		it 'sends a successful edit request' do 
			get :edit, id: author 

			expect(response).to have_http_status(:success)
		end 
	end

	describe 'PUT #update' do 
		context 'a successful update' do 
			let(:john) { Fabricate(:author, first_name: 'John') }

			it 'updates the modified author object' do 
				put :update, author: Fabricate.attributes_for(:author, first_name: 'Mike'), id: john.id

				expect(Author.last.first_name).to eq('Mike')
				expect(Author.last.first_name).not_to eq('John')
			end

			it 'sets successful flash message' do 
				put :update, author: Fabricate.attributes_for(:author, first_name: 'Mike'), id: john.id

				expect(flash[:success]).to eq('Author has been updated')
			end

			it 'redirects to the show action' do 
				put :update, author: Fabricate.attributes_for(:author, first_name: 'Mike'), id: john.id

				expect(response).to redirect_to(author_path(Author.last))
			end
		end

		context 'an unsuccessful update' do 
			let(:john) { Fabricate(:author, first_name: 'John') }

			it 'does not update the author object with invalid input' do 
				put :update, author: Fabricate.attributes_for(:author, first_name: nil), id: john.id

				expect(Author.last.first_name).to eq('John')
			end

			it 'sets successful flash message' do 
				put :update, author: Fabricate.attributes_for(:author, first_name: nil), id: john.id

				expect(flash[:danger]).to eq('Author has not been updated')
			end
		end
	end

end
