local common = require("common")
local read_redis = common.read_redis
local read_http = common.read_http

local ngx_log = ngx.log
local ngx_ERR = ngx.ERR
local ngx_exit = ngx.exit
local ngx_print = ngx.print
local ngx_re_match = ngx.re.match
local ngx_var = ngx.var
local skuId = ngx_var.skuId

local desckey = "d:"..skuId..":"
local descValue = read_redis("127.0.0.1",1111,{desckey})
if not descValue then
  ngx_log(ngx_ERR,"redis not found desc info back to http",skuId)
  descValue = ""
end

if not descValue then
	return ngx_exit(404)
end

ngx_print("showdesc(")
ngx_print(descValue)
ngx_print(")")
