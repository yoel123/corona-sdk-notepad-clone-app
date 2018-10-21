local widget = require( "widget" )
local ye = {}

function ye:new()
   o =  mymathmodule:new()
   setmetatable(o, self)
   self.__index = self
   
   return o
end

function ye:split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end--split

function ye:txt(str, x, y, font_size)
   local myText = display.newText( str, x, y, native.systemFont, font_size )--corona text objext
   return myText
end--txt

function ye:rect( x, y, w,h)
  
  local myRectangle = display.newRect( x, y, w,h )

  myRectangle:setFillColor( 0.5 )
  
  return myRectangle
  
end--rect

function ye:circle( x, y, r)
  
  local myCircle = display.newCircle( x, y, r )
  myCircle:setFillColor( 0.5 )
  
  return myCircle
  
end--circle

function ye:line( x1, y1, x2,y2,s)
  
  local line = display.newLine(x1, y1, x2,y2 )

  line:setStrokeColor( 1, 0, 0, 1 )
  line.strokeWidth = s
  return line
  
end--line

--[[
local sequenceData =
{
    { name="walking", start=1, count=3 },
    { name="running", frames={ 3, 4, 5, 6, 7, 8 }, time=120, loopCount=4 },
    { name="jumping", start=9, count=13, time=300 }
}


local ops =
{
    --required parameters
    width = 50,
    height = 50,
    numFrames = 3,
     
    --optional parameters; used for scaled content support
    sheetContentWidth = 150,  -- width of original 1x size of entire sheet
    sheetContentHeight = 50   -- height of original 1x size of entire sheet
}

--]]

function ye:sprite( img,ops, sequenceData)
  local imageSheet = graphics.newImageSheet(img,ops )
  local character = display.newSprite( imageSheet, sequenceData )
  return character
  
end--sprite

--------------------------widgets----------------------
function ye:btn(x,y,arr)
   local button = widget.newButton
  {
    parent = arr.p,
    defaultFile = arr.df or "",
    overFile = arr.of or "",
    label = arr.txt or "",
    labelColor = { default= arr.dc or { 1, 1, 1 }, over=arr.oc or { 1, 1, 1 } },
    emboss = arr.emb or true,
    onPress = arr.func or nil,
    
  }
  button.x = x; button.y = y
  return button
end--btn

function ye:txtbox(x,y,w,h,is_box)
 
 if(is_box)then
 
  txt =  native.newTextBox( x,y,w,h) 
  txt.isEditable = true
  return txt
 end--if
 txt =  native.newTextField( x,y,w,h )
 return txt
end--btn

function ye:radio_group(x,y,arr)
  switches = {}
  oriantation = arr.oriant or "vert"
  
  txt_r = arr.txt_r or {"test"}
  
  ret = {
    txts={},radios ={},
    radioGroup = display.newGroup()
    } --return array
  
  if(oriantation == "vert")then
     for i,v in ipairs(txt_r) do
       --create radio txt
      ret.txts[i] = display.newText( v, x+arr.txt_x,y+ (45*i), native.systemFont, 16 )
      ret.txts[i]:setFillColor( 1, 1, 1 )
      --create  radio btn
    print("in "..i)
      switches[i] = widget.newSwitch(
          {
            left = x,
            top = y + (35*i),
            style = "radio",
            id = i,
            onPress = arr.onSwitchPress or nil
          }--end switch
        )--end newSwitch
      
      ret.radioGroup:insert(switches[i])
      --scene:insert( self.qtxts[i] )
    end--for txt_r
  end --if vert
  
  ret.radios = switches
  return ret;
end--radio box

function ye:combo_box(x2,y,arr)
  
  local columnData =
  {
      {
          align = arr.txt_alighn or"center",
          width = arr.width or 150,
          startIndex =arr.start_index or 2,
          labels = arr.data or {},
      },
  }--end columnData
  
  local cb = widget.newPickerWheel(
  {
      left = x2 or 0,
      top = y or 0,
      columns = columnData,
      style = "resizable",
      width = arr.width or 150,
      rowHeight =arr.row_h or 10,
      fontSize = arr.font_size or 14
  })

  return cb
  
end--combo_box


function ye:checkbox(x,y,arr)
  
  txt = arr.txt or ""
  txt_do= display.newText( txt, x+arr.txt_x,y+15, native.systemFont, 16 )
  local checkboxButton = widget.newSwitch(
    {
        left = x,
        top = y,
        style = "checkbox",
        id = "Checkbox",
        onPress = arr.onSwitchPress or nil
    }
)
  return checkboxButton
 end--checkbox

function ye:set_theme(n)
 
 tms = {"widget_theme_ios",
   "widget_theme_android_holo_light",
   "widget_theme_android",
   "widget_theme_ios7",
   "widget_theme_android_holo_dark"--5
   }
 
widget.setTheme( tms[n] )
end--set theme

function ye:scroll_v(x,y,arr)
  arr = arr or {}
  local scrollView = widget.newScrollView(
    {
      
        left = x,
        top = y,
        
        width = arr.w or 300,
        height =arr.h or 400,
        scrollWidth = 400,
        scrollHeight = 100,

    }
  )
 -- scrollView.isBounceEnabled = false
  return scrollView
 end -- scroll view
 
 --------------------------end widgets----------------------
 
 --------------------------file io----------------------
 function ye:save_txt(saveData,filename)
   filename = filename or "bla.txt"
  -- Path for the file to write
  local path = system.pathForFile( filename, system.DocumentsDirectory )
   
  -- Open the file handle
  local file, errorString = io.open( path, "w" )
   
  if not file then
      -- Error occurred; output the cause
      print( "File error: " .. errorString )
      return false
  else
      -- Write data to file
      file:write( saveData )
      -- Close the file handle
      io.close( file )
      return true
  end
   
  file = nil
end --save_txt

 function ye:get_txt_file(filename)
   local contents =""
     -- Path for the file to read
  local path = system.pathForFile( filename, system.DocumentsDirectory )
   print(system.DocumentsDirectory)
  -- Open the file handle
  local file, errorString = io.open( path, "r" )
   
  if not file then
      -- Error occurred; output the cause
   --   print( "File error: " .. errorString )
  else
      -- Read data from file
       contents = file:read( "*a" )
      -- Output the file contents
    -- print( "Contents of " .. path .. "\n" .. contents )
      -- Close the file handle
      io.close( file )
  end
   
  file = nil
   return  contents
end--get_txt_file
  --------------------------end file io----------------------

return ye