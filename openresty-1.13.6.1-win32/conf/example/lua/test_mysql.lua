local function close_db(db)
	 if not db then
	 	 return
	 end
	 db:close()
end


local mysql = require("resty.mysql")
local db , err = mysql:new()
if not db then
	ngx.say("new mysql error : ",err)
	return
end

db:set_timeout(1000)

local props = {
	host = "192.168.166.30",
	port = 3359,
	database = "club_group",
	user = "snstWriter",
	password = "snstWriter5t^Y7u*I"
}

local res,err,errno,sqlstate = db:connect(props)

if not res then
	ngx.say("connect to mysql error :",err,"errno:",errno,"  sqlstate :",sqlstate)
	return close_db(db)
end

-- local create_table_sql = "create table lua_test(id int primary key auto_increment,ch varchar(100))"
-- res,err,errno,sqlstate = db:query(create_table_sql)

-- if not res then 
-- 	 ngx.say("create table error:",err,"  , errno :",errno, " ,sqlstate :" , sqlstate)
-- 	 return close_db(db)	
-- end

--insert
local insert_sql = "insert into lua_test(ch) values('hello')"
res,err,errno,sqlstate = db:query(insert_sql)

if not res then 
	 ngx.say("insert_sql table error:",err,"  , errno :",errno, " ,sqlstate :" , sqlstate)
	 return close_db(db)	
end

ngx.say("insert rows :",res.affected_rows," , id :",res.insert_id,"<br/>")

--update
local update_sql = "update lua_test set ch='hello2' where id = "..res.insert_id
res,err,errno,sqlstate = db:query(update_sql)
if not res then 
	 ngx.say("update_sql error:",err,"  , errno :",errno, " ,sqlstate :" , sqlstate)
	 return close_db(db)	
end

ngx.say("update rows : ", res.affected_rows, "<br/>")  

--select
local select_sql = "select id,ch from lua_test"
res,err,errno,sqlstate = db:query(select_sql)
if not res then 
	 ngx.say("select table error:",err,"  , errno :",errno, " ,sqlstate :" , sqlstate)
	 return close_db(db)	
end

for i,row in ipairs(res) do
	for name,value in pairs(row) do
		ngx.say("select row ",i," : " , name , "  =  ",value,"<br/>")
	end
end

ngx.say("<br/>")

close_db(db)

