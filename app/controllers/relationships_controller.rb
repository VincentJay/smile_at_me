class RelationshipsController < ApplicationController
  before_action :signed_in_user
  
  
  def create
    @smile = Smile.find_by_id(params[:favored_id])
	current_user.favor!(@smile)
	respond_to do |format|	  
	  format.js
	end
  end
  
  def destroy
    @smile = Smile.find_by_id(params[:favored_id])
	current_user.unfavor!(@smile)
	respond_to do |format|
	  format.js
	end
  end

end
