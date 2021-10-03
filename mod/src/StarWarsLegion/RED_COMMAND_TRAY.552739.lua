require('!/CommandTray')

function onload()
  local colorSide = "red"
  local splitButton = getObjectFromGUID("4d88f4")
  local stackButton = getObjectFromGUID("5881eb")
  local shuffleButton = getObjectFromGUID("9bfc69")
  onLoadShared(colorSide, splitButton, stackButton, shuffleButton)
end
