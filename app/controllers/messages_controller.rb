#require 'eventmachine'

class MessagesController < ApplicationController
 
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  mattr_accessor :read_state


    def index
      if params[:read_state] == "false"
      	@unreadMessagesAll = Message.where(receiver_id: params[:receiver_id], read_state: false)
      	#@unreadMessages = Message.where("receiver_id = ?", params[:receiver_id]).paginate(page: params[:page])
      	if params[:render] == "false"
      	  render 'messages/unreadMessagesIndicator.js.erb'
      	else
      	  get_unread_messages(params[:start], 5, params[:receiver_id], false)
      	  render 'messages/unreadMessages.js.erb'
      	end
      elsif params[:scope] == 'received'
      	get_all_received_messages(params[:start], 10, params[:receiver_id])
      	render 'messages/index.js.erb'
      else
      	render 'messages/index.html.erb'
      end
    
    end

    #Create Smile At Message
	def create

	  @message = current_user.messages.new(message_params)
	  if @message.save
	  	#Broadcast message to receiver
	  	 #EM.run do
	  	#	faye = Faye::Client.new('http://localhost:9292/faye')
	  	#	faye.publish("/message/"+@message.receiver_id.to_s, "text" => "Hello"+User.find(@message.receiver_id).name.to_s )
	  	#end

        
	  	render 'messages/broadcast.js.erb'  

	  else
	  	render 'root'
	  end
	end

	def destroy
		@message = Message.find_by_id(params[:id])
		@message.destroy
	end


	private

	  def message_params
	  	params.require(:message).permit(:sender_id, :receiver_id, :content, :read_state, :start)
	  end

	  def get_unread_messages(start, range, receiver_id, read_state)
	  	if start.to_i == 0
	  		@unreadMessages = Message.where(receiver_id: receiver_id, read_state: read_state).limit(range)
	  	else
	  		@unreadMessages = Message.where(receiver_id: receiver_id, read_state: read_state).limit(range).offset(start)
	  	end
	  end

	  def get_all_received_messages(start, range, receiver_id)
	  	if start.to_i == 0
	  		@allMessages = Message.where(receiver_id: receiver_id).limit(range)
	  	else
	  		@allMessages = Message.where(receiver_id: receiver_id).limit(range).offset(start)
	  	end
	  end
end
