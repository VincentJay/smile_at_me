class StaticPagesController < ApplicationController
  def home
  	
  	if signed_in?
	 @smile = current_user.smiles.build
	end
  end
end
