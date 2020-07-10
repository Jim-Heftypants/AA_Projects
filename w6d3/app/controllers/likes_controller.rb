class LikesController < ApplicationController
    def index
        if like_params[:user_id]
            likes = Like.where(user_id: like_params[:user_id])
            unless likes.empty?
                render json: likes
            else
                render plain: 'No likes were matched'
            end
        elsif like_params[:likeable_id] && like_params[:likeable_type]
            likes = Like.where(likeable_id: like_params[:likeable_id], likeable_type: like_params[:likeable_type])
            unless likes.empty?
                render json: likes
            else
                render plain: 'No likes were matched'
            end
        end
    rescue
        render json: Like.all
    end
    def create
        like = Like.new(like_params)
        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end
    def destroy
        like = Like.find_by(id: params[:id])
        if like
            like.destroy
            render json: like
        else
            render plain: 'like_id invalid'
        end 
    end
    private
    def like_params
        params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
    end 
end