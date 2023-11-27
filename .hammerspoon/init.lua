# Hyperkey + R -> Alacritty
hs.hotkey.bind({"cmd,ctrl,alt,shift"}, "r", function()
  local alacritty = hs.application.get('Alacritty')

  if (alacritty ~= nil and alacritty:isFrontmost()) then
    alacritty:hide()
  else
    hs.application.launchOrFocus("/Applications/Alacritty.app")
  end
end)
