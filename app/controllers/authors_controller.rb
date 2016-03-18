class AuthorsController < ApplicationController
	def index
	end

	def show
		@author = Author.find(params[:id])
	end

	def new
		@author = Author.new
	end

	def create
		@author = Author.new(author_params)
		if @author.save
			flash[:success] = 'Author has been created'
			redirect_to @author
		else
			flash[:danger] = ''
			render :new
		end
	end


	private
	def author_params
		params.require(:author).permit(:first_name, :last_name)
	end

end