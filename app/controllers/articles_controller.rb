 class ArticlesController < ApplicationController
 	before_action :authenticate_user!, except: [:index, :show]
 	  
 	  load_and_authorize_resource

	def index
	@articles = Article.paginate(:page => params[:page], :per_page => 2)
 
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		if @article .save
			redirect_to articles_path, notice: "successfully inserted"

		else
			render action: "new"
		end
	end

	def show
		category_ids=@article.categories.pluck(:id)
		selected_article_ids = ArticleCategory.where(category_id:category_ids).shuffle.first(2).map(&:article_id)
		@related_articles = Article.where(id: selected_article_ids)
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update_attributes(article_params)
			redirect_to article_path(@article), notice: "successfully updated"
		else
			render action: "edit"
		end
    end

    def destroy
    	@article = Article.find(params[:id])
    	if @article.destroy
    		redirect_to articles_path, notice: "successfully deleted"
    	else
    		render action: back
    	end
	end

	private

	def article_params
		params[:article].permit(:title, :body, :published, :published_date, category_ids:[])
	end
end
