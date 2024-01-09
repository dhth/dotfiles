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

function moveWindowToDisplay(d, fullScreen)
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

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "1", moveWindowToDisplay(1, true))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "2", moveWindowToDisplay(2, true))
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "3", moveWindowToDisplay(3, true))

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "1", moveWindowToDisplay(1))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "2", moveWindowToDisplay(2))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "3", moveWindowToDisplay(3))

hs.alert.show("Config loaded!")
