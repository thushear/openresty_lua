


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

red:init_pipeline()
red:set("msg1","hello1")
red:set("msg2","hello2")
red:get("msg1")
red:get("msg2")
local respTable,err = red:commit_pipeline()

if respTable == ngx.null then
  respTable = {}
end 

for k,v in pairs(respTable) do
	print(k,v)
	ngx.say("msg :",v,"<br/>")
end

close_redis(red)

