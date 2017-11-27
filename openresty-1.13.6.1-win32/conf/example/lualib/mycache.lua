local lrucache = require("resty.lrucache")

local cache, err = lrucache.new(200)
if not cache then
	ngx.log(ngx.ERR,"create cache error :",err)
end

local function set( key , value,ttlInSeconds )
	-- body
	cache:set(key,value,ttlInSeconds)
end

local function get( key )
	-- body
	return cache:get(key)
end

local _M = {
	set = set,
    get = get
}
return _M