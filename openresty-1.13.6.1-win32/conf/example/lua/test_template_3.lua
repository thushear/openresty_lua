local template = require("resty.template")

local context = {
	title = "test",
    name = "thushear",
    description = "<script>alert(1);</script>",
    age = 20,
    hobby = {"movie","music"},
    score = {语文 = 90, 数学 = 80, 英语 = 70},  
     score2 = {  
        {name = "语文", score = 90},  
        {name = "数学", score = 80},  
        {name = "英语", score = 70},  
    }  
}

template.render("t3.html",context)