


-- local function close_redis(red)
--  if not red then
--    return
--  end
--  local ok,err = red:close()
--  if not ok then
--   ngx.say("close redis error:",err)
--  end
-- end

local function close_redis( red )
	if not red then
		return
	end
	local pool_max_idle_time = 10000
	local pool_size = 100
	local ok, err = red:set_keepalive(pool_max_idle_time,pool_size)
	if not ok then
	  ngx.say("set keepalive error:",err)
	end
end


local redis = require("resty.redis")

local red = redis:new()
red:set_timeout(1000)
local ip = "127.0.0.1"
local port = 6660
local ok,err = red:connect(ip,port)

if not ok then 
  ngx.say("connect to redis error :",err)
 return close_redis(red)
end

local resp, err = red:eval("return redis.call('get',KEYS[1])",1,"msg")

ngx.say("msg :" , resp,"<br/>")

local sha1 ,err = red:script("load","return redis.call('get',KEYS[1])")
if not sha1 then
	 ngx.say("load script error :" , err)
end
ngx.say("sha1 :" , sha1,"<br/>")	 
local resp1, err1 = red:evalsha(sha1,1,"msg")
ngx.say("resp1 :" , resp2,"<br/>")
close_redis(red)

