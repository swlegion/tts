require('!/CommandTray')

function onload()
  local colorSide = "blue"
  local splitButton = getObjectFromGUID("af10b9")
  local stackButton = getObjectFromGUID("ff8c41")
  local shuffleButton = getObjectFromGUID("25c9b2")
  onLoadShared(colorSide, splitButton, stackButton, shuffleButton)
end
