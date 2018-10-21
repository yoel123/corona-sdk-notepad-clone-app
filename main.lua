ye = require("ye")
--[[
  -write the filname in the text_title input so save the file with that name (press save)
  -write the file name and press load to load it
]]--
--init
btn_bg = {"btns/buttonRed.png","btns/buttonRedOver.png"}
local text_title
local text_content

-----------------logic---------------------


local function ysave( event )

    file = text_title.text..".txt"--filname plus .txt
    ye:save_txt(text_content.text,file)--save the file
    print("save pressed "..text_title.text.." "..text_content.text)

end--save

local function yload( event )
 
    file = text_title.text..".txt"
    content = ye:get_txt_file(file)--get content from file
    text_content.text = content;--set it to the content textarea
    print("load pressed "..text_title.text)
end--load


-----------------end logic---------------------

-------------gui--------------

btn_save = ye:btn(155,20,{df=btn_bg[1],of=btn_bg[2],txt="save",func = ysave})
btn_load = ye:btn(155,80,{df=btn_bg[1],of=btn_bg[2],txt="load",func = yload})

top_txt = ye:txt("filename (for save/load):", 160, 150, 18)

text_title = ye:txtbox(160,190,280,40)

mid_txt = ye:txt("content:", 160, 250, 18)

text_content = ye:txtbox(170,390,296,240,true)
text_content.size = 18

-------------end gui--------------