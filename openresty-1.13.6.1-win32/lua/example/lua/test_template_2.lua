local template = require("resty.template")
--是否缓存解析后的模板，默认true  
template.caching(true)
--渲染模板需要的上下文
local context = {title = "title"}
--渲染模板
template.render("t1.html",context)

ngx.say("<br/>")

--编译得到一个lua函数
local func = template.compile("t1.html")
--执行函数
local content = func(context)
--ngx api
ngx.say(content)

