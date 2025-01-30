-- Color HUE v1.0
-- https://canadianboy.itch.io/
-- https://x.com/CaBoyGames
-- https://www.youtube.com/channel/UCmmzLu420aO14Mf71l2zUKg

-- main variables
local dlg
local autoPickLeft = false;
local autoPickMiddle = true;
local autoPickRight = false;
local fgListenerCode;
local bgListenerCode;
local eyeDropper = true;
local huesNumber = 2;
local advanceMode = true;

-- BG AND FG COLORS
local LColor = Color{ r=15, g=15, b=30, a=255 };
local MColor = app.fgColor;
local RColor = Color{ r=245, g=245, b=230, a=255 };

local startingColors = {LColor, MColor, RColor};

local huesShade = {}

-- main functions ------------------------------------------------------------------

function hueShifter(color3, color4, i, numHues)
    local color1 = Color(color3)
    local color2 = Color(color4)

    -- Find the slopes of each component of both colors
    local m = {
        r=(color1.red - color2.red),
        g=(color1.green - color2.green),
        b=(color1.blue - color2.blue),
        a=(color1.alpha - color2.alpha)
    }

    -- Linearly find the colors between the two initial colors
    local newRed = color1.red - math.floor(m.r * i / numHues)
    local newGreen = color1.green - math.floor(m.g * i / numHues)
    local newBlue = color1.blue - math.floor(m.b * i / numHues)
    local newAlpha = color1.alpha - math.floor(m.a * i / numHues)

    local newC = Color{r=newRed, g=newGreen, b=newBlue, a=newAlpha}

    return newC
end

--- debug function for print tables ------- print("en:", dumpTB(ev))----------------
function dumpTB(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dumpTB(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

-- custom functions ----------------------------------------------------------------

local function calculateColors()
    huesShade = {}
    huesShade[1] = LColor
    for i = 1, huesNumber do
        huesShade[i + 1] = hueShifter(LColor, MColor, i  , huesNumber +1);
    end
    huesShade[#huesShade + 1] = MColor;
    if(advanceMode) then
      local lenght = #huesShade;
      for i = 1, huesNumber do
        huesShade[lenght + i] = hueShifter(MColor, RColor, i  , huesNumber +1);
      end
      huesShade[#huesShade + 1] = RColor
    end
end

local function updateDialogData()

  if(advanceMode) then
    startingColors = {LColor, MColor, RColor}
    -- enabled = true;
    dlg:modify{ id="check_right", visible = true }

  else

    dlg:modify{ id="check_right", visible = false }
    startingColors = {LColor, MColor}

  end


  dlg:modify{ id="base",
    colors = startingColors;
  }
  dlg:modify{ id="hue",
    colors = huesShade;
  }

end

local function oneShadesClick(ev)
  eyeDropper = false;
      
  if(ev.button == MouseButton.LEFT) then
    app.fgColor = ev.color

  elseif(ev.button == MouseButton.RIGHT) then

    app.bgColor = ev.color

  elseif(ev.button == MouseButton.MIDDLE) then
    app.fgColor = ev.color
    calculateColors();
    updateDialogData();
  end

end

local function updateColorSetDialog(L, M, R)
  autoPickLeft = L;
  autoPickMiddle = M;
  autoPickRight = R;

  dlg:modify{ id="check_left",
    selected = autoPickLeft;
  }
  dlg:modify{ id="check_m",
    selected = autoPickMiddle;
  }
  dlg:modify{ id="check_right",
    selected = autoPickRight;
  }

end

local function createDialog()

  MColor = app.fgColor;

  dlg = Dialog {
  title = "Color Hue v2.0",
  onclose = function()
   --onDialog close
   app.events:off(fgListenerCode)
   app.events:off(bgListenerCode)
  
  end
  }

  -- DIALOGUE
  dlg:
  shades {
     -- SAVED COLOR BASES
    id = "base",
    label = "Base",
    focus= true,
    colors = startingColors,
    onclick = function(ev)

        -- if(ev.color == LColor and ev.color == RColor) then
        --     LMFSet = not(LMFSet);
        -- elseif(ev.color == LColor) then
        --     LMFSet = true;
        -- elseif(ev.color == RColor) then
        --     LMFSet = false;
        -- end

      calculateColors();
      updateDialogData();
    end
}:check{ 
  id = "check_left",
  label = "Pick",
  text = "L",
  selected = autoPickLeft,
  onclick = function()

    updateColorSetDialog(not autoPickLeft, false, false);
  end
}:check{ 
  id = "check_m",
  text = "M",
  selected = autoPickMiddle,
  onclick = function()

    updateColorSetDialog(false, not autoPickMiddle, false);
  end
}:check{ 
  id = "check_right",
  text = "R",
  selected = autoPickRight,
  onclick = function()

    updateColorSetDialog(false, false, not autoPickRight);
  end
}:slider{ 
    id="num_hues", 
    label="Colors", 
    min=1,
    max=8, 
    value=huesNumber,
    onrelease = function(ev)
      huesNumber = dlg.data["num_hues"]
      calculateColors();
      updateDialogData();
    end
}:shades {
     -- HUE
    id = "hue",
    label = "Hue",
    colors = huesShade,
    onclick = function(ev)
      oneShadesClick(ev)

    end
  }
  -- :button{ 
  --   id="reset",
  --   text="Reset",
  --   onclick = function()
  --     local LColor = Color{ r=15, g=15, b=30, a=255 };
  --     -- local MColor = app.fgColor;
  --     local RColor = Color{ r=245, g=245, b=230, a=255 };
  --     updateColorSetDialog(false, true, false);
  --   end
  -- }:newrow()
  :button{ 
    id="get",
    text="Add to Palette",
    onclick = function()
      local palette = app.activeSprite.palettes[1]
      local ncolors = #palette
      local pCount = ncolors + #huesShade
      palette:resize(pCount)
      for i = ncolors, pCount-1 do
        palette:setColor(i, huesShade[i - ncolors +1])
      end
    end
  }:check{ 
    id = "check",
    label = "Advanced",
    selected = advanceMode,
    onclick = function()
      advanceMode = not advanceMode;

      calculateColors();
      updateDialogData();

    end
  }


  dlg:show {wait = false}
end


local function onFgChange()
  if(eyeDropper == true) then
    if(autoPickLeft == true) then
        LColor = app.fgColor;
    elseif(autoPickMiddle == true) then
        MColor = app.fgColor;
    elseif(autoPickRight == true) then
        RColor = app.fgColor;
    end
    calculateColors();
    updateDialogData();
  elseif(eyeDropper == false) then
    --print("inside shades")
  end
  eyeDropper = true;
end

-- run the script ------------------------------------------------------------------
do
  calculateColors();
  createDialog();
  fgListenerCode = app.events:on('fgcolorchange', onFgChange);
  bgListenerCode = app.events:on('bgcolorchange', onFgChange);
end