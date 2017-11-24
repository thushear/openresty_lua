#!/usr/local/bin/lua
print("hello world")
 
--语法规则 变量定义

-- 数字类型
num = 1024
num = 3.0
num = 3.1415
num = 0xff
num = 0x56

-- 字符类型
a = 'alo\n123"'
a = 'alo\n123\"'
a = '\97lo\10\04923"'
a = [[alo
123"]]


-- while 语法
local sum = 0
local num = 0
while num <= 100 do
	sum = sum + num
	num = num + 1
end
print("while sum = ",sum..' num='..num)


-- if else 语法
local age = 0
if age == 40 and sex =="Male" then
    print("男人四十一枝花")
elseif age > 60 and sex ~="Female" then
    print("old man without country!")
elseif age < 20 then
    io.write("too young, too naive!\n")
else
    local age = io.read()
    print("Your age is "..age)
end

--for 循环
local all = 0
for i = 1,100 do
	all = all + i
end
print("all = "..all)

local total = 0
for i=1,100,2 do
	total = total + i
end
print("total :"..total)

local number  = 0
for i=100,1,-2 do 
	number = number + i
end
print("number = "..number)


--until
local multi = 2
repeat
   multi = multi^2 --幂操作
   print("multi = "..multi.."\n")
until multi > 1000


--函数
local function fib( n )
	-- body
	if n < 2 then return 1 end
	return fib(n - 2) + fib(n - 1)	
end

print("fib = ",fib(5))

--闭包

local function newcounter(  )
	-- body
	local i = 0
	return function() -- anonymous function
	   i = i + 1
	   return i
	end
end

incr = newcounter()

print(incr())
print(incr())

function  mypower( x )
	-- body
	return function(y) return y^x end
end

power2 = mypower(2)
power3 = mypower(3)

print("power2: " , power2(4))
print("power3: ",power3(4))


-- 赋值

local name,age,sex = 'thushear',23,'male','female'
print("name :"..name.." age : "..age.." sex:"..sex)


--函数可以返回多个返回值
local function getUserInfo(id)
	print(id)
	return "thushear",22,"male","thushear.github.io","beijing"
end

local name,age,sex,site = getUserInfo()
print("name :"..name.." age : "..age.." sex:"..sex.." site:"..site )


--table

table = {name = "thushear", age = 22, sex = 'male'}
print(table.name)
table.site = "thushear.github.io"
print(table.site)

table2 = {['username'] = "lucas",['age'] = 10,['handsome']=true}
print(table2['username'])

--array
array = {"thushear",22,function() print('github function') end }
print(array[3]())

for i=1,#array do
	print(array[i])
end

--遍历table
for k,v in pairs(table) do
	print(k,v)
end

--MetaTable MetaMethod

fraction_a = {fenzi = 2 , fenmu = 3}
fraction_b = {fenzi = 4 , fenmu = 7}

fraction_op = {}
function fraction_op.__add(f1, f2)
	ret = {}
	ret.fenzi = f1.fenzi*f2.fenmu + f2.fenzi*f1.fenmu
	ret.fenmu = f1.fenmu*f2.fenmu
	return ret
end

setmetatable(fraction_a,fraction_op)
setmetatable(fraction_b,fraction_op)

fraction_s = fraction_a + fraction_b
print("fenzi = "..fraction_s.fenzi.." fenmu = "..fraction_s.fenmu)


--面向对象

Person = {}

function Person:new( p )
	-- body
	local obj = p
	if (obj == nil) then
		obj = {name = "thushear",age = 22,handsome = true}
	end
	 self.__index = self
	 return setmetatable(obj,self)
end

function Person:toString()
	return self.name .." : ".. self.age .." : ".. (self.handsome and 'handsome' or 'ugly') 
end

me = Person:new()
print(me:toString())

fk = Person:new({name = "fk",age = 21,handsome=false})
print(fk:toString())

--模块

local mod = require("mod")
mod.greeting()


