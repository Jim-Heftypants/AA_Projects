# app/controllers/users_controller.rb
class UsersController < ApplicationController
    def show
        user = User.find_by(id: params[:id])
        if user
          render json: user
        else
          render plain: 'ID invalid'
        end 
    end
    def index
        #add search here
        # params[:query]
        if user_params.has_key?(:username)
            # can modify query w/ regex 
            users = User.where('username LIKE (?)', user_params[:username])
            unless users.empty?
                render json: users
            else
                render plain: 'Invalid username'
            end
        end
    rescue
        #render plain: 'Invalid username'
        render json: User.all
    end
    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end
    def update
        user = User.find(params[:id])
        if user.update(user_params)
          redirect_to "/users/#{user.id}"
        else
          render json: user.errors.full-messages, status: 422
        end 
    end
    def destroy
        user = User.find_by(id: params[:id])
        if user
            user.destroy
            render json: user
        else
            render plain: 'ID invalid'
        end 
    end
    def favorite
        user = User.find_by(id: params[:id])
        if user
            # get artworks
            render json: user.favorited_artworks
        else
            render plain: 'No favorites found'
        end
    end
    private
    def user_params
        params.require(:user).permit(:username)
    end
    
end
