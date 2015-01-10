class QiniuUploadersController < ApplicationController
	before_action :signed_in_user, only: [:new]

	def new
	 #Generate Qiniu upload token
	 put_policy = Qiniu::Auth::PutPolicy.new("smiles")


	 @uptoken = Qiniu::Auth.generate_uptoken(put_policy)
	 respond_to do |format|
	   format.js
	 end

	end

end
