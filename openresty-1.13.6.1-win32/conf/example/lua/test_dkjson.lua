local dkjson = require("dkjson")

--lua to  json

local obj = {
	 id = 1,
	 name = "thushear",
	 age = 10,
	 is_male = false,
	 hobby = {"film","read"} 
}

local str = dkjson.encode(obj,{indent = true})
ngx.say(str,"<br/>")

-- str to obj
str = '{"hobby":["file","Read"],"is_male":false,"name":"thushear","id":1,"age":null}'

local obj,pos,err = dkjson.decode(str,1,nil)

ngx.say(obj.age,"<br/>")
ngx.say(obj.hobby[1],"<br/>")

-- circle ref
-- obj = {
-- 	id = 1
-- }
-- obj.obj = obj
-- ngx.say(dkjson.encode(obj),"<br/>")
