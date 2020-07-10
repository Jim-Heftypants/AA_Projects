class CollectionsController < ApplicationController
    def index
        collections = Collection.where(user_id: collection_params[:user_id])
        unless collections.empty?
            render json: collections
        else
            render plain: 'No collections were matched'
        end
    rescue
        render json: Collection.all
    end
    def create
        collection = Collection.new(collection_params)
        if collection.save
            render json: collection
        else
            render json: collection.errors.full_messages, status: :unprocessable_entity
        end
    end
    def destroy
        collection = Collection.find_by(id: params[:id])
        if collection
            collection.destroy
            render json: collection
        else
            render plain: 'collection_id invalid'
        end 
    end
    private
    def collection_params
        params.require(:collection).permit(:user_id, :artwork_id)
    end 
end