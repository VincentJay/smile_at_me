require 'qiniu'
class QiniuUploadersController < ApplicationController
	before_action :signed_in_user, only: [:new, :uptoken]

	def new
	 #产生七牛上传策略，竟然没有api文档，他妈的还要看源码
	 #https://github.com/qiniu/ruby-sdk/blob/17f69da75861fab2657b8b63a34e76a20feb62f1/lib/qiniu/auth.rb
	 #Digest::MD5::hexdigest(email.downcase)
     put_policy = Qiniu::Auth::PutPolicy.new("smiles")
     @key = Digest::MD5::hexdigest(current_user.name + Time.now.to_s)
     put_policy.scope!("smiles", @key)
	 put_policy.allow_mime_list!("image/jpeg;image/png")
	 put_policy.fsize_limit = 3145728
	 put_policy.return_body = '{
	   "name": $(fname),
	   "size": $(fsize),
	   "w": $(imageInfo.width),
	   "h": $(imageInfo.height),
	   "hash": $(etag),
	   "key": $(key)
	   }'

	 @uptoken = Qiniu::Auth.generate_uptoken(put_policy)
	 render 'qiniu_uploaders/new.js.erb'
   	end

   	def uptoken
   		put_policy = Qiniu::Auth::PutPolicy.new("avatar")
	    put_policy.allow_mime_list!("image/jpeg;image/png")
   	    put_policy.fsize_limit = 3145728
   	    put_policy.return_body = '{
	      "name": $(fname),
	      "size": $(fsize),
	      "w": $(imageInfo.width),
	      "h": $(imageInfo.height),
	      "hash": $(etag)
	      }'

	    @uptoken = Qiniu::Auth.generate_uptoken(put_policy)
   		render 'uptoken.json.jbuilder'
   	end

   	def delete
   	  #@encodedEntryUrl =Qiniu::Utils.encode_entry_uri(params[:bucket], params[:smileKey])
   	  #put_policy = Qiniu::Auth::PutPolicy.new(params[:bucket])
      #@accessToken = Qiniu::Auth.generate_acctoken(@encodedEntryUrl, body = '')
      #qboxToken.url = @encodedEntryUrl
      code, result, response_headers = Qiniu::Storage.delete(params[:bucket], params[:smileKey])    
   	  render 'delete.json.jbuilder'
   	end
    
end
