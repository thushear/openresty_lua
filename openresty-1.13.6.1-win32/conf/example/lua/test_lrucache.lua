local mycache = require("mycache")
local count = mycache.get("count") or 0
print(count)
count = count + 1
mycache.set("count",count,10*60*60)
ngx.say(mycache.get("count"))