P = function(v)
    print(hs.inspect(v))
end

-- widescreen monitor
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "2", function()
    local laptopScreen = "LC34G55T"
    local windowLayout = {
        { "Brave Browser", nil, laptopScreen, hs.layout.left50,  nil, nil },
        { "Zoom",          nil, laptopScreen, hs.layout.left50,  nil, nil },
        { "Slack",         nil, laptopScreen, hs.layout.right50, nil, nil },
        { "Alacritty",     nil, laptopScreen, hs.layout.right50, nil, nil },
    }
    hs.layout.apply(windowLayout)
end)

-- widescreen monitor
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "3", function()
    local laptopScreen = "LC34G55T"
    local windowLayout = {
        { "Brave Browser", nil, laptopScreen, hs.layout.left30,  nil, nil },
        { "Alacritty",     nil, laptopScreen, hs.layout.right70, nil, nil },
    }
    hs.layout.apply(windowLayout)
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "r", function()
    hs.reload()
end)

function MoveWindowToDisplay(d, fullScreen)
    return function()
        local displays = hs.screen.allScreens()
        local win = hs.window.focusedWindow()
        win:setFullScreen(false)
        hs.timer.doAfter(0.6, function()
            win:moveToScreen(displays[d], false, true, 0.)
            if fullScreen then
                hs.timer.doAfter(0.6, function()
                    win:setFullScreen(true)
                end)
            end
        end)
    end
end

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "1", MoveWindowToDisplay(1, true))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "2", MoveWindowToDisplay(2, true))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "3", MoveWindowToDisplay(3, true))

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "1", MoveWindowToDisplay(1))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "2", MoveWindowToDisplay(2))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "3", MoveWindowToDisplay(3))

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "k", function()
    hs.eventtap.keyStrokes("👆")
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "j", function()
    hs.eventtap.keyStrokes("👇")
end)

-- mouse
function MoveMouse(direction, x_delta, y_delta)
    return function()
        local current_mouse_coordinates = hs.mouse.absolutePosition()
        local new_mouse_coordinates
        if direction == "l" then
            new_mouse_coordinates = { x = current_mouse_coordinates["x"] + x_delta, y = current_mouse_coordinates["y"] }
        elseif direction == "h" then
            new_mouse_coordinates = { x = current_mouse_coordinates["x"] - x_delta, y = current_mouse_coordinates["y"] }
        elseif direction == "j" then
            new_mouse_coordinates = { x = current_mouse_coordinates["x"], y = current_mouse_coordinates["y"] + y_delta }
        else
            new_mouse_coordinates = { x = current_mouse_coordinates["x"], y = current_mouse_coordinates["y"] - y_delta }
        end
        hs.mouse.absolutePosition(new_mouse_coordinates)
    end
end

local mouse_x_delta = 600
local mouse_y_delta = 400

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "h", MoveMouse("h", mouse_x_delta, 0))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "l", MoveMouse("l", mouse_x_delta, 0))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "j", MoveMouse("j", 0, mouse_y_delta))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "k", MoveMouse("k", 0, mouse_y_delta))


hs.alert.show("Config loaded!")
