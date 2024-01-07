-- widescreen monitor
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "2", function()
    local laptopScreen = "LC34G55T"
    local windowLayout = {
        {"Brave Browser", nil,          laptopScreen, hs.layout.left50,    nil, nil},
        {"Zoom", nil,          laptopScreen, hs.layout.left50,    nil, nil},
        {"Slack",     nil,          laptopScreen, hs.layout.right50,   nil, nil},
        {"Alacritty",     nil,          laptopScreen, hs.layout.right50,   nil, nil},
    }
    hs.layout.apply(windowLayout)
end)

-- widescreen monitor
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "3", function()
    local laptopScreen = "LC34G55T"
    local windowLayout = {
        {"Brave Browser", nil,          laptopScreen, hs.layout.left30,    nil, nil},
        {"Alacritty",     nil,          laptopScreen, hs.layout.right70,   nil, nil},
    }
    hs.layout.apply(windowLayout)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "r", function()
  hs.reload()
end)

hs.alert.show("Config loaded!")

