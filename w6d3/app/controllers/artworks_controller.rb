# app/controllers/artworks_controller.rb
class ArtworksController < ApplicationController
    def show
        artwork = Artwork.find_by(id: params[:id])
        if artwork
          render json: artwork
        else
          render plain: 'ID invalid'
        end 
    end
    def index
        user = User.find_by(id: params[:user_id])
        if user
            #artworks owned by user
            owned_art = user.artworks
            #artworks shared to the user
            shared_art = user.shared_artworks
            render json: {owned_art: owned_art, shared_art: shared_art}
        else
            render plain: 'User_id invalid'
        end
    end
    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end
    def update
        artwork = Artwork.find(params[:id])
        if artwork.update(artwork_params)
          redirect_to "/artworks/#{artwork.id}"
        else
          render json: artwork.errors.full-messages, status: 422
        end 
    end
    def destroy
        artwork = Artwork.find_by(id: params[:id])
        if artwork
            artwork.destroy
            render json: artwork
        else
            render plain: 'ID invalid'
        end 
    end
    def favorite
        artwork = Artwork.find_by(id: params[:id])
        if artwork
            # get artworks
            render json: artwork.users_who_favorited
        else
            render plain: 'No favorites found'
        end
    end
    private
    def artwork_params
        params.require(:artwork).permit(:artist_id, :title, :image_url)
    end
    
end
