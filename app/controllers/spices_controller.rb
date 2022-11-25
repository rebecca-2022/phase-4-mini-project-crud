class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    #GET /spices
    def index
        render json: Spice.all, status: :ok
    end

    #POST /spices
    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    #PATCH /spices
    def update
        #find spice with matching id
        spice = find_spice
        #then update
        spice.update(spice_params)
        render json: spice, status: :ok
    end

    #DELETE /spices/:id
    def destroy
        #find spice matching the id
        spice = find_spice
        spice.destroy
        head :no_content, status: :success
    end

    #private methods
    private
    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    #find a spice by its id
    def find_spice
        Spice.find(params[:id])
    end

    #not found response
    def render_not_found_response
        render json: {error: 'Not Found'}, status: :not_found
    end
end