local cjson = require("cjson")

--lua对象到字符串

local obj = {
	 id = 1,
	 name = "thushear",
	 age = 10,
	 is_male = false,
	 hobby = {"film","read"} 
}

local str = cjson.encode(obj)
ngx.say(str,"<br/>")

--字符串到lua对象
str = '{"hobby":["file","Read"],"is_male":false,"name":"thushear","id":1,"age":null}'
local obj = cjson.decode(str)

ngx.say(obj.age,"<br/>")
ngx.say(obj.age == nil,"<br/>")
ngx.say(obj.hobby[1],"<br/>")

--

obj = {id = 1}
obj.obj=obj
--ngx.say(cjson.encode(obj),"<br/>")
local cjson_safe = require("cjson.safe")
ngx.say(cjson_safe.encode(obj),"<br/>")