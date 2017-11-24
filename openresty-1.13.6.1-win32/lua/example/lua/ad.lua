local redis = require("resty.redis")
local cjson = require("cjson")
local cjson_encode = cjson.encode
local ngx_log = ngx.log
local ngx_ERR = ngx.ERR

local ngx_exit = ngx.exit

local ngx_print = ngx.print
local ngx_re_match = ngx.re.match
local ngx_var = ngx.var

local function close_redis( red )
	-- body
	if not red then
		return
	end
	--释放连接(连接池实现)  
	local pool_max_idle_time = 10000 --ms
	local pool_size = 100 --
	local ok,err = red:set_keepalive(pool_max_idle_time,pool_size)
	if not ok then
		ngx_log(ngx_ERR,"set redis keepalive error :",err)
	end

end

local function read_redis( id )
	-- body
	local red = redis:new()
	red:set_timeout(1000)
	local ip = "127.0.0.1"
	local port = 1111
	local ok,err = red:connect(ip,port)
	 ngx_log(ngx_ERR,"ok get redis ok : ", ok)
	if not ok then
		ngx_log(ngx_ERR,"connect to redis error :" , err)
		return close_redis(red)
	end

    local resp,err = red:get(id)
    ngx_log(ngx_ERR,"resp get redis resp : ", resp)
    if not resp then
    	ngx_log(ngx_ERR,"get redis content error : ",err)
    	return close_redis(red)
    end

    if resp  == ngx.null then
    	resp = nil
    end

    close_redis(red)    
    return resp
end

local function read_http( id )
	-- body
	local resp = ngx.location.capture("/backend/ad",{
			method = ngx.HTTP_GET,
			args = {id = id}
		})
	if not resp then
		ngx_log(ngx_ERR,"request error:",err)
		return
	end

	if resp.status ~= 200 then
		ngx_log(ngx_ERR,"request error,status:",resp.status)
		return
	end
	return resp.body
end

--id 
local id = ngx_var.id
ngx_log(ngx_ERR,"  id : ",id)
--read redis
local content = read_redis(id)

if not content then
  ngx_log(ngx_ERR,"redis not found id :",id)
  content = 'read http'
end

if not content then
  ngx_log(ngx_ERR,"http not found id :",id)
  return ngx_exit(404)
end

--content
ngx.print("show_ad(")
ngx.print(cjson_encode({content = content}))
ngx.print(")")


