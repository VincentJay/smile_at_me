module ApplicationHelper
	def full_title(page_title)
		base_title = "SmileAtMe"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def broadcast(channel, &block)
      message = {:channel => channel, :data => capture(&block)}
      uri = URI.parse("http://localhost:9292/faye")
      Net::HTTP.post_form(uri, :message => message.to_json)
   end

end
