class SmilesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

	def create
	  @smile = current_user.smiles.build( smile_params )
	  if @smile.save
	    flash[:success] = "Smile Created !"
	    redirect_to root_url
	  else
	  	@feed_items = []
	  	render 'static_pages/home'
	  end

	end

	def destroy
	  @smile.destroy
	  redirect_to root_url
	end

	private 

	  def smile_params
	  	params.require(:smile).permit(:image)
	  end

	  def correct_user
	  	@smile = current_user.smiles.find_by(id: params[:id])
	  	redirect_to root_url if @smile.nil?
	  end
end
