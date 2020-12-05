-- Supply card deck.

-- Used when spawned by the define battlefield workflow.
position = {x = 49.7052612304688, y = 1.14271783828735, z = 7.942626953125}
rotation = {x = -0.00090670125791803, y = 179.990127563477, z = 175.054901123047}

-- Auto-shuffle.
function onLoad()
  self.shuffle()
  self.shuffle()
  self.shuffle()
end


