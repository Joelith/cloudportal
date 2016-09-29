class RateCardsController < ApplicationController
	before_action :set_rate_card, only: [:show, :edit, :update, :destroy]

	def index
		@rate_cards = RateCard.all
  end

 	def new
		@rate_card = RateCard.new
	end

	def show
	end

	def create
	  @rate_card = RateCard.new(rate_card_params)

	  if @rate_card.save
	    flash[:notice] = "Rate Card has been created."
	    redirect_to @rate_card
	  else
  	  flash.now[:alert] = "Rate Card has not been created."
	    render "new"
	  end
	end

	def edit
	end

	def update
		if @rate_card.update_attributes(rate_card_params)
			flash[:notice] = "Rate Card has been updated."
			redirect_to @rate_card
		else
			flash.now[:alert] = "Rate Card has not been updated."
			render "edit"
		end
	end

	private

	def set_rate_card
	  @rate_card = RateCard.find(params[:id])
	rescue ActiveRecord::RecordNotFound
	  flash[:alert] = "The rate card you were looking for could not be found."
	  redirect_to project_path
	end

	def rate_card_params
  	params.require(:rate_card).permit(:provider, :key, :value)
	end
 end
