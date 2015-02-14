class SmilesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy


    def index #1、用来load和显示 Home页面一定数量的smiles ；2、用来index用户上传的smiles
      
      if params[:start] != nil && params[:scope] == 'all'
        #根据输入的参数：Start\ range 从Redis或者数据库获取 @smile_ids 
        get_all_smiles(params[:start], 15)
        render "smiles/index.js.erb"
      
      elsif params[:start] != nil && params[:scope] == 'uploaded'
      	#index uploaded smiles
      	get_uploaded_smiles(params[:start], 12, params[:id])
    	@receiver = User.find(params[:receiver_id])
    	render "smiles/uploadedSmiles.js.erb"
      
      elsif params[:start] != nil && params[:scope] == 'my'
      	get_my_smiles(params[:start], 10, params[:id])
      	@user = User.find(params[:id])
      	render 'smiles/mysmiles.js.erb'
      
      elsif params[:start] != nil && params[:scope] == 'favorited'
      	get_favorited_smiles(params[:start], 10, params[:id])
      	render 'smiles/favoritedSmiles.js.erb'

      elsif params[:start] != nil && params[:scope] == 'background'
      	get_background_smiles(params[:start], 6)
        render 'smiles/background_smiles.js.erb'     		
      end   	
    end

    def show
      @smile = Smile.find(params[:id])
      @user = @smile.user
      render 'show'
    end 

	def create
	  @smile = current_user.smiles.new( smile_params )
	  if @smile.save
	    #flash[:success] = "Smile Created !"
	    #$redis.lpush("latestSmiles", @smile.id)
	    #$redis.ltrim("latestSmiles", 0,5000)
	    render "smiles/smile.js.erb"
 
	  end

	end

	def destroy
	  @smile.destroy
	  #$redis.lrem("latestSmiles", 0, @smile.id) 
	  #code, result, response_headers = Qiniu::Storage.delete("smiles", ) 
	  redirect_to root_url
	end

	def favorites
	  render 'smiles/favorites.html.erb'
	end

	private 

	  def smile_params
	  	params.require(:smile).permit(:image)
	  end

	  def correct_user
	  	@smile = current_user.smiles.find_by(id: params[:id])
	  	redirect_to root_url if @smile.nil?
	  end

	  def get_all_smiles(start, range)   	 
	  	if start.to_i == 0
	  	  @smiles = Smile.limit(range)
	  	  $pointerElement = @smiles.last
	  	else
	  	  @smiles = Smile.where("created_at < ?", $pointerElement.created_at  ).limit(range)
	  	  $pointerElement = @smiles.last 
	    end
	  end

	  def get_uploaded_smiles(start, range, user_id)
	  	if start.to_i == 0
	  	  @uploadedSmiles = User.find(user_id).smiles.limit(range)
	  	else
	  	  @uploadedSmiles = User.find(user_id).smiles.limit(range).offset(start) 
	    end
	  end

	  def get_my_smiles(start, range, user_id)   	 
	  	if start.to_i == 0
	  	  @mysmiles = User.find(user_id).smiles.limit(range)
	  	  $mysmilesPointerElement = @mysmiles.last
	  	else
	  	  @mysmiles = User.find(user_id).smiles.where("created_at < ?", $mysmilesPointerElement.created_at  ).limit(range)
	  	  $mysmilesPointerElement = @mysmiles.last 
	    end
	  end

	  def get_favorited_smiles(start, range, user_id)
	  	if start.to_i == 0
	  	  @favoritedSmiles = User.find(user_id).favored_smiles.limit(range)
	  	  $favoritedSmilesPointerElement = @favoritedSmiles.last
	  	  #@favoritedSmiles = Relationship.find_by(favorer_id: user_id).limit(range)
	  	else
	  	  @favoritedSmiles = User.find(user_id).favored_smiles.where("created_at < ?", $favoritedSmilesPointerElement.created_at  ).limit(range)
	  	  $favoritedSmilesPointerElement = @favoritedSmiles.last 
	    end
	  end

	  def get_background_smiles(start, range)   	 
	  	  start.to_i == 0
	  	  @backgroundSmiles = Smile.limit(range)
	  end

end