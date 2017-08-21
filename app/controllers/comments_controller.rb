class CommentsController < ApplicationController
	before_action :authenticate_user!
	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
		redirect_to article_path(@comment.article_id),notice: "Successfully added the comment"
		else
		render action :back 
		end
	end
	def show
		@comment = Comment.find(params[:id])
	end

	def destroy 
		@comments = Comment.find(params[:id])
		
			if @comments.destroy
				redirect_to :back,notice:"Comment deleted"
			end
	end 

	private
	def comment_params
	params[:comment].permit(:article_id,:title,:body,:user_id)
	end
end


