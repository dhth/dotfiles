require("hs.ipc")
-- I've hacked the hs install process by installing it at
-- /opt/homebrew/bin/hs
-- following: https://github.com/Hammerspoon/hammerspoon/issues/2930#issuecomment-899092002
-- run: hs.ipc.cliInstall("/opt/homebrew") the first time

P = function(v)
    print(hs.inspect(v))
end

-- widescreen monitor
hs.hotkey.bind({ "cmd", "alt", "shift", "ctrl" }, "q", function()
    -- local laptopScreen = "LC34G55T"
    local screen = hs.screen.mainScreen()
    local windowLayout = {
        { "Brave Browser", nil, screen, hs.layout.left50,  nil, nil },
        { "Zoom",          nil, screen, hs.layout.left50,  nil, nil },
        { "Slack",         nil, screen, hs.layout.right50, nil, nil },
        { "Alacritty",     nil, screen, hs.layout.right50, nil, nil },
    }
    hs.layout.apply(windowLayout)
end)

-- widescreen monitor
hs.hotkey.bind({ "cmd", "alt", "shift", "ctrl" }, "w", function()
    -- local laptopScreen = "LC34G55T"
    local screen = hs.screen.mainScreen()
    local windowLayout = {
        { "Brave Browser", nil, screen, hs.layout.left30,  nil, nil },
        { "Alacritty",     nil, screen, hs.layout.right70, nil, nil },
    }
    hs.layout.apply(windowLayout)
end)

function ResizeWindow(direction)
        if not direction then
            return
        end
        local screen = hs.screen.mainScreen()
        local focussedApp = hs.application.frontmostApplication()
        local rect
        if direction == "left50" then
            rect = hs.layout.left50
        elseif direction == "right50" then
            rect = hs.layout.right50
        elseif direction == "left30" then
            rect = hs.layout.left30
        elseif direction == "right30" then
            rect = hs.layout.right30
        elseif direction == "left70" then
            rect = hs.layout.left70
        elseif direction == "right70" then
            rect = hs.layout.right70
        end
        local windowLayout = {
            { focussedApp, nil, screen, rect, nil, nil },
        }
        hs.layout.apply(windowLayout)
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "r", function()
    hs.reload()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "c", hs.toggleConsole)

function MoveWindowToDisplay(d)
    return function()
        local displays = hs.screen.allScreens()
        local win = hs.window.focusedWindow()
        local isFullScreen = win:isFullScreen()
        win:setFullScreen(false)
        hs.timer.doAfter(0.6, function()
            win:moveToScreen(displays[d], false, true, 0.)
            if isFullScreen then
                hs.timer.doAfter(0.6, function()
                    win:setFullScreen(true)
                end)
            end
        end)
    end
end

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "1", MoveWindowToDisplay(1))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "2", MoveWindowToDisplay(2))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "3", MoveWindowToDisplay(3))

-- hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "1", MoveWindowToDisplay(1))
-- hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "2", MoveWindowToDisplay(2))
-- hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "3", MoveWindowToDisplay(3))

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


-- hs.hotkey.bind({ "cmd", "alt", "shift" }, "k", function()
--     hs.eventtap.event.newScrollEvent({0, 100}, {}, "pixel"):post()
-- end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "c", function()
    local current_mouse_coordinates = hs.mouse.absolutePosition()
    hs.eventtap.leftClick(current_mouse_coordinates)
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "q", function()
    local app = hs.application.open("com.apple.QuickTimePlayerX")
    hs.timer.doAfter(0.5, function()
        app:selectMenuItem({ "File", "New Movie Recording" })
        hs.timer.doAfter(0.5, function()
            app:selectMenuItem({ "View", "Float on Top" })
            hs.timer.doAfter(0.5, function()
                hs.eventtap.keyStroke({ "ctrl", "option" }, "g") -- one thirds of the screen (via magnet)
            end)
        end)
    end)
end)

hs.alert.show("Config loaded!")
