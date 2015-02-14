#$redis = Redis.new(:host => 'localhost', :port => 6379)
#if $redis.llen("latestSmiles") == 0
#  smileids = Smile.select(:id).limit(3000)
#  if smileids.length > 3000
#  	smileids.map{|i| i.id.to_s }
#    j = 5000
#  	while  j > 0 do 
#  		$redis.lpush("latestSmiles", smileids[j-1])
#  		j -= j
#  	end
#  end
#end

