-- CaBoy Preview v1.0
-- Created and copyrighted by CanadianBoy
-- https://canadianboy.itch.io/
-- https://x.com/CaBoyGames
-- https://www.youtube.com/channel/UCmmzLu420aO14Mf71l2zUKg

-- variables -------------------------------------------------------------------------

-- main refrences --
local dlg
local dlgOptions
local optionsIsShowing = false
local sprite = app.sprite
local spriteChangeListener
local siteChangeListener

-- options variables --
local timer 
local currentFrame = 0
local offsetX = 0
local offsetY = 0
local tileWidth = 32
local tileHeight = 32
local animLength = 4
local animLooping = true
local verticalMode = false
local zoomLevel = 4
local timeMuliplier = 100
local isShowingChekers = true
local isShowingTileBack = false

-- temp variables --
local prevWidth = tileWidth * zoomLevel
local prevHeight = tileHeight * zoomLevel

-- functions ------------------------------------------------------------------

-- helper function
local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

local function createTimer()
    -- handle time muliplier live change
    local tempIsRunning = false
    if timer ~= nil and timer.isRunning then
        timer:stop()
        tempIsRunning = true
    end

    timer = Timer{
        interval = timeMuliplier/1000,
        ontick=function()
            if animLength == 1 or currentFrame >= animLength-1 then
                currentFrame = 0
                -- stop if looping is false
                if not animLooping then
                    timer:stop()
                    local temp_bound = dlg.bounds 
                    dlg:modify{ id="play_btn", text=">" }
                    dlg.bounds = temp_bound
                end
            else
                currentFrame = currentFrame + 1
            end
            dlg:repaint()
        end 
    }

    if tempIsRunning then
        timer:start()
    end
end

local function clampValue(x, min, max)
    if x < min then return min end
    if x > max then return max end
    return x
end

-- change zoom level
local function changeZoomLevel(value) 
    local sprite = app.sprite
    zoomLevel = clampValue(value, 0.5, 100);
    prevWidth = tileWidth * zoomLevel 
    prevHeight = tileHeight * zoomLevel 
    dlg:repaint()
    dlgOptions:modify{id="zoom_level", value = math.floor(value)}
end

-- background checker pattern
local function drawBack(gc, canvas_w, canvas_h)
    -- Background Grid
    local docPref = app.preferences.document(app.sprite)
    local color_a = docPref.bg.color1
    local color_b = docPref.bg.color2
    local colors = {color_a, color_b}
    local size = 16 *zoomLevel

    for i=0, canvas_w/size, 1 do
        for j=0, canvas_h/size, 1 do
            gc.color = colors[(i+j)%2 + 1]
            gc:fillRect(Rectangle(i * size, j*size, size, size))
        end
    end
    -- gc.color = Color(255, 255, 255, 255)

end

-- options dialog --------------------------------------------------------------------
local function createOptionsDialog()
    dlgOptions =
        Dialog {
        title = "Options",
        onclose = function(ev)
            --onDialog close
            optionsIsShowing = false
        end
    }

    dlgOptions
    :number{ 
        id="x_pos",
        label="Offset",
        text="0",
        decimals=integer,
        onchange=function(ev)
            --TODO size bigger than sprite cause bug
            local value = math.abs(tonumber(dlgOptions.data["x_pos"]))
            dlgOptions:modify{id="x_pos", text = value}
            offsetX = value
            dlg:repaint()
        end
    }:number{ 
        id="y_pos",
        text="0",
        decimals=integer,
        onchange=function(ev)
            --TODO size bigger than sprite cause bug
            local value = math.abs(tonumber(dlgOptions.data["y_pos"]))
            dlgOptions:modify{id="y_pos", text = value}
            offsetY = value
            dlg:repaint()
        end
    }
    :newrow()
    :number{ 
        id="tile_size_width",
        label="Tile size",
        text="32",
        decimals=integer,
        onchange=function(ev)
            local value = math.abs(tonumber(dlgOptions.data["tile_size_width"]))
            if value == 0 then
                value = 1
            end
            dlgOptions:modify{id="tile_size_width", text = value}
            tileWidth = value
            prevWidth = tileWidth * zoomLevel
            dlg:repaint()
        end
    }
    :number{ 
        id="tile_size_height",
        text="32",
        decimals=integer,
        onchange=function(ev)
            local value = math.abs(tonumber(dlgOptions.data["tile_size_height"]))
            if value == 0 then
                value = 1
            end
            dlgOptions:modify{id="tile_size_height", text = value}
            tileHeight = value
            prevHeight = tileHeight * zoomLevel
            dlg:repaint()
        end
    }
    :newrow()
    :number{ 
        id="length",
        label="Length",
        text="4",
        decimals=integer,
        onchange=function(ev)
            local value = math.abs(tonumber(dlgOptions.data["length"]))
            if value == 0 then
                value = 1
            end
            dlgOptions:modify{id="length", text = value}
            animLength = value
        end
    }
    :check{ 
        id="anim_loop",
        label="Anim",
        text="Looping",
        selected=true,
        onclick=function(ev)
            animLooping = dlgOptions.data["anim_loop"]
        end
    }
    :check{ 
        id="vertical_mode",
        text="Vertical Mode",
        selected=false,
        onclick=function(ev)
            verticalMode = dlgOptions.data["vertical_mode"]
        end
    }
    :slider{ 
        id="zoom_level",
        label="Zoom",
        min=0,
        max=100,
        value=4,
        onchange=function(ev)
            value = dlgOptions.data["zoom_level"]
            changeZoomLevel(value)
        end,
        onrelease=function(ev)

        end 
    }:number{ 
        id="time_muliplier",
        label="Time Multiplier %",
        text="100",
        decimals=integer,
        onchange=function(ev)
            local value = math.abs(tonumber(dlgOptions.data["time_muliplier"]))
            if value == 0 then
                value = 1
            end
            timeMuliplier = value
            createTimer()
            dlgOptions:modify{id="time_muliplier", text = value}
        end
    }
    :check{ 
        id="check_back",
        label="Background",
        text="Checkers",
        selected=true,
        onclick=function(ev)
            isShowingChekers = dlgOptions.data["check_back"]
            dlg:repaint()
        end
    }
    :check{ 
        id="back_color",
        text="TileBack",
        selected=false,
        onclick=function(ev)
            isShowingTileBack = dlgOptions.data["back_color"]
            dlg:repaint()
        end
    }
end

-- main dialog onClick functions -----------------------------------------------------
local function updateTilte()
    -- if timer ~= nil and timer.isRunning then
    --     dlg:modify{ title = " Play"}
    -- else
    --     dlg:modify{ title = " " .. (currentFrame+1) .. " / " .. animLength}
    -- end
end

local function onClickOptions()
    if optionsIsShowing then 
        optionsIsShowing = true
        dlgOptions:close()
    else
        optionsIsShowing = true
        dlgOptions:show {wait = false, bounds = windowBounds}
    end
end

local function onClickSet()
    local spr = app.activeSprite
    local selection = spr.selection
    local bounds = selection.bounds;

    if selection.isEmpty then 
        app.alert("First you need to select a region then click this button!")
    else

        -- x pos
        local valueX = math.abs(bounds.x)
        dlgOptions:modify{id="x_pos", text = valueX}
        offsetX = valueX

        -- y pos
        local valueY = math.abs(bounds.y)
        dlgOptions:modify{id="y_pos", text = valueY}
        offsetY = valueY

        -- width
        local valueWidth = math.abs(bounds.width)
        if valueWidth == 0 then
            valueWidth = 1
        end
        dlgOptions:modify{id="tile_size_width", text = valueWidth}
        tileWidth = valueWidth;
        prevWidth = tileWidth * zoomLevel;

        -- height
        local valueHeight = math.abs(bounds.height)
        if valueHeight == 0 then
            valueHeight = 1
        end
        dlgOptions:modify{id="tile_size_height", text = valueHeight}
        tileHeight = valueHeight
        prevHeight = tileHeight * zoomLevel

        currentFrame = 0
        dlg:repaint()

    end
end

local function onClickPlay()
    local temp_bound = dlg.bounds 
    if timer ~= nil and timer.isRunning then
        dlg:modify{ id="play_btn", text=">" }
        timer:stop()
    else
        dlg:modify{ id="play_btn", text="[ ]" }
        timer:start()
    end
    -- updateTilte()
    dlg.bounds = temp_bound
end

local function onClickPreview()
    -- stop if playing
    if timer ~= nil and timer.isRunning then
        onClickPlay()
    end

    if animLength == 1 then
        currentFrame = 0
    elseif currentFrame == 0 or currentFrame > animLength-1 then
        currentFrame = animLength -1
    else
        currentFrame = currentFrame - 1
    end

    -- updateTilte()
    dlg:repaint()
end

local function onClickNext()
    -- stop if playing
    if timer ~= nil and timer.isRunning then
        onClickPlay()
    end

    if animLength == 1 or currentFrame >= animLength-1 then
        currentFrame = 0
    else
        currentFrame = currentFrame + 1
    end
    
    -- updateTilte()
    dlg:repaint()
end

-- canvas dialog ------------------------------------------------------------------
local function createDialog()
    dlg =
      Dialog {
      title = "CaBoy Preview",
      onclose = function(ev)
        --onDialog close
        timer:stop()
        dlgOptions:close()
        sprite.events:off(spriteChangeListener)
        app.events:off(siteChangeListener)
      end
    }
  
    dlg:
    canvas{
        id = "canvas_item",
        width = 32 * zoomLevel * 1.5,
        height = 32 * zoomLevel * 1,
        hexpand = true,
        vexpand = true,
        autoscaling=true,
        -- trimOutside=true,
        onwheel=function(ev) 
            local zoomSpeed = 1;
            if zoomLevel >= 10 then
                zoomSpeed = zoomLevel/10;
            end
            local value = math.floor(zoomLevel + ev.deltaY * (-zoomSpeed))
            changeZoomLevel(value)
        end,
        onpaint = function(ev)
            if app.sprite == nil then
                return
            end
            
            local gc = ev.context
            
            -- offset to draw tile in center of canvas
            local xCenter = (gc.width - prevWidth)/2
            local yCenter = (gc.height - prevHeight)/2
            
            -- get sprite image -------------
            local spriteImage = Image(app.sprite.width, app.sprite.height )
            spriteImage:drawSprite(app.sprite, app.frame )

            -- handle aseprite transparency bug!
            local img = Image(app.sprite.width, app.sprite.height)
            if not isShowingTileBack then
                img:clear(Color {r = 255, g = 255, b = 255, a = 1})
            else
                img:clear(Color {r = 255, g = 255, b = 255, a = 255})
            end
            img:drawImage(spriteImage)
            spriteImage = img

            -- source rect annd dist rect
            local srcRect
            local distRect = Rectangle(xCenter, yCenter, prevWidth, prevHeight)
            
            -- handle vertical mode
            if not verticalMode then
                srcRect = Rectangle(offsetX + (tileWidth * currentFrame), offsetY, tileWidth, tileHeight)
            else
                srcRect = Rectangle(offsetX, offsetY + (tileHeight * currentFrame), tileWidth, tileHeight)
            end

            -- Draw Backgrounds
            if isShowingChekers then
                drawBack(gc, gc.width, gc.height)
            end
            
            -- if isShowingTileBack then
                -- gc.color = Color {r = 255, g = 255, b = 255, a = 255}
                -- gc:fillRect(distRect)
                -- gc.blendMode = BlendMode.DARKEN
            -- end

            gc:drawImage(spriteImage, srcRect, distRect)
        end
    }
    :button{
        id = "back_btn", 
        text="<-",
        onclick = function(ev) 
            onClickPreview()
        end
    }
    :button{
        id = "play_btn",
        text= ">",
        onclick = function(ev) 
            onClickPlay()
        end
    }
    :button{ 
        id = "next_btn", 
        text="->",
        onclick = function(ev) 
            onClickNext()
        end
    }
    :button{ 
        id = "set_btn", 
        text="set",
        onclick = function(ev) 
            onClickSet()
        end
    }
    :button{ 
        id = "option_btn", 
        text="Opt",
        onclick = function(ev)
            onClickOptions() 
        end
    }

    createOptionsDialog()

    dlg:show {wait = false, bounds = windowBounds}
  end

-- listiners -----------------------------------------------------------------------
local function onSpriteChange(ev)
    if not timer.isRunning then
        dlg:repaint()
    end
end

local function onSitehange(ev)
    -- TODO prevent from layer change
    -- just for sprite change but also called in layer change!
    
    -- remove events when user navigate between sprites or close it
    -- add event to new sprite
    if app.sprite ~= nil then
        sprite.events:off(spriteChangeListener)
        app.events:off(siteChangeListener)
        sprite = app.sprite
        spriteChangeListener = sprite.events:on('change', onSpriteChange)
        siteChangeListener = app.events:on('sitechange', onSitehange)
        dlg:repaint()
    end
    
end
  
-- run the script ------------------------------------------------------------------
do
    -- if user run script from home page!
    if app.sprite == nil then 
        app.alert("You should open a sprite first. - CanadianBoy.itch.io -")
        return 
    end
    createTimer()
    createDialog()
    spriteChangeListener = app.sprite.events:on('change', onSpriteChange)
    siteChangeListener = app.events:on('sitechange', onSitehange)
end

--TODO Bug on sprite change