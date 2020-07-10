# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
    def index
        if comment_params[:author_id]
            comments = Comment.where(author_id: comment_params[:author_id])
        else
            comments = Comment.where(artwork_id: comment_params[:artwork_id])
        end
        unless comments.empty?
            render json: comments
        else
            render plain: 'No comments were matched'
        end
    end
    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment
        else
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end
    end
    def destroy
        comment = Comment.find_by(id: params[:id])
        if comment
            comment.destroy
            render json: comment
        else
            render plain: 'Comment_id invalid'
        end 
    end
    private
    def comment_params
        params.require(:comment).permit(:body, :author_id, :artwork_id)
    end 
end